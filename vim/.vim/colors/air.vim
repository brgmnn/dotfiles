
if v:version < 700
    finish
endif


hi clear
set background=light

if exists("syntax_on")
    syntax reset
endif

set t_Co=256
let g:colors_name="air"


hi Normal     guifg=#404040 guibg=#f8f8f8 guisp=#404040
hi Comment    guifg=#aaaaaa

hi Identifier guifg=#008888

hi String     guifg=#ab50cc
hi Constant   guifg=#ab50cc

hi Statement  guifg=#4ecdc4

hi PreProc    guifg=#c7f464
