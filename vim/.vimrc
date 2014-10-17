set nocompatible

" ignore files with these extensions
set wildignore=*.o,*.exe,*.pyc

" line numbers
set number

" turn on syntax highlighting

" Set line break and column break at 78 characters
"set lbr
set textwidth=78
set wm=0
set ruler
set formatoptions+=t

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=233 guibg=#333333
  autocmd BufEnter * match OverLength /\%80v.*/
augroup END

" Turn on highlighting for search
set hlsearch

" adjust colours and syntax highlighting
filetype on
filetype plugin on
filetype plugin indent on
syntax enable
colorscheme BusyBee
"colorscheme jellybean

" highlight the current line
"set cul
"hi CursorLine term=none cterm=none ctermbg=235 ctermfg=none

" enable mouse support
set mouse=a

" configure tabbing in vim to be 4 spaces with automatic indentation
set ai
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set smartindent

" shows what you are typing as a command
set showcmd

" remove buffers when a tab is closed
set nohidden

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" match trailing whitespace as an error and remove it when reading/writing a
" file.
match ErrorMsg '\s\+$'
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

au BufRead *.tex setlocal spell spelllang=en_gb


" Commands
:command WQ wq
:command Wq wq
:command W w
:command Q q
