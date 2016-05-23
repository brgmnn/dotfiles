" Load vimrc.
if filereadable(glob('$HOME/.vimrc'))
    source $HOME/.vimrc
endif


"           Plugins
"------------------------------------------------------------------------------
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }


"           Plugin Settings
"------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1

" NeoVim ShaDa file, cannot be the same as the viminfo file as the formats have
" been changed.
set shada='10,\"100,:20,%,n~/.config/nvim/.shada
