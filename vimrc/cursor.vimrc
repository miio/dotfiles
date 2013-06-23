"---------------------------------------------------------
" カーソル行のハイライト
"---------------------------------------------------------

" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinLeave * set nocursorcolumn
    autocmd WinEnter,BufRead * set cursorline
    autocmd WinEnter,BufRead * set cursorcolumn
augroup END
