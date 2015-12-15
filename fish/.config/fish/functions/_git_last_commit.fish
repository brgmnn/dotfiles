function _git_last_commit --description "Prints the last git commit hash."
    if set -l commit (command git log -1 --pretty=format:%h ^&-)
        echo -n -s (set_color $fish_color_quote)$commit \
                (set_color normal)
    else
        echo -n -s (set_color $fish_color_error)"empty" \
                (set_color normal)
    end
end
