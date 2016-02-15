"           Fonts
"------------------------------------------------------------------------------
" Set fonts and font size
if has('gui_macvim')
    " OSX
    set guifont=Menlo\ Regular:h14
end


"           Display
"------------------------------------------------------------------------------
" Disable scroll bars in the GUI
let &guioptions = substitute(&guioptions, '[lrLR]', '', 'g')
