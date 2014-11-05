set nocompatible

" ignore files with these extensions
set wildignore=*.o,*.exe,*.pyc

" line numbers
set number

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

" Fix color scheme problems
set t_Co=256
set background=dark
colorscheme BusyBee

" highlight the current line
"set cul
"hi CursorLine term=none cterm=none ctermbg=235 ctermfg=none

" leave 5 lines overlap when scrolling
set scrolloff=5
set sidescrolloff=5

" 1000 undo history
set undolevels=1000

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

" auto completion
set complete=.,w,b,u,U,t,i,d
set wildmode=longest,list,full
set wildignore+=*.d
set wildmenu

set showbreak=↳

" remove buffers when a tab is closed
set nohidden

" Automatically cd into the directory that the file is in
set autochdir

" Use two status lines
set laststatus=2

" match trailing whitespace as an error and remove it when reading/writing a
" file.
match ErrorMsg '\s\+$'
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Spell check .tex files.
autocmd BufNewFile,BufRead *.tex,*.txt setlocal spell spelllang=en_gb

" Vim backup and swap files.
set backup
set writebackup
set backupdir=~/.vim/backup//,/var/tmp,/tmp
set directory=~/.vim/backup//,/var/tmp,/tmp

" Syntax highlighting
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif

" Functions
function! Browser()
    let line = getline(".")
    let line = matchstr(line, "http[^   ]*")
    if line != ""
        silent exec "!$BROWSER ".line
        redraw!
    endif
endfunction

" Commands
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Fix some keys not working in screen.
map OH <Home>
map OF <End>
imap OH <Home>
imap OF <End>

" Disable Ex mode
nnoremap Q <nop>

" Load local vimrc.
if filereadable("~/.vimrc.local")
    source ~/.vimrc.local
endif
