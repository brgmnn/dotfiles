#!/bin/sh
# Set a pane's background from what's running in it.
#
# Three modes:
#   pane-bg.sh <pane-id> <cmd> <tty> <current-style>   one pane (the hooks' path)
#   pane-bg.sh                                         every pane (prefix + R)
#   pane-bg.sh --tick                                  every pane, throttled
#
# Invoked from hooks in ~/.tmux.conf as:
#   run-shell -b "~/.config/tmux/pane-bg.sh #{pane_id} #{pane_current_command} #{pane_tty} #{window-style}"
#
# and, for --tick, from a #() job in status-right.
#
# Why a script rather than a .conf sourced by the hooks: these hooks fire on every
# window rename, and an interactive zsh prompt renames the window on every prompt
# (it shells out to git), so a `source-file` per fire quickly trips tmux's
# "Too many nested files" limit and spams the message line.
#
# Why the tick exists: tmux has no "the process in this pane changed" event.
# window-renamed was standing in for one, but it only fires while the window's
# automatic-rename is on — and tmux turns that off permanently for any window you
# rename by hand. In a manually-named window, starting Claude and staying in the
# pane then repaints nothing: after-split-window already fired while the pane was
# still a shell, and pane-focus-in only fires when you switch *into* a pane. The
# status line re-runs its #() jobs on every redraw, which gives us a timer.
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

TICK_SECONDS=3
STAMP=${TMPDIR:-/tmp}/tmux-pane-bg.tick

apply() {
    pane=$1
    cmd=$2
    tty=$3
    current=$4

    case $cmd in
        *ssh*)
            want=$SSH_BG
            ;;
        zsh|-zsh)
            # Sitting at a prompt: nothing is running in the foreground, so skip
            # the ps entirely. This is what keeps the tick cheap — idle panes are
            # the common case and now cost no fork at all. Only the login shell
            # is listed: safehouse-launched Claude panes report `bash`, because
            # launch-claude.sh is a bash script, so bash must NOT be here.
            want=none
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

sweep() {
    # Every pane. Hooks only ever fire for one pane at a time, so panes that were
    # already open when something changed elsewhere need this to catch up.
    tmux list-panes -a \
        -F '#{pane_id} #{pane_current_command} #{pane_tty} #{window-style}' |
    while read -r a b c d; do
        apply "$a" "$b" "$c" "$d"
    done
}

case ${1:-} in
    --tick)
        # tmux re-runs the status-right #() job on each redraw, i.e. once a
        # second at the current status-interval. Throttle to one sweep per
        # TICK_SECONDS. The stamp is written before sweeping so two attached
        # clients racing here cost at most one extra sweep. Prints nothing: the
        # output of a #() job is rendered into the status bar.
        now=$(date +%s)
        last=$(cat "$STAMP" 2>/dev/null) || last=0
        if [ $(( now - ${last:-0} )) -ge $TICK_SECONDS ]; then
            echo "$now" > "$STAMP"
            sweep
        fi
        exit 0
        ;;
esac

if [ $# -eq 0 ]; then
    sweep
elif [ $# -eq 4 ] && [ "${1#%}" != "$1" ]; then
    apply "$1" "$2" "$3" "$4"
fi
# Anything else means the caller expanded its formats where there was no pane in
# context: the empty args collapse under word splitting, so $1 is not a %N pane
# id. Nothing to paint — exit 0 rather than erroring on a bogus target.
