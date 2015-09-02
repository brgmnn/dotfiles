function source --description "Source a script file."
    if which source >/dev/null ^&-
        source $argv
    else
        . $argv
    end
end
