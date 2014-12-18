#!/bin/zsh

#       Aliases
# Simple aliases which are useful. Longer aliases should be converted to their
# own scripts and placed in the .bin folder.

# Colour ls as well as provide more detailed version `ll`.
alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -lah"

# Allow aliases to be sudo'ed.
alias sudo='sudo '

# A simple stopwatch timer.
alias timer='echo "Timer started. Stop with Ctrl-D." \
        && date && time cat && date'

# URL encode a string
alias urlencode='python -c "import sys, urllib; \
        print urllib.quote_plus(sys.argv[1]);"'

