"           Initial Checks
"------------------------------------------------------------------------------
if exists('g:vimrc_loaded') | finish | endif
let g:vimrc_loaded = 1

if !has('nvim') | set nocompatible | endif
set shell=/bin/sh
filetype plugin indent on

"           Plugins
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugs')

Plug 'rking/ag.vim'
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'joshdick/onedark.vim'
Plug 'joshdick/airline-onedark.vim'

if v:version > 704 || has('nvim')
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
end

" Language Plugins
Plug 'artoj/qmake-syntax-vim'
Plug 'brgmnn/vim-opencl',         { 'for': 'opencl' }
Plug 'brgmnn/vim-syncthing'
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'cespare/vim-toml',          { 'for': 'toml' }
Plug 'dag/vim-fish',              { 'for': 'fish' }
Plug 'digitaltoad/vim-jade',      { 'for': 'jade' }
Plug 'ekalinin/Dockerfile.vim',   { 'for': 'Dockerfile' }
Plug 'elixir-lang/vim-elixir',    { 'for': 'elixer' }
Plug 'elzr/vim-json',             { 'for': 'json' }
Plug 'fatih/vim-go',              { 'for': 'go' }
Plug 'justinmk/vim-syntax-extra'
Plug 'kchmck/vim-coffee-script',  { 'for': 'coffee' }
Plug 'mxw/vim-jsx'
Plug 'ngmy/vim-rubocop',          { 'for': 'ruby' }
Plug 'pangloss/vim-javascript',   { 'for': 'javascript' }
Plug 'plasticboy/vim-markdown',   { 'for': 'markdown' }
Plug 'rust-lang/rust.vim',        { 'for': 'rust' }
Plug 'scrooloose/syntastic'
Plug 'tmatilai/vim-monit',        { 'for': 'monitrc' }
Plug 'todesking/vint-syntastic',  { 'for': 'vim' }
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-liquid',          { 'for': 'liquid' }
Plug 'tpope/vim-rails',           { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby',         { 'for': 'ruby' }

" CSS and SCSS language plugin
if v:version < 704 && !has('nvim')
    Plug 'JulesWang/css.vim'
endif

" This is ugly but I don't know how else we can load plugins in several
" locations.
if filereadable(glob('$HOME/.config/nvim/plugins.vim'))
    source $HOME/.config/nvim/plugins.vim
endif

call plug#end()


"           Plugin Settings
"------------------------------------------------------------------------------
" One Dark
let g:onedark_terminal_italics = 0

" Airline (modifies vims statusline)
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_exclude_preview = 1
let g:airline_section_z = '%3p%% %3v'
let g:airline_mode_map = {'c': 'C ', 'i': 'I ', 'n': 'N ', 'v': 'V ',
        \ 'R': 'R ', 'V': 'VL', '' : 'VB' }
let g:airline_theme = 'onedark'

" Syntastic
let g:syntastic_check_on_open        = 1
let g:syntastic_check_on_wq          = 0
let g:syntastic_aggregate_errors     = 1
let g:syntastic_error_symbol         = '✗'
let g:syntastic_warning_symbol       = '?'
let g:syntastic_style_error_symbol   = '✗'
let g:syntastic_style_warning_symbol = '?'
let g:syntastic_stl_format           = '✗ %F#%t'

if filereadable(glob('$HOME/.vim/syntax-checkers.vim'))
    source $HOME/.vim/syntax-checkers.vim
endif

" delimitMate
let g:delimitMate_expand_cr = 1

" Git Gutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '*'

" NerdTree
let g:NERDTreeWinSize=50
let g:NERDTreeShowHidden=0

" CtrlP
let g:ctrlp_working_path_mode = 'ra'

" RuboCop
let g:vimrubocop_config = '$HOME/.vim/rubocop.yml'


"           Spelling
"------------------------------------------------------------------------------
"set spell
set spelllang=en_gb
set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.en.local.utf-8.add

if empty(glob('$HOME/.vim/spell/en.utf-8.add.spl'))
    silent! mkspell $HOME/.vim/spell/en.utf-8.add
endif
if filereadable(glob('$HOME/.en.local.utf-8.add'))
    if empty(glob('$HOME/.en.local.utf-8.add.spl'))
        silent! mkspell $HOME/.vim/spell/en.local.utf-8.add
    endif
endif


"           View
"------------------------------------------------------------------------------
" Enable spell checking on comments, Unix line endings, better consistency
" with editing at the end of lines.
set viewoptions=cursor,slash,unix
set virtualedit=onemore
set showmode
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

" Show matching braces/brackets, enable folding and when splitting the window,
" put the new window to the right/below the current one. Remove hidden
" buffers.
set showmatch
set foldenable
set splitright
set splitbelow
set nohidden

" Helps with some bugs.
set ttyfast
set lazyredraw


"           Formatting
"------------------------------------------------------------------------------
" Set line break and column break at 80 characters
set wrap
set linebreak
set textwidth=80
set wrapmargin=0
set formatoptions+=t

" configure tabbing in Vim to be 4 spaces with automatic indentation
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set smartindent

" Better backspacing and F12 to toggle paste mode on/off.
set backspace=indent,eol,start
set pastetoggle=<F12>

if !has('gui_running')
    set clipboard=unnamedplus
endif

" File formatting
if has('multi_byte')
    if &termencoding ==? ''
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    scriptencoding utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif


"           Color, Style and Syntax
"------------------------------------------------------------------------------
syntax enable
set background=dark
colorscheme onedark

" Turn on highlighting for search, match the search term as it is typed.
set hlsearch
set incsearch

" Use two status lines and set a custom line wrap character
set laststatus=2
set showbreak=↳

" have line numbers
set number
set cursorline
if v:version > 704 || has('nvim')
    set relativenumber
end

" Make the vertical split bar a continuous line.
set fillchars+=vert:│

" leave 5 lines overlap when scrolling
set scrolloff=5
set sidescrolloff=5

" disable the mouse
set mouse=
set mousehide


"           Auto-completion
"------------------------------------------------------------------------------
" Shows what you are typing as a command. Automatically cd into the directory
" that the file is in
set showcmd
set autochdir

" auto completion
set complete=.,w,b,u,U,t,i,d
set wildmode=longest,list,full
set wildmenu

" ignore files with these extensions
set wildignore =*.d,*.moc                       " Build files
set wildignore+=*.a,*.exe,*.o,*.so              " C/C++
set wildignore+=*.aux,*.out,*.toc               " LaTeX
set wildignore+=*.bmp,*.gif,*.jpeg,*.jpg,*.png  " Binary images
set wildignore+=*.p,*.pyc                       " Python
set wildignore+=*~,*.sw?                        " Swap files


"           Backup, History and Swap
"------------------------------------------------------------------------------
" 1000 undo history
set undolevels=1000

" backup and swap files.
set backup
set writebackup
set backupdir=~/.vim/backup//,/var/tmp//,/tmp//
set directory=~/.vim/swap//,/var/tmp//,/tmp//
if has('persistent_undo')
    set undofile
    set undodir  =~/.vim/undo//,/var/tmp//,/tmp//
endif

" Vim info
set viminfo='10,\"100,:20,%,n~/.viminfo

" Map the leader key.
let g:mapleader = "\<Space>"


"           Functions
"------------------------------------------------------------------------------
"       Browser()
" Opens a URL on the current line in the users browser. The browser command is
" read from the $BROWSER environment variable.
function! Browser()
    let l:line = getline('.')
    let l:line = matchstr(l:line, 'http[^   ]*')
    if l:line !=? ''
        silent exec '!$BROWSER '.l:line
        redraw!
    endif
endfunction

"       RestoreCursor()
" Restores the cursor to the line it was on when a buffer was closed. This
" function is called on entering a buffer by the auto commands.
function! RestoreCursor()
    if line("'\"") <= line('$')
        normal! g`"
        return 1
    endif
endfunction

"       CloseHiddenBuffers()
" Closes all hidden buffers that are not in windows or tabs and that haven't
" been modified.
function! CloseHiddenBuffers()
    " Get a list of all buffers in all tabs.
    let l:bufs = []
    for l:i in range(tabpagenr('$'))
        call extend(l:bufs, tabpagebuflist(l:i + 1))
    endfor

    let l:nclosed = 0
    for l:i in range(1, bufnr('$'))
        " If buffer i exists and isn't modified and isn't in the list of
        " buffers open in windows and tabs, then we delete it.
        if bufexists(l:i) && !getbufvar(l:i,'&mod') && index(l:bufs, l:i) == -1
            silent exec 'bwipeout' l:i
            let l:nclosed = l:nclosed + 1
        endif
    endfor
    echomsg l:nclosed . ' buffer(s) closed.'
endfunction

"       BuildDictionaries()
" Recompiles the spelling dictionaries. This function should be called if new
" words are added manually to any of the user dictionaries.
function! BuildDictionaries()
    mkspell! $HOME/.vim/spell/en.utf-8.add
    mkspell! $HOME/.en.local.utf-8.add
endfunction

"       SetMatches()
" Sets helper matches for files, at the moment this is for long lines and for
" trailing whitespace.
function! SetMatches()
    " Error match trailing whitespace
    silent! call matchdelete(w:m1)
    let w:m1 = matchadd('ErrorMsg', '\s\+$')

    " Error highlight lines which exceed the text width length.
    if &textwidth > 0
        silent! call matchdelete(w:m2)
        let w:m2 = matchadd('ErrorMsg', '\%'.(&textwidth+1).'v.*')
    elseif exists('w:m2')
        silent! call matchdelete(w:m2)
    endif
endfunction

"       Reload()
" Reloads Ctrl+P and closes any hidden buffers.
function! Reload()
    silent! CtrlPClearCache
    silent! call CloseHiddenBuffers()
    redraw!
endfunction

" TODO: make a function to format the text?
" execute '%!python -m json.tool'


"           Load local host settings
"------------------------------------------------------------------------------
" Load local vimrc.
if filereadable(glob('$HOME/.vimrc.local'))
    source $HOME/.vimrc.local
endif
