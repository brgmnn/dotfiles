#!/bin/zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle git
# antigen bundle svn

antigen bundle nvm

# Pretty time
#antigen bundle sindresorhus/pretty-time-zsh

# Autoenv, directory specific environments.
antigen bundle Tarrasch/zsh-autoenv


antigen apply
