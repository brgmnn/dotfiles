augroup vimrc_after
    " Refresh airline after writing to a file.
    autocmd BufReadPost,BufWritePost * redraw!
augroup END
