autocmd BufNewFile,BufReadPost *messages* if &ft != 'vim' |
    \ set filetype=messages | endif
