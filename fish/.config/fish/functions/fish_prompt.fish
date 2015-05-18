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
                (prompt_long_pwd) "$__fish_prompt_normal" '# '

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        echo -s "$USER $__fish_prompt_hostname $__fish_prompt_cwd" \
                (prompt_long_pwd) "$__fish_prompt_normal"
        echo " -- "

    end
end

function _git_dirty --description "Prints a short status string for how dirty a git repo is."
    if git status -s ^&- | grep -q '^??'
        echo -n (set_color $fish_color_status)"?"(set_color normal)
    end

    if git status -s ^&- | grep -q '^ M'
        echo -n (set_color $fish_color_status)"*"(set_color normal)
    end

    if git status -s ^&- | grep -q '^A'
        echo -n (set_color $fish_color_user)"+"(set_color normal)
    end
end

function _git_branch_name --description "Prints out the current git branch."
    echo -n (set_color blue)
    echo -n (command git symbolic-ref HEAD ^&- | sed -e 's|^refs/heads/||')
    echo -n (set_color normal)

    echo (_git_dirty)
end

function _git_last_commit --description "Prints the last git commit hash."
    echo -ns (set_color $fish_color_quote)(git log -1 --pretty=format:%h) \
            (set_color normal)
end

function _svn_revision
    echo -ns (set_color $fish_color_quote) \
            (svn info | grep "Revision" | sed -e 's/Revision: //') \
            (set_color normal)
end

function _svn_branch_name
    echo -ns (set_color blue)(svn info | sed -n "/URL:/s/.*\///p") \
            (set_color normal)
end

# Prompt for the right side
function fish_right_prompt --description "Write out the right side prompt"
    if git status >&- ^&-
        echo -s "git " (_git_last_commit) " " (_git_branch_name)
    else if svn info >&- ^&-
        echo -s "svn " (_svn_revision) " " (_svn_branch_name)
    end
end
