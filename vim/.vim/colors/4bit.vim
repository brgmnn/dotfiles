hi clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = "16 bit"

function! s:h(group, style)
    execute "highlight" a:group
        \ "guifg=NONE guibg=NONE guisp=NONE gui=NONE"
        \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
        \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
        \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

"   Colors
"------------------------------------------------------------------------------
let s:black       = { "cterm": "00" }
let s:dark_grey   = { "cterm": "08" }
let s:light_grey  = { "cterm": "07" }
let s:white       = { "cterm": "15" }

let s:blue        = { "cterm": "09" }
let s:green       = { "cterm": "10" }
let s:cyan        = { "cterm": "11" }
let s:red         = { "cterm": "12" }
let s:purple      = { "cterm": "13" }
let s:yellow      = { "cterm": "14" }

let s:dark_blue   = { "cterm": "01" }
let s:dark_green  = { "cterm": "02" }
let s:dark_cyan   = { "cterm": "03" }
let s:dark_red    = { "cterm": "04" }
let s:dark_purple = { "cterm": "05" }
let s:dark_yellow = { "cterm": "06" }

"   Mappings
"------------------------------------------------------------------------------
let s:bg = s:black
let s:normal = s:white

"   Highlights
"------------------------------------------------------------------------------
" UI
call s:h("Normal",                { "fg": s:white,      "bg": s:black     })
call s:h("VertSplit",             { "fg": s:light_grey, "bg": s:black     })
call s:h("NonText",               { "fg": s:dark_grey,  "bg": s:black     })
hi! link LineNr     NonText
hi! link Folded     NonText
hi! link FoldColumn NonText

" Syntax
call s:h("Comment",               { "fg": s:dark_grey,  "bg": s:black     })
call s:h("Delimiter",             { "fg": s:light_grey                    })
call s:h("Keyword",               { "fg": s:yellow,     "bg": s:black     })
call s:h("String",                { "fg": s:purple                        })
call s:h("Type",                  { "fg": s:green                         })
call s:h("Function",              { "fg": s:cyan                          })
call s:h("CursorLine",            { "bg": s:dark_blue                     })
call s:h("PreProc",               { "fg": s:green                         })

" Diff
call s:h("DiffAdd",               {                     "bg": s:dark_blue })
call s:h("DiffChange",            {                     "bg": s:dark_blue })
call s:h("DiffDelete",            { "fg": s:dark_grey                     })
call s:h("DiffText",              { "fg": s:black,      "bg": s:white     })

" Git Gutter
call s:h("GitGutterAdd",          { "fg": s:green                         })
call s:h("GitGutterChange",       { "fg": s:yellow                        })
call s:h("GitGutterDelete",       { "fg": s:red                           })
call s:h("GitGutterChangeDelete", { "fg": s:yellow                        })

" Javascript
hi! link javaScriptBraces       Delimiter
hi! link javaScriptEndColons    Delimiter
hi! link javaScriptOpSymbols    Keyword
hi! link javaScriptLogicSymbols Keyword
hi! link javaScriptParens       Delimiter
hi! link javaScriptFuncComma    Delimiter
hi! link javaScriptDotNotation  Function
