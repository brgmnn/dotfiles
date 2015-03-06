augroup au_redraw
    autocmd!

    " Refresh airline after writing to a file.
    autocmd BufReadPost,BufWritePost,FileChangedShellPost * redraw!
augroup END
