#!/bin/zsh

#       Prompt
# Configure the left and right prompt
PROMPT='%(!.%F{1}%B.)%n%b%f %B%m%b %~%(!..)
 -- '

RPROMPT='${vcs_info_msg_0_} '
