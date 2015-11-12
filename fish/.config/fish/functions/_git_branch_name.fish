function _git_branch_name --description "Prints out the current git branch."
    if not set -q __fish_git_branch_color
        set -g __fish_git_branch_color (set_color $fish_color_command)
    end

    echo -n $__fish_git_branch_color
    echo -n (command git symbolic-ref HEAD ^&- | sed -e 's|^refs/heads/||')
    echo -n $__fish_prompt_normal
end
