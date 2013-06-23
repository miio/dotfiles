"---------------------------------------------------------
" 未整理
"---------------------------------------------------------

" メモを作成する
command! -nargs=0 MemoWrite call s:open_memo_file()
function! s:open_memo_file()
    let l:memo_dir = $HOME . '/Dropbox/Memo'. strftime('/%Y/%m/%d')
    if !isdirectory(l:memo_dir)
        call mkdir(l:memo_dir, 'p')
    endif

    let l:filename = input('File Name: ', l:memo_dir.strftime('/%H%M%S_'))
    if l:filename != ''
        execute 'edit ' . l:filename
    endif
endfunction augroup END
"" メモ一覧をUniteで呼び出すコマンド
"command! -nargs=0 MemoRead :Unite file_rec:~/Dropbox/Memo/ -buffer-name=file -auto-preview

" patemodeにF2でトグル
set pastetoggle=<F2>


" ヤンクしたものをクリップボードにも
set clipboard=unnamed

" 折り畳み関連
set foldmethod=manual

" ファイルタイプのショートカットコマンド
command! -nargs=1 Type :set filetype=<args>

function! PHPLint()
    let result = system( &ft . ' -l ' . bufname(""))
    echo result
endfunction
" autocmd BufWritePost *.php call PHPLint()
au FileType php nnoremap <buffer> <Space>l :<C-u>call PHPLint()<CR>

" iskeyword変更
au FileType php setlocal iskeyword+=$

" マッピングチェック
command!
            \   -nargs=* -complete=mapping
            \   AllMaps
            \   map <args> | map! <args> | lmap <args>

" テンプレート設定
autocmd BufNewFile *.pm 0r $HOME/.vim/template/perl.txt
autocmd BufNewFile *.html 0r $HOME/.vim/template/html.txt

au BufNewFile,BufRead *.scala set filetype=scala
au BufNewFile,BufRead *.ejs set filetype=html
" au BufNewFile,BufRead *.js set filetype=coffee
au BufNewFile,BufRead *.js set filetype=javascript
au BufNewFile,BufRead *.html set filetype=smarty.html

autocmd FileType php :set dictionary+=~/.vim/dict/php.dict
autocmd FileType scala :set dictionary+=~/.vim/dict/scala.dict
set complete+=k

" バッファの戻る・進む
noremap <Space>n :bn<CR>
noremap <Space>p :bp<CR>

" バッファを閉じる
" noremap <Space>q :bd<CR>


"php処理
let php_sql_query=1
"文字列中のSQLをハイライトする
let php_htmlInStrings=1
" let php_folding = 1

" ステータスライン設定
set laststatus=2
set statusline=\ [%02n]
set statusline+=\ %F
set statusline+=\ %7(%m\ %r%)----
set statusline+=%{&fileencoding}\ %{&fileformat}\ %{&filetype}
set statusline+=%=\ (%l,%c)
set statusline+=%=\ \ \ [%b,0x%B]

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 改行文字などの表示
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" マウススクロール有効化
set mouse=a
