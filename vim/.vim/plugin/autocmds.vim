"           Auto Commands
"------------------------------------------------------------------------------
if has('autocmd')
augroup vimrc_autocmd
    " Remove all auto commands from the current group.
    autocmd!

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message.
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG
            \ call setpos('.', [0,1,1,0])

    " Restore the cursor to the position it was in when we closed the buffer.
    autocmd BufWinEnter * call RestoreCursor()

    " Remove trailing whitespace from buffers when reading and writing.
    autocmd BufRead,BufWinEnter,BufWrite *
            \ if ! &bin | silent! %s/\s\+$//ge | endif

    " Highlight trailing whitespace and long lines on buffer enter, read,
    " winenter and write.
    autocmd BufEnter,BufRead,BufWinEnter,BufWrite,WinEnter,WinLeave *
            \ call SetMatches()

    " Switch between normal and hybrid line number modes.
    if v:version > 704 || has('nvim')
        autocmd FocusLost,InsertEnter,WinLeave * set norelativenumber
        autocmd FocusGained,InsertLeave,WinEnter * set relativenumber
    end

    " Close NerdTree buffers if it's the only window left
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
            \ && b:NERDTree.isTabTree()) | q | endif
augroup END
endif
