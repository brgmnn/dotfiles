function _svn_revision --description "Returns the current SVN revision number."
    echo -ns (set_color $fish_color_quote) \
            (svn info | grep "Revision" | sed -e 's/Revision: //') \
            (set_color normal)
end

function _svn_branch_name --description "Returns the current SVN branch name."
    echo -ns (set_color blue)(svn info | sed -n "/URL:/s/.*\///p") \
            (set_color normal)
end

function _svn_dirty --description "Returns how many files are changed/added/removed."
    set -l edits (svn status -q | grep '^M\|^D\|^A' | wc -l)
    if test $edits -gt 0
        echo -n (set_color $fish_color_status)"$edits*"(set_color normal)
    end
end

