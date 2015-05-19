# Environment variables
set -x EDITOR vim
set -x BROWSER firefox
set -x PLAYER mpv
set -x CC clang
set -x CXX clang++

set -x LD_LIBRARY_PATH /usr/local/lib

#dircolors ~/.dir_colors
#set -x LS_COLORS (dircolors ~/.dir_colors | sed -e '1!d' -e "s/LS_COLORS='//" -e "s/:';//")

set -x LS_COLORS (dircolors ~/.LS_COLORS | sed -e '1!d' -e "s/LS_COLORS='//" -e "s/:';//")

# Source local environment variables file
source ~/.fishenv.local ^&-
