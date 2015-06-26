# run a system wide bashrc
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Auto "cd" when entering just a path.
shopt -s autocd
shopt -s checkwinsize
shopt -s extglob

# Export some variables
export EDITOR=vim
export BROWSER=firefox
export PLAYER=mpv
#export TERM=screen-256color

# Set up dir colors to color the output of ls
eval "$(dircolors $HOME/.LS_COLORS)"

# Software development environment variables.
export CC=clang
export CXX=clang++

PATH=$HOME/.bin:$PATH


#       History
# Ignore repeated, space-started, and casual commands. Enable multiline
# historization as a single line. Enable appending to the history file.
# Ignore sequential duplicates. Increase the size of the history file.
export HISTIGNORE="&:[ ]*:l[sl]:[bf]g:exit"
shopt -s cmdhist
shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=10000

#       Prompt
# Set up the prompt
if [ -f $HOME/.bash/prompt.sh ]; then
    source $HOME/.bash/prompt.sh
fi

#       Aliases
# Import aliases.
if [ -f $HOME/.bash/aliases.sh ]; then
    source $HOME/.bash/aliases.sh
fi

#       Local
# Run .bashrc.local last if the file exists. This script holds commands that
# are only relevant locally.
if [ -f $HOME/.bashrc.local ]; then
    source $HOME/.bashrc.local
fi
