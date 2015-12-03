" Load vimrc.
if filereadable(glob("$HOME/.vimrc"))
    source $HOME/.vimrc
endif

" NeoVim ShaDa file, cannot be the same as the viminfo file as the formats have
" been changed.
set shada='10,\"100,:20,%,n~/.config/nvim/.shada
