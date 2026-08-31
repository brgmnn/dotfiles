#!/bin/sh
# Set a pane's background from what's running in it.
#
# Two modes:
#   pane-bg.sh <pane-id> <cmd> <tty> <current-style>   one pane (the hooks' path)
#   pane-bg.sh                                        every pane (prefix + R)
#
# Invoked from hooks in ~/.tmux.conf as:
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

# run-shell inherits the tmux server's PATH, which does not necessarily include
# Homebrew; without this, `tmux` is not found and every set silently does nothing.
PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH

SSH_BG="bg=#111111"
CLAUDE_BG="bg=#111611"

apply() {
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
    [ "$current" = "$want" ] && return 0

    tmux set -p -t "$pane" window-style "$want"
}

if [ $# -eq 0 ]; then
    # Sweep every pane. Hooks only ever fire for one pane at a time, so panes that
    # were already open when something changed elsewhere need this to catch up.
    tmux list-panes -a \
        -F '#{pane_id} #{pane_current_command} #{pane_tty} #{window-style}' |
    while read -r a b c d; do
        apply "$a" "$b" "$c" "$d"
    done
elif [ $# -eq 4 ] && [ "${1#%}" != "$1" ]; then
    apply "$1" "$2" "$3" "$4"
fi
# Anything else means the caller expanded its formats where there was no pane in
# context: the empty args collapse under word splitting, so $1 is not a %N pane
# id. Nothing to paint — exit 0 rather than erroring on a bogus target.
