#!/bin/zsh

#       Aliases
# Simple aliases which are useful. Longer aliases should be converted to their
# own scripts and placed in the .bin folder.

# Colour ls as well as provide more detailed version `ll`.
alias ls="ls --color=auto -F --group-directories-first"
alias ll="ls -lh"
alias la="ls -A"
alias lla="ls -lAh"
alias lsd="ls -d .*"
alias lld="ll -lh -d .*"

# When passing multiple files to Vim, open them in new tabs.
alias vim='vim -p'

# Allow aliases to be sudo'ed.
alias sudo='sudo '

# Returns the current external IP address.
alias ip='curl curlmyip.com'

# Gets the total size of a directory.
alias dut='du -ch | tail -1'

# A simple stopwatch timer.
alias timer='echo "Timer started. Stop with Ctrl-D." \
        && date && time cat && date'

# URL encode a string
alias urlencode='python -c "import sys, urllib; \
        print urllib.quote_plus(sys.argv[1]);"'

