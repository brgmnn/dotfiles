# run a system wide bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export EDITOR=vim
export TERM=screen-256color
export BROWSER=firefox

export GREP_OPTIONS="--color=auto"

PATH=$PATH:~/.bin

alias ls='ls --color=auto'
alias ll='ls -lha'


#       History
# Ignore repeated, space-started, and casual commands. Enable multiline
# historization as a single line. Enable appending to the history file.
# Ignore sequential duplicates. Increase the size of the history file.
export HISTIGNORE="&:[ ]*:l[sl]:[bf]g:exit"
shopt -s cmdhist
shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=10000


#       Local
# Run .bashrc.local last if the file exists. This script holds commands that
# are only relevant locally.
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
