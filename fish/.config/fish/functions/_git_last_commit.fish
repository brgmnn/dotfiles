function _git_last_commit --description "Prints the last git commit hash."
    echo -n -s (set_color $fish_color_quote)(git log -1 --pretty=format:%h) \
            (set_color normal)
end
