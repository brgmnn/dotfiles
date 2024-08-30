#!/bin/zsh

#       Aliases
# Simple aliases which are useful. Longer aliases should be converted to their
# own scripts and placed in the .bin folder.

# Colour ls as well as provide more detailed version `ll`.
alias ls='ls --color=auto -F --group-directories-first'
alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lAh'
alias lsd='ls -d .*'
alias lld='ll -lh -d .*'

# Colour matches in Greps output
alias grep='grep --color=auto'

# When passing multiple files to Vim, open them in new tabs.
alias vim='vim -p'

# Allow aliases to be sudo'ed.
alias sudo='sudo '

# Returns the current external IP address.
alias ip='curl curlmyip.com'

# Gets the total size of a directory.
alias dut='du -ch | tail -1'

# Added this as a fix for the autoenv Zsh plugin.
alias shasum='sha256sum'

# A simple stopwatch timer.
alias timer='echo "Timer started. Stop with Ctrl-D." \
        && date && time cat && date'

# URL encode a string
alias urlencode='python -c "import sys, urllib; \
        print urllib.quote_plus(sys.argv[1]);"'

# Docker
alias dc='docker-compose'

# Kubernetes
alias k='kubectl'

# Localstack AWS CLI
alias awsl='aws --endpoint-url=http://localhost:4566'

# Curl aliases that masquerade as internet explorer/firefox.
alias iecurl='curl -H "User-Agent: Mozilla/5.0 (Windows; U; MSIE 6.0; \
        Windows NT 5.1; SV1; .NET CLR 2.0.50727)"'
alias ffcurl='curl -H "User-Agent: Mozilla/5.0 (Windows; U; \
        Windows NT 5.1; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.0 \
        (.NET CLR 3.5.30729)"'
