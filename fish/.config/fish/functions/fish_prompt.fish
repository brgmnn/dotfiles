# Prompt for the left side
function fish_prompt --description "Write out the prompt"
    # return value of last command
    set -l ret $status

    # Prompt header background
    if not set -q __fish_prompt_bg
        set -g __fish_prompt_bg (set_color normal)(set_color -b 1a1a1a)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname \
                (set_color --bold)(hostname|cut -d . -f 1)$__fish_prompt_bg
    end

    # Generate a session string if we are in an SSH connection.
    if not set -q __fish_prompt_session
        if set -q SSH_CLIENT; or set -q SSH_TTY; or true
            set -g __fish_prompt_session (set_color 666666)"ssh:"$__fish_prompt_bg
        else
            set -g __fish_prompt_session ""
        end
    end

    # Print out duration of command if it's over a certain duration
    set -q CMD_DURATION; and test $CMD_DURATION -gt 4000; and begin
        set -l days    (math $CMD_DURATION / 86400000)
        set -l hours   (math $CMD_DURATION / 3600000 \% 24)
        set -l minutes (math $CMD_DURATION / 60000 \% 60)
        set -l seconds (math $CMD_DURATION / 1000 \% 60)
        set    days    (test $CMD_DURATION -gt 86399999; and echo $days"d "; \
                or echo "")
        set    hours   (test $CMD_DURATION -gt 3599999; and echo $hours"h "; \
                or echo "")
        set    minutes (test $CMD_DURATION -gt 59999; and echo $minutes"m "; \
                or echo "")
        set    seconds (test $CMD_DURATION -gt 59999; and echo $seconds"s"; \
                or echo "$seconds."(math $CMD_DURATION / 100 \% 10)"s")

        echo -s " "$__fish_prompt_bg(set_color 666666) \
                " took $days$hours$minutes$seconds "$__fish_prompt_normal
    end

    if set -q TMUX
        echo -s $__fish_prompt_bg" "$__fish_prompt_session \
                $__fish_prompt_cwd(prompt_long_pwd)" "$__fish_prompt_normal
    else
        echo -s $__fish_prompt_bg(set_color $fish_color_user)$USER \
                $__fish_prompt_bg" "$__fish_prompt_session \
                $__fish_prompt_hostname" "$__fish_prompt_cwd \
                (prompt_long_pwd)$__fish_prompt_bg\x1b'[K'
    end

    if test $ret -eq 0
        echo -s "$__fish_prompt_normal "\u00bb" "
    else
        echo -s "$__fish_prompt_normal "(set_color $fish_color_error) \
                \u00bb"$__fish_prompt_normal "
    end
end

# Prompt for the right side. Is hidden if the terminal is less than 70
# characters wide
function fish_right_prompt --description "Write out the right side prompt"
    if test $COLUMNS -gt 69
        begin
            # Git-SVN prompt
            set -q __fish_has_git;
            and _git_is_repo;
            and cat (git rev-parse --show-toplevel)"/.git/config" | grep -qs '^\[svn-remote';
            and echo -s "git-svn "(_gitsvn_revision)" "(_git_branch_name);
            and echo -s (_git_dirty)
        end
        or begin
            # Git Submodule prompt
            set -q __fish_has_git;
            and _git_is_submodule;
            and echo -s (_git_submodule_prompt)
        end
        or begin
            # Git prompt
            set -q __fish_has_git;
            and _git_is_repo;
            and echo -s (_git_repo_prompt)
        end
        or begin
            # SVN prompt
            set -q __fish_has_svn;
            and svn info >/dev/null ^&-;
            and echo -s "svn "(_svn_revision)" "(_svn_branch_name);
            and echo -s (_svn_dirty)
        end
    end
end
