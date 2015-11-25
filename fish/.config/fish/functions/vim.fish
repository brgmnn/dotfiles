function vim --description "Vim text editor."
    if which nvim >/dev/null ^&-
        command nvim -p $argv
    else
        command vim -p $argv
    end
end
