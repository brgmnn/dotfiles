#!/bin/bash

. ~/.config/tmux/status-shared.sh

function msg_a() {
    color_primary
    printf ' %s ' $(date '+%H:%M')
    color_off
}

function msg_b() {
    color_secondary

    case "$cmd" in
        docker*) host=`hostname | cut -d . -f 1`;;
        ssh)     host=`hostname | cut -d . -f 1 | sed 's/./-/g'`;;
        *)       host=`hostname | cut -d . -f 1`;;
    esac

    printf ' %s ' $host
    color_off
}

msg_b
msg_a
