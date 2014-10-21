# run a system wide bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export EDITOR=vim
export TERM=screen-256color

PATH=$PATH:~/.bin

alias ls='ls --color=auto'
alias ll='ls -lha'

# Run .bashrc.local last if the file exists. This script holds commands that
# are only relevant locally.
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
