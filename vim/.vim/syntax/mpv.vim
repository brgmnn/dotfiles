" MPV config syntax
" Language: mpv.conf
" Maintainer: Daniel Bergmann
" Last Change: 14-March-2016

if exists('b:current_syntax')
  finish
endif

syn match  mpvComment   "\s*#.*$"                 contains=@Spell,@mpvFlagArea
syn match  mpvFlag      "^\s*[0-9a-zA-Z-]\+\s*"   contains=mpvOperator,@NoSpell
syn region mpvString    start=/"/ end=/"/ keepend contains=mpvColor
syn match  mpvColor     "#\x\{8}"                 contained contains=@NoSpell

syn match  mpvOperator  "="


hi def link mpvComment  Comment
hi def link mpvFlag     Function

hi def link mpvOperator Operator
hi def link mpvString   String
hi def link mpvColor    Special

let b:current_syntax = 'mpv'
