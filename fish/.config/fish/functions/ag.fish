function ag --description "Ag, the silver surfer."
    command ag --color-path '38;5;121' --color-line-number '38;5;39' \
            --color-match '30m[48;5;154' $argv
end

function Ag --description "Ag, the silver surfer."
    ag $argv
end
