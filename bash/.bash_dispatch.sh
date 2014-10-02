#!/bin/bash

# Launch different bash configuration for Linux vs OSX, interactive vs batch
#
# More info at https://github.com/gioele/bashrc_dispatch
#
# License: Public Domain.
# Author:  Joseph Wecker, 2012

# Configuration
# -------------
#
# EXPORT_FUNCTIONS: export SHELL_PLATFORM and shell_is_* functions for use
#                   in other scripts.

EXPORT_FUNCTIONS=true


# Code
# ----

# Avoid recursive invocation

[ -n "$BASHRC_DISPATCH_PID" ] && [ $$ -eq "$BASHRC_DISPATCH_PID" ] && exit
BASHRC_DISPATCH_PID=$$


# Setup the main shell variables and functions

SHELL_PLATFORM='OTHER'
case "$OSTYPE" in
  *'linux'*   ) SHELL_PLATFORM='LINUX' ;;
  *'darwin'*  ) SHELL_PLATFORM='OSX' ;;
  *'freebsd'* ) SHELL_PLATFORM='BSD' ;;
esac

if ! type -p shell_is_login ; then
  shell_is_linux       () { [[ "$OSTYPE" == *'linux'* ]] ; }
  shell_is_osx         () { [[ "$OSTYPE" == *'darwin'* ]] ; }
  shell_is_login       () { shopt -q login_shell ; }
  shell_is_interactive () { test -n "$PS1" ; }
  shell_is_script      () { ! shell_is_interactive ; }
fi


# Make $BASH_ENV the same in interactive and non-interactive scripts

[ -z "$BASH_ENV" ] && export BASH_ENV="$BASH_SOURCE"


# Now dispatch special files

[ -f "${HOME}/.bashrc_all" ]                                 && . "${HOME}/.bashrc_all"
[ -f "${HOME}/.bashrc_script" ]      && shell_is_script      && . "${HOME}/.bashrc_script"
[ -f "${HOME}/.bashrc_interactive" ] && shell_is_interactive && . "${HOME}/.bashrc_interactive"
[ -f "${HOME}/.bashrc_login" ]       && shell_is_login       && . "${HOME}/.bashrc_login"


# Export or unset functions and shell variables

if $EXPORT_FUNCTIONS ; then
  fn_cmd='export'
else
  fn_cmd='unset'
fi

$fn_cmd SHELL_PLATFORM
$fn_cmd -f shell_is_linux
$fn_cmd -f shell_is_osx
$fn_cmd -f shell_is_login
$fn_cmd -f shell_is_interactive
$fn_cmd -f shell_is_script


# Unset local variables

unset fn_cmd

unset EXPORT_FUNCTIONS
unset BASHRC_DISPATCH_PID
