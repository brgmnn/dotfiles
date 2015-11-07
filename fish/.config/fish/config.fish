#       Environment variables
#-----------------------------------------------------------------------------
set -x EDITOR   vim
set -x BROWSER  firefox
set -x PLAYER   mpv
set -x CC       clang
set -x CXX      clang++

set -x LD_LIBRARY_PATH /usr/local/lib $LD_LIBRARY_PATH

# Source local environment variables file
if math (echo $FISH_VERSION | sed 's/\.//g') '>=220' >/dev/null ^&-
    source ~/.fishenv ^&-
else
    . ~/.fishenv ^&-
end


# Fundle
fundle init


# Set colors
set -U fish_color_autosuggestion   555
set -U fish_color_command          005fd7
set -U fish_color_comment          990000
set -U fish_color_cwd              87ffaf
set -U fish_color_cwd_root         red
set -U fish_color_end              009900
set -U fish_color_error            ff5f5f
set -U fish_color_escape           cyan
set -U fish_color_history_current  cyan
set -U fish_color_host             cyan
set -U fish_color_match            cyan
set -U fish_color_normal           normal
set -U fish_color_operator         cyan
set -U fish_color_param            00afff
set -U fish_color_quote            ffd700
set -U fish_color_redirection      00afff
set -U fish_color_search_match     --background=purple
set -U fish_color_selection        --background=purple
set -U fish_color_status           red
set -U fish_color_user             ffde99
set -U fish_color_valid_path       --underline


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
