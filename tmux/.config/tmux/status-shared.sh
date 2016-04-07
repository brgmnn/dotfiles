#!/bin/bash

cmd=`tmux display-message -p -F "#{pane_current_command}"`
pid=`tmux display-message -p -F "#{pane_pid}"`

case "$cmd" in
    docker*)
        # Blues
        bg_primary='colour45'
        fg_primary='colour17'
        bg_secondary='colour27'
        fg_secondary='colour255'
        ;;
    ssh)
        bg_primary='colour93'
        fg_primary='colour255'
        bg_secondary='colour91'
        fg_secondary='colour255'

        bg_primary='colour255'
        fg_primary='colour92'
        bg_secondary='colour93'
        fg_secondary='colour255'
        ;;
    *)
        bg_primary='colour190'
        fg_primary='colour17'
        bg_secondary='colour240'
        fg_secondary='colour255'
        ;;
esac

function color_off() {
    printf '#[bg=colour234,fg=colour121,none]'
}

function color_primary() {
    printf '#[bg=%s,fg=%s,none]' $bg_primary $fg_primary
}

function color_secondary() {
    printf '#[bg=%s,fg=%s,none]' $bg_secondary $fg_secondary
}

function color_tertiary() {
    #printf '#[bg=%s,fg=%s,none]' 'colour234' 'colour238'
    printf '#[bg=%s,fg=%s,none]' 'colour1' 'colour238'
}
