"           Key Mappings
"------------------------------------------------------------------------------
" Move left and right a word at a time with ctrl+arrow keys.
nnoremap <C-h> b
nnoremap <C-l> w
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>
vnoremap <C-h> b
vnoremap <C-l> w
vnoremap <C-k> <C-u>
vnoremap <C-j> <C-d>

" Arrow keys are not allowed.
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
vnoremap <up>    <nop>
vnoremap <down>  <nop>
vnoremap <left>  <nop>
vnoremap <right> <nop>

" Open URL on this line with the browser \w
map <Leader>w :call Browser()<CR>

" Reload various things
map <Leader>r :call Reload()<CR>

" Productivity, press either ';' or ':' in normal will begin a command (:).
nmap ; :

" Allow searching for text highlighted in visual mode by double tapping '/'.
vnoremap // y/<C-R>"<CR>"

" Toggle folding at the cursor position with spacebar when in normal mode, as
" well as folding code with spacebar when in visual mode.
nnoremap <silent> <Space>f @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Leader>f zf

" Map ctrl + c to copy when in visual mode.
vnoremap <C-c> "+yy
inoremap <C-S-v> <F12><C-r>+<F12>

" Fix some keys not working in screen.
map OH <Home>
map OF <End>
imap OH <Home>
imap OF <End>

" Disable Ex mode
nnoremap Q <nop>

" Timestamp
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" When you forget to sudo, really write the file.
cmap w!! w !sudo tee % >/dev/null


"           Plugin Key Mappings
"------------------------------------------------------------------------------
" NerdTree
nnoremap <Leader>n :NERDTreeToggle<CR>
