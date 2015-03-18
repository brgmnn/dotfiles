# Lines configured by zsh-newuser-install
bindkey -v
setopt extendedglob notify
zstyle :compinstall filename '~/.zshrc'


# Autoloads
autoload -Uz compinit && compinit
autoload -U colors && colors
zstyle ":completion:*" menu select

# Load 256 colours.
[[ -r ~/.zsh/colors.zsh ]] && source ~/.zsh/colors.zsh

# Load and run the vcs_info commands.
[[ -r ~/.zsh/vcs_info.zsh ]] && source ~/.zsh/vcs_info.zsh


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


#       Prompt
# Configure the left and right prompt
source ~/.zsh/prompt.zsh


#       Changing Directories
# Change directory even if `cd` is omitted and the command is a valid
# directory.
setopt autocd
setopt cdable_vars


#       Completion
# Auto complete. Use the colours used by `ls` for tab completion.
setopt complete_aliases
setopt always_to_end
setopt auto_remove_slash
setopt list_packed
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


#       History
# Ignore repeated, space-started, and casual commands. Enable multiline
# historization as a single line. Enable appending to the history file.
# Ignore sequential duplicates. Increase the size of the history file.
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks


#       Input/Output
# Allow spell checking on commands and easier redirection for file creation
# and truncation. No annoying flow control. Hash command locations. Query the
# user before trying to remove a path with a *.
setopt clobber
setopt correct
setopt no_flow_control
setopt hash_cmds
setopt no_rm_star_silent


#       Job Control
# When listing jobs, be verbose.
setopt long_list_jobs


#       Scripts and Functions
# Use C language style bases for hex and octal numbers and use C language
# style precedence rules for operators. Use parenthesis if writing scripts to
# ensure shell compatibility.
setopt c_bases
setopt c_precedences


# Source keybindings, aliases and suffix aliases
[[ -r ~/.zsh/key-bindings.zsh ]] && source ~/.zsh/key-bindings.zsh
[[ -r ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -r ~/.zsh/autocomplete.zsh ]] && source ~/.zsh/autocomplete.zsh
[[ -r ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh

# Source local .zshrc
if [ -r ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
