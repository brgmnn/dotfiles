set nocompatible
set encoding=utf-8

"           Plugins
"-----------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'Raimondi/delimitMate'

Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin indent on

"           Airline
"-----------------------------------------------------------------------------
" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" delimitMate
let delimitMate_expand_cr = 1

"           Spelling
"-----------------------------------------------------------------------------
"set spell
set spelllang=en_gb
set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.en.local.utf-8.add

if empty(glob("$HOME/.vim/spell/en.utf-8.add.spl"))
    silent! mkspell $HOME/.vim/spell/en.utf-8.add
endif
if filereadable("$HOME/.en.local.utf-8.add")
    if empty(glob("$HOME/.en.local.utf-8.add.spl"))
        silent! mkspell $HOME/.vim/spell/en.local.utf-8.add
    endif
endif

"           View
"-----------------------------------------------------------------------------
" Enable spell checking on comments, Unix line endings, better consistency
" with editing at the end of lines.
set viewoptions=cursor,slash,unix
set virtualedit=onemore
set showmode

set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

" Custom status line formatting.
set statusline=%<%f\ " Filename
set statusline+=%w%h%m%r " Options
"set statusline+=%{fugitive#statusline()} " Git Hotness, needs fugitive
set statusline+=\ [%{&ff}/%Y] " File type
set statusline+=\ [%{getcwd()}] " Current directory
set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file navigation info

" Show matching braces/brackets, enable folding and when splitting the window,
" put the new window to the right/below the current one. Remove hidden
" buffers.
set showmatch
set foldenable
set splitright
set splitbelow
set nohidden


"           Formatting
"-----------------------------------------------------------------------------
" Set line break and column break at 78 characters
set wrap
set lbr
set textwidth=78
set wm=0
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
set clipboard=unnamedplus
set pastetoggle=<F12>


"           Color, Style and Syntax
"-----------------------------------------------------------------------------
syntax enable

set t_Co=256
set background=dark
colorscheme rainbow_fruit

" Add a highlighted column at 80 characters
"set colorcolumn=+2

" Turn on highlighting for search
set hlsearch

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
set mousehide


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
set wildignore =*.d                             " Build files
set wildignore+=*.a,*.exe,*.o,*.so              " C/C++
set wildignore+=*.aux,*.out,*.toc               " LaTeX
set wildignore+=*.bmp,*.gif,*.jpeg,*.jpg,*.png  " Binary images
set wildignore+=*.p,*.pyc                       " Python
set wildignore+=*~,*.sw?                        " Swap files


"           Backup, History and Swap
"-----------------------------------------------------------------------------
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


"           Functions
"-----------------------------------------------------------------------------
"       Browser()
" Opens a URL on the current line in the users browser. The browser command is
" read from the $BROWSER environment variable.
function! Browser()
    let line = getline(".")
    let line = matchstr(line, "http[^   ]*")
    if line != ""
        silent exec "!$BROWSER ".line
        redraw!
    endif
endfunction

"       RestoreCursor()
" Restores the cursor to the line it was on when a buffer was closed. This
" function is called on entering a buffer by the auto commands.
function! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
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
    silent! call matchdelete(w:m1)
    silent! call matchdelete(w:m2)
    let w:m1 = matchadd('ErrorMsg', '\s\+$')
    let w:m2 = matchadd('ErrorMsg', '\%80v.*')
endfunction

"           Auto Commands
"-----------------------------------------------------------------------------
augroup vimrc_autocmd
    " Remove all auto commands from the current group.
    autocmd!

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message.
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG
            \ call setpos('.', [0,1,1,0])

    " Restore the cursor to the position it was in when we closed the buffer.
    autocmd BufWinEnter * call RestoreCursor()

    " Remove trailing whitespace from buffers when reading and writing.
    autocmd BufRead,BufWinEnter,BufWrite *
            \ if ! &bin | silent! %s/\s\+$//ge | endif

    " Highlight trailing whitespace and long lines on buffer enter, read,
    " winenter and write.
    autocmd BufEnter,BufRead,BufWinEnter,BufWrite * call SetMatches()
augroup END


"           Commands
"-----------------------------------------------------------------------------
" Avoid easy typos with the shift key.
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>


"           Key Mappings
"-----------------------------------------------------------------------------
" Open URL on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Toggle folding at the cursor position with spacebar when in normal mode, as
" well as folding code with spacebar when in visual mode.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Map ctrl + c to copy when in visual mode.
vnoremap <C-c> "+yy
inoremap <C-S-v> <F12><C-r>+<F12>

" Clear highlighted searches when pressing Ctrl+L
nnoremap <C-L> :nohlsearch<CR><C-L>

" Fix some keys not working in screen.
map OH <Home>
map OF <End>
imap OH <Home>
imap OF <End>

" Disable Ex mode
nnoremap Q <nop>

" When you forget to sudo, really write the file.
cmap w!! w !sudo tee % >/dev/null


"           Load local host settings
"-----------------------------------------------------------------------------
" Load local vimrc.
if filereadable("~/.vimrc.local")
    source ~/.vimrc.local
endif
