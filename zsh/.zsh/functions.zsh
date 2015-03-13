#!/bin/zsh

# Web search from the command line.
[[ -r ~/.zsh/scripts/web-search.zsh ]] && source ~/.zsh/scripts/web-search.zsh

function color_ls() {
    #print -P "%F{red} hello %f"
    for code in {00..255}; do
        print -P "$code: %F{$code}$ZSH_SPECTRUM_TEXT %f"
    done
}
