function _git_dirty --description "Prints a short status string for how dirty a git repo is."
    set -l untracked (git status -s | grep '^??' | wc -l)
    set -l modified  (git status -s | grep '^.M' | wc -l)
    set -l staged    (git status -s | grep '^M' | wc -l)

    if test $untracked -gt 0
        echo -n (set_color dd0000)"$untracked?"(set_color normal)
    end

    if test $modified -gt 0
        echo -n (set_color ff9900)"$modified*"(set_color normal)
    end

    if test $staged -gt 0
        #echo -n (set_color $fish_color_user)"$staged+"(set_color normal)
        echo -n (set_color 00dd00)"$staged+"(set_color normal)
    end
end

function _git_branch_name --description "Prints out the current git branch."
    echo -n (set_color blue)
    echo -n (command git symbolic-ref HEAD ^&- | sed -e 's|^refs/heads/||')
    echo -n (set_color normal)
end

function _git_last_commit --description "Prints the last git commit hash."
    echo -ns (set_color $fish_color_quote)(git log -1 --pretty=format:%h) \
            (set_color normal)
end

function _gitsvn_revision
    echo -ns (set_color $fish_color_quote) \
        (git log -1 | tail -1 | awk -F'@' '{print $2}' | awk '{print $1}') \
        (set_color normal)
end

