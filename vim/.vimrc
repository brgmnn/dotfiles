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
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-vinegar'

" Language Plugins
Plugin 'elixir-lang/vim-elixir'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-git'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'
Plugin 'brgmnn/vim-opencl'
Plugin 'rust-lang/rust.vim'
Plugin 'justinmk/vim-syntax-extra'

if version > 703
    " YouCompleteMe requires at least Vim version 7.3
    Plugin 'Valloric/YouCompleteMe'
endif

call vundle#end()
filetype plugin indent on


"           Plugin Settings
"-----------------------------------------------------------------------------
" Airline (modifies vims statusline)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_exclude_preview = 1
let g:airline_mode_map = {'c': 'C ', 'i': 'I ', 'n': 'N ', 'v': 'V ',
        \ 'R': 'R ', 'V': 'VL', '' : 'VB' }


" delimitMate
let delimitMate_expand_cr = 1

" Git Gutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '*-'


"           Spelling
"-----------------------------------------------------------------------------
"set spell
set spelllang=en_gb
set spellfile=$HOME/.vim/spell/en.utf-8.add,$HOME/.en.local.utf-8.add

if empty(glob("$HOME/.vim/spell/en.utf-8.add.spl"))
    silent! mkspell $HOME/.vim/spell/en.utf-8.add
endif
if filereadable(glob("$HOME/.en.local.utf-8.add"))
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
set pastetoggle=<F12>

if !has("gui_running")
    set clipboard=unnamedplus
endif


"           Color, Style and Syntax
"-----------------------------------------------------------------------------
syntax enable

set t_Co=256
set background=light
colorscheme hemisu

" Turn on highlighting for search, match the search term as it is typed.
set hlsearch
set incsearch

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
set wildignore =*.d,*.moc                       " Build files
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

"       CloseHiddenBuffers()
" Closes all hidden buffers that are not in windows or tabs and that haven't
" been modified.
function! CloseHiddenBuffers()
    " Get a list of all buffers in all tabs.
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    let nclosed = 0
    for i in range(1, bufnr('$'))
        " If buffer i exists and isn't modified and isn't in the list of
        " buffers open in windows and tabs, then we delete it.
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
            silent exec 'bwipeout' i
            let nclosed = nclosed + 1
        endif
    endfor
    echomsg nclosed . ' buffer(s) closed.'
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
        let w:m2 = matchadd('ErrorMsg', '\%'.(&textwidth+2).'v.*')
    elseif exists('w:m2')
        silent! call matchdelete(w:m2)
    endif
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
    autocmd BufEnter,BufRead,BufWinEnter,BufWrite,WinEnter,WinLeave *
            \ call SetMatches()
augroup END


"           Commands
"-----------------------------------------------------------------------------
" Avoid easy typos with the shift key.
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file Tabnew tabnew<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang WA wa<bang>
command! -bang Wa wa<bang>


"           Key Mappings
"-----------------------------------------------------------------------------
" Map the leader key.
let mapleader = ","

" Move left and right a word at a time with ctrl+arrow keys.
nnoremap <C-Left> b
nnoremap <C-Right> w

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
if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
