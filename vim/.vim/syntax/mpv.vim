" Vim syntax file
" Language: mpv.conf

if exists("b:current_syntax")
  finish
endif

syn match mpvComment    '\s*#.*$'   contains=@Spell
syn match mpvKeywords   "="

syn region mpvFlagArea  start="^." end="=" keepend contains=mpvFlag
syn match mpvFlag       ".\+"       contains=@NoSpell

"syntax match commonOperator "\(+\|=\|-\|\^\|\*\)"
"syntax match baseDelimiter ","
"hi link commonOperator Operator
"hi link baseDelimiter Special


let b:current_syntax = "mpv"

hi def link mpvComment  Comment
hi def link mpvFlag Macro

hi def link mpvKeywords  Macro
