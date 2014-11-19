#!/bin/zsh


function color_ls() {
    #print -P "%F{red} hello %f"
    for code in {00..255}; do
        print -P "$code: %F{$code}$ZSH_SPECTRUM_TEXT %f"
    done
}
