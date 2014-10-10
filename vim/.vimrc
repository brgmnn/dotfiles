" ignore files with these extensions
set wildignore=*.o,*.exe,*.pyc

" line numbers
set number

" turn on syntax highlighting
syntax on

" Set line break and column break at 79 characters
"set lbr
set textwidth=79
set wm=0
set ruler
set formatoptions+=t

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%80v.*/
augroup END


" Turn on highlighting for search
set hlsearch

" adjust colours for a dark background terminal
set background=dark

" highlight the current line
"set cul
"hi CursorLine term=none cterm=none ctermbg=8

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

" match trailing whitespace as an error and remove it when reading/writing a
" file.
match ErrorMsg '\s\+$'
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

filetype indent plugin on

au BufRead *.tex setlocal spell spelllang=en_gb
