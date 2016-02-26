function docker
    if set -q TMUX
        set -l subcmd exec logs attach

        if contains $argv[1] $subcmd
            tmux select-pane -P 'bg=colour233'
        end
    end

    command docker $argv

    if set -q TMUX
        tmux select-pane -P 'bg=black'
    end
end
