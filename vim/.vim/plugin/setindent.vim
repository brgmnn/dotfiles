"          FILE: setindent.vim
"      Language: vim script
"    Maintainer: Daniel Bergmann
"       Created: 2016 Jan 22
" Last Modified: 2016 Jan 22
"   Description:
"       This adds a function `SetIndent()` which when called and passed an
"       integer sets the local indentation settings. This is mainly to save
"       writing these same settings repeatedly. Indentation is expanded to
"       spaces.
"
"         Usage:
"           Execute :call SetIndent(4) to set the current indentation to 4
"           spaces.

if exists("g:loaded_setindent")
    finish
endif
let g:loaded_shuffle = 1

function! SetIndent(indent)
    setlocal autoindent
    let &l:tabstop     = a:indent
    let &l:shiftwidth  = a:indent
    let &l:softtabstop = a:indent
    setlocal smarttab
    setlocal expandtab
    setlocal smartindent
endfunction
