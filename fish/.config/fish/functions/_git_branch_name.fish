function _git_branch_name --description "Prints out the current git branch."
    if not set -q __fish_git_branch_color
        set -g __fish_git_branch_color (set_color $fish_color_command)
    end

    if set -l branch (command git symbolic-ref HEAD ^&-)
        echo -s $__fish_git_branch_color \
            (echo $branch | sed -e 's|^refs/heads/||') \
            $__fish_prompt_normal
    else
        echo -s (set_color $fish_color_error) \
            "detached" \
            (set_color $fish_color_normal)
    end
end
