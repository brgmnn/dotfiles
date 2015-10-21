# Prompt for the left side
function fish_prompt --description "Write out the prompt"
    # Prompt header background
    if not set -q __fish_prompt_bg
        set -g __fish_prompt_bg (set_color -b 1a1a1a)
    end

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname \
                (set_color --bold)(hostname|cut -d . -f 1)(set_color normal)$__fish_prompt_bg
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_session
        if set -q SSH_CLIENT; or set -q SSH_TTY; or true
            set -g __fish_prompt_session (set_color 666666)"ssh:"(set_color normal)$__fish_prompt_bg
        else
            set -g __fish_prompt_session ""
        end
    end

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)$__fish_prompt_bg
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)$__fish_prompt_bg
            end
        end

        echo -n -s "$USER" @ "$__fish_prompt_hostname $__fish_prompt_cwd" \
                (prompt_long_pwd) "$__fish_prompt_normal" '# '

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        echo -s (set_color -b 1a1a1a)"$USER $__fish_prompt_session$__fish_prompt_hostname $taken$__fish_prompt_cwd" \
                (prompt_long_pwd) "$__fish_prompt_normal$__fish_prompt_bg"\x1b'[K'

        echo "$__fish_prompt_normal "\u00bb" "

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
