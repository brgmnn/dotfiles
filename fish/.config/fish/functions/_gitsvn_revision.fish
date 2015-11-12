function _gitsvn_revision
    echo -n -s (set_color $fish_color_quote) \
        (git log -1 | tail -1 | awk -F'@' '{print $2}' | awk '{print $1}') \
        (set_color normal)
end
