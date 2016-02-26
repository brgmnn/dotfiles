function ssh
    if set -q TMUX
        tmux select-pane -P 'bg=colour233'
    end

    clear
    command ssh $argv

    if set -q TMUX
        tmux select-pane -P 'bg=black'
    end
end
