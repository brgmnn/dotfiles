function docker-compose
    if set -q TMUX
        set -l subcmd run

        if contains $argv[1] $subcmd
            tmux select-pane -P 'bg=colour233'
        end
    end

    command docker-compose $argv

    if set -q TMUX
        tmux select-pane -P 'bg=default'
    end
end
