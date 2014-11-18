# Lines configured by zsh-newuser-install
bindkey -v
setopt autocd completealiases extendedglob notify
zstyle :compinstall filename '/home/dan/.zshrc'


# Autoloads
autoload -Uz compinit && compinit
autoload -U colors && colors
zstyle ":completion:*" menu select


# Load and run the vcs_info commands.
if [ -r ~/.zsh/vcs_info.zsh ]; then
    source ~/.zsh/vcs_info.zsh
fi


# Set up the path
typeset -U path
path=(~/.bin $path)


#       Environment variables
export EDITOR=vim
export BROWSER=firefox
export CC=clang
export CXX=clang++

export GREP_OPTIONS="--color=auto"
# ls colours. Plan to move these to .dircolors
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'


#       Antigen
# Use antigen script to load plugins and themes for zsh from github.
source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh
antigen bundle git
antigen bundle svn


# Set completion colours to those used by `ls`.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


#       Prompt
# Configure the left and right prompt
PROMPT="%n@%B%m%b:%~%(!.#.$) "
RPROMPT='${vcs_info_msg_0_} '


#       History
# Ignore repeated, space-started, and casual commands. Enable multiline
# historization as a single line. Enable appending to the history file.
# Ignore sequential duplicates. Increase the size of the history file.
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt HIST_IGNORE_DUPS


# Source aliases
if [ -r ~/.zsh/aliases.zsh ]; then
    source ~/.zsh/aliases.zsh
fi

# Source local .zshrc
if [ -r ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
