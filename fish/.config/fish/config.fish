#       Environment variables
#-----------------------------------------------------------------------------
set -x EDITOR   vim
set -x BROWSER  firefox
set -x PLAYER   mpv
set -x CC       clang
set -x CXX      clang++

set -x LD_LIBRARY_PATH /usr/local/lib $LD_LIBRARY_PATH

# Source local environment variables file
source ~/.fishenv ^&-


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
source ~/.fishrc ^&-
