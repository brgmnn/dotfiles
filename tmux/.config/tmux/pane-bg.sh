#!/bin/sh
# Set one pane's background from what's running in it.
#
# Invoked from hooks in ~/.tmux.conf, once per pane:
#   run-shell -b "~/.config/tmux/pane-bg.sh #{pane_id} #{pane_current_command} #{pane_tty} #{window-style}"
#
# Why a script rather than a .conf sourced by the hooks: these hooks fire on every
# window rename, and an interactive zsh prompt renames the window on every prompt
# (it shells out to git), so a `source-file` per fire quickly trips tmux's
# "Too many nested files" limit and spams the message line.
#
# ssh wins over Claude: a pane on a remote host keeps the remote colour even if
# Claude Code is running there.
#
# Claude is matched on the argv of everything on the pane's tty, because
# #{pane_current_command} is unreliable here — the native installer runs
# ~/.local/share/claude/versions/<version> and so reports a bare version number
# ("2.1.247"), and panes launched through the safehouse sandbox wrapper report
# "bash". The pattern wants a real invocation, so panes that merely mention the
# word (rg claude, vim .../claude/foo.sh) are left alone. [c]laude keeps grep from
# matching its own process.

SSH_BG="bg=#111111"
CLAUDE_BG="bg=#111611"

pane=$1
cmd=$2
tty=$3
current=$4

case $cmd in
    *ssh*)
        want=$SSH_BG
        ;;
    *)
        if ps -o args= -t "${tty#/dev/}" 2>/dev/null |
                grep -qE '(^|/)[c]laude( |$)|/[c]laude-code/'; then
            want=$CLAUDE_BG
        else
            want=none
        fi
        ;;
esac

# Already right — skip the set so a rename storm causes no needless redraws.
[ "$current" = "$want" ] && exit 0

# run-shell inherits the tmux server's PATH, which does not necessarily include
# Homebrew; without this, `tmux` is not found and the set silently does nothing.
PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH
exec tmux set -p -t "$pane" window-style "$want"
