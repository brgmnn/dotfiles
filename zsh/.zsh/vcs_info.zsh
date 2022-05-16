#!/bin/zsh

#       VCS info
# Configures the vcs_info plugin which displays version control information in
# the prompt. In this case it is configured to show in the right hand prompt.

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr   '+'
zstyle ':vcs_info:*' formats \
    "%{$fg[blue]%}%b%{$reset_color%}%B%F{1}%u%f%F{2}%c%{$reset_color%} "

zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat \
    '%b%{'$reset_color'%}:%{'${fg[yellow]}'%}%r'
