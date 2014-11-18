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
