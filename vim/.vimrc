" ignore files with these extensions
set wildignore=*.o,*.exe,*.pyc

" line numbers
set number

set ai
set wrap

" turn on syntax highlighting
syntax on

" Set line break and column break at
"set lbr
"set tw=100

set background=dark

" configure tabbing in vim to be 4 spaces with automatic indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set smartindent

" match trailing whitespace as an error
match ErrorMsg '\s\+$'

filetype indent plugin on

au BufRead *.tex setlocal spell spelllang=en_gb
