"---------------------------------------------------------
" 検索
"---------------------------------------------------------

set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

" *でビジュアルモードで選んでる文字を検索
vnoremap * "zy:let @/ = @z<CR>n
