function _git_dirty --description "Prints a short status string for how dirty a git repo is."
    set -l untracked (git status -s | grep '^??' | wc -l | tr -d '[[:space:]]')
    set -l modified  (git status -s | grep '^.M' | wc -l | tr -d '[[:space:]]')
    set -l staged    (git status -s | grep '^[ADM]' | wc -l | tr -d '[[:space:]]')

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
