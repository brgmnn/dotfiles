" Load vimrc.
if filereadable(glob("$HOME/.vimrc"))
    source $HOME/.vimrc
endif

" Set the shell to be the default shell of the user, useful for :terminal.
set shell=$SHELL

" NeoVim ShaDa file, cannot be the same as the viminfo file as the formats have
" been changed.
set shada='10,\"100,:20,%,n~/.config/nvim/.shada
