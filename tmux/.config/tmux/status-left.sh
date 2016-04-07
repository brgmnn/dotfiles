#!/bin/bash

. ~/.config/tmux/status-shared.sh

function msg_a() {
    color_primary
    case "$cmd" in
        docker*) printf ' docker ';;
        ssh)     printf ' remote ';;
        *)       printf ' local  ';;
    esac
    color_off
}

function msg_b() {
    color_secondary

    case "$cmd" in
        docker*) user=`whoami`;;
        ssh)     user=`whoami | sed 's/./-/g'`;;
        *)       user=`whoami`;;
    esac

    printf ' %s ' $user
    color_off
}

msg_a
msg_b
