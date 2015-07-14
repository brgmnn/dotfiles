#!/bin/bash

export __BASH_BOLD=`tput bold`
export __BASH_NORMAL=`tput sgr0`

if [ -f $HOME/.LS_COLORS ]; then
    export __BASH_DIR=`awk '/^DIR/{print $NF}' $HOME/.LS_COLORS`
else
    export __BASH_DIR=`tput sgr0`
fi

PS1="\u $__BASH_BOLD\h$__BASH_NORMAL \[\e["$__BASH_DIR"m\]\w$__BASH_NORMAL\n \302\273 "
