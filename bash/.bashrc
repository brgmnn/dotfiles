# run a system wide bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Auto "cd" when entering just a path.
shopt -s autocd
shopt -s checkwinsize
shopt -s extglob

# Export some variables
export EDITOR=vim
export BROWSER=firefox
export GREP_OPTIONS="--color=auto"
#export TERM=screen-256color

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'


# Software development environment variables.
export CC=clang
export CXX=clang++

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

#       Aliases
# Import aliases.
if [ -f ~/.bash/aliases ]; then
    . ~/.bash/aliases
fi

#       Local
# Run .bashrc.local last if the file exists. This script holds commands that
# are only relevant locally.
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
