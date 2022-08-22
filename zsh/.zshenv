#       Environment variables
export EDITOR=vim
export BROWSER=firefox
export PLAYER=mpv
export CC=clang
export CXX=clang++
export SHELL=`which zsh`
export LD_LIBRARY_PATH=/usr/local/lib

if [ -r ~/.cargo/env ]; then
    source "$HOME/.cargo/env"
fi

# Source local environment variables file
if [ -r ~/.zshenv.local ]; then
    source ~/.zshenv.local
fi
