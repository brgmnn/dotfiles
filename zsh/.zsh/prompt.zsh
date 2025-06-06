#!/bin/zsh

if [ -f $HOME/.LS_COLORS ]; then
    export __ZSH_DIR=`awk '/^DIR/{print $NF}' $HOME/.LS_COLORS \
            | awk -F';' '{ print (NF>2 ? $3 : $1); }' -`
fi

#       Prompt
# Configure the left and right prompt
PROMPT='%(!.%F{1}%B.)%n%b%f %B%m%b %F{'$__ZSH_DIR'}%~%f%(!..)
 %(?..%F{red}%?%f )'$(echo "\u00bb")' '

RPROMPT='${vcs_info_msg_0_} ${ZSH_DOTENV_ENVIRONMENT} ${ZSH_AWS_PROFILE}'
