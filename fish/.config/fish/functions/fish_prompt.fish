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

# Prompt for the right side
function fish_right_prompt --description "Write out the right side prompt"
    begin
        # Git-SVN prompt
        set -q __fish_has_git;
        and git status >/dev/null ^&-;
        and git rev-parse --show-toplevel >/dev/null ^&-;
        and cat (git rev-parse --show-toplevel)"/.git/config" | grep -qs '^\[svn-remote';
        and echo -s "git-svn "(_gitsvn_revision)" "(_git_branch_name);
        and echo -s (_git_dirty)
    end
    or begin
        # Git prompt
        set -q __fish_has_git;
        and git status >/dev/null ^&-;
        and echo -s "git "(_git_last_commit)" "(_git_branch_name);
        and echo -s (_git_dirty)
    end
    or begin
        # SVN prompt
        set -q __fish_has_svn;
        and svn info >/dev/null ^&-;
        and echo -s "svn "(_svn_revision)" "(_svn_branch_name);
        and echo -s (_svn_dirty)
    end
end
