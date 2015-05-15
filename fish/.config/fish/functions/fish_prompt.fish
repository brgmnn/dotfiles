# Prompt for the left side
function fish_prompt --description "Write out the prompt"

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname \
                (set_color --bold)(hostname|cut -d . -f 1)(set_color normal)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        echo -n -s "$USER" @ "$__fish_prompt_hostname $__fish_prompt_cwd" \
                (prompt_pwd) "$__fish_prompt_normal" '# '

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        echo -s "$USER $__fish_prompt_hostname $__fish_prompt_cwd" \
                (prompt_pwd) "$__fish_prompt_normal"
        echo " -- "

    end
end

function _git_dirty
    echo (command git status -s ^/dev/null)
end

function _git_branch_name
    echo -n (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')

    if [ (_git_dirty) ]
        echo (set_color $fish_color_status)"*"(set_color normal)
    else
        echo " "
    end
end

# Prompt for the right side
function fish_right_prompt --description "Write out the right side prompt"
    echo -s "git " (prompt_pwd) " " (_git_branch_name)
end
