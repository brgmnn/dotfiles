function ls --description "List contents of a directory."
    if which gls >/dev/null ^&-
        command gls --color=auto -F --group-directories-first $argv
    else
        command ls --color=auto -F --group-directories-first $argv
    end
end
