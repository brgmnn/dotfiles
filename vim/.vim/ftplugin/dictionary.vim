augroup ft_dictionary
    autocmd!

    " Sorts the buffer (case insensitive) before saving it.
    " TODO: Rebuild the spelling dictionary on save as well.
    autocmd BufWrite <buffer> sort i
augroup END
