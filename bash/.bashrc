# run a system wide bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export EDITOR=vim

PATH=$PATH:~/.bin

alias ls='ls --color=auto'
alias ll='ls -lha'

# Work Specific
export IFC=gfortran
export XED=~/branches/dan-work/xed
export XED_LICENSE=~/.licenses
export BITS=64
export AMDAPPSDKROOT="/home/dan/amd-app-sdk/AMDAPPSDK-2.9-1"
export OPENCL_VENDOR_PATH="/home/dan/amd-app-sdk/AMDAPPSDK-2.9-1/etc/OpenCL/vendors/"
export LD_LIBRARY_PATH="/home/dan/amd-app-sdk/AMDAPPSDK-2.9-1/lib/x86_64/"
