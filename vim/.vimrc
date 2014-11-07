" Don't use VI compatibility mode.
set nocompatible


"           Formatting
"-----------------------------------------------------------------------------
" Set line break and column break at 78 characters
set lbr
set textwidth=78
set wm=0
set ruler
set formatoptions+=t

" configure tabbing in vim to be 4 spaces with automatic indentation
set ai
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set smartindent

set backspace=indent,eol,start


"           Color, Style and Syntax
"-----------------------------------------------------------------------------
filetype on
filetype plugin on
filetype plugin indent on
syntax enable

set t_Co=256
set background=dark
colorscheme rainbow_fruit

" Highlight trailing whitespace and long lines with the ErrorMsg coloring.
call matchadd("ErrorMsg", '\s\+$')
call matchadd("ErrorMsg", '\%80v.*')

" Turn on highlighting for search
set hlsearch

" highlight the current line
"set cul
"hi CursorLine term=none cterm=none ctermbg=235 ctermfg=none

" Use two status lines and set a custom line wrap character
set laststatus=2
set showbreak=↳

" have line numbers
set number

" leave 5 lines overlap when scrolling
set scrolloff=5
set sidescrolloff=5

" enable mouse support
set mouse=a


"           Auto-completion
"-----------------------------------------------------------------------------
" Shows what you are typing as a command. Automatically cd into the directory
" that the file is in
set showcmd
set autochdir

" auto completion
set complete=.,w,b,u,U,t,i,d
set wildmode=longest,list,full
set wildmenu

" ignore files with these extensions
set wildignore=*.a,*.d,*.exe,*.o,*.p,*.pyc,*.so


"           Backup, History and Swap
"-----------------------------------------------------------------------------
" 1000 undo history
set undolevels=1000

" backup and swap files.
set backup
set writebackup
set backupdir=~/.vim/backup//,/var/tmp//,/tmp//
set directory=~/.vim/backup//,/var/tmp//,/tmp//


"           Buffers and Tabs
"-----------------------------------------------------------------------------
" remove buffers when a tab is closed
set nohidden


"           Auto Commands
"-----------------------------------------------------------------------------
augroup vimrc_autocmd
    " Remove trailing whitespace from buffers when reading and writing.
    autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

    " Spell checking
    autocmd BufNewFile,BufRead *.tex,*.txt setlocal spell spelllang=en_gb

    " Set syntax highlighting for Nginx configuration files.
    autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*
            \ if &ft == '' | setfiletype nginx | endif

    " Long line highlighting
    "autocmd BufEnter * highlight OverLength ctermbg=233 guibg=#333333
    "autocmd BufEnter * match OverLength /\%80v.*/
augroup END


"           Functions
"-----------------------------------------------------------------------------
"       Browser()
" Opens a url on the current line in the users browser. The browser command is
" read from the $BROWSER environment variable.
function! Browser()
    let line = getline(".")
    let line = matchstr(line, "http[^   ]*")
    if line != ""
        silent exec "!$BROWSER ".line
        redraw!
    endif
endfunction


"           Commands
"-----------------------------------------------------------------------------
" Avoid easy typos with write and quit based on the shift key.
command! WQ wq
command! Wq wq
command! W w
command! Q q


"           Key Mappings
"-----------------------------------------------------------------------------
" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Fix some keys not working in screen.
map OH <Home>
map OF <End>
imap OH <Home>
imap OF <End>

" Disable Ex mode
nnoremap Q <nop>


"           Load local host settings
"-----------------------------------------------------------------------------
" Load local vimrc.
if filereadable("~/.vimrc.local")
    source ~/.vimrc.local
endif
