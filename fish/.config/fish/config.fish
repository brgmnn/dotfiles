#       Environment variables
#-----------------------------------------------------------------------------
set -x EDITOR   vim
set -x BROWSER  firefox
set -x PLAYER   mpv
set -x CC       clang
set -x CXX      clang++

set -x LD_LIBRARY_PATH /usr/local/lib $LD_LIBRARY_PATH

set -x HOMEBREW_NO_ANALYTICS 1


# A fix for older versions of fish which don't have the source command.
if math (echo $FISH_VERSION | sed 's/\.//g') '<220' >/dev/null ^&-
    function source --description "Backwards compatible source shim for fish."
        . $argv
    end
end


# Abbreviations
abbr -a dc='docker-compose'
abbr -a gs='git status'
abbr -a gd='git diff'
abbr -a gc='git commit'
abbr -a ga='git add'
abbr -a gco='git checkout'
abbr -a gca='git commit --amend'
abbr -a gb='git branch -vv'


# Source local environment variables file
source ~/.fishenv ^&-


# Fundle
set -x fundle_plugins_dir ~/.config/fish/plugins

fundle plugin 'tuvistavie/fish-completion-helpers'
fundle plugin 'barnybug/docker-fish-completion'
fundle plugin 'brgmnn/fish-docker-compose'
fundle plugin 'brgmnn/fish-hyper'

fundle init


# Set colors
set -U fish_color_autosuggestion  555
# set -U fish_color_command         005fd7
set -U fish_color_command         61AFEF
set -U fish_color_comment         990000
set -U fish_color_cwd             87d787
set -U fish_color_cwd_root        red
set -U fish_color_end             009900
set -U fish_color_error           E06C75
set -U fish_color_escape          cyan
set -U fish_color_history_current cyan
set -U fish_color_host            cyan
set -U fish_color_match           cyan
# set -U fish_color_normal          normal
set -U fish_color_normal          ABB2BF
set -U fish_color_operator        cyan
# set -U fish_color_param           00afff
set -U fish_color_param           ffffff
# set -U fish_color_quote           ffd700
set -U fish_color_quote           E5C07B
set -U fish_color_redirection     00afff
set -U fish_color_search_match    --background=333333
set -U fish_color_selection       --background=purple
set -U fish_color_status          red
set -U fish_color_user            ffde99
set -U fish_color_valid_path      --underline


# Set the ls colors
set -x LS_COLORS (dircolors ~/.LS_COLORS | \
        sed -e '1!d' -e "s/LS_COLORS='//" -e "s/:';//")


# Set variables that mark if git and svn are installed.
if which git >/dev/null ^&-
    set -g __fish_has_git 1
end
if which svn >/dev/null ^&-
    set -g __fish_has_svn 1
end


# Source local fish configuration file
if math (echo $FISH_VERSION | sed 's/\.//g') '>=220' >/dev/null ^&-
    source ~/.fishrc ^&-
else
    . ~/.fishrc ^&-
end
