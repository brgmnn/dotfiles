function dircolors --description "Dir colors"
    if which gdircolors >/dev/null ^&-
        command gdircolors $argv
    else
        command dircolors $argv
    end
end
