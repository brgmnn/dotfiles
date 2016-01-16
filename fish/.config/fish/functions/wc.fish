function wc --description "Word count utility"
    if which gwc >/dev/null ^&-
        command gwc $argv
    else
        command wc $argv
    end
end
