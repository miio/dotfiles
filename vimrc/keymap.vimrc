"---------------------------------------------------------
" マッピング
"---------------------------------------------------------

" 最後に編集したところを選択
nnoremap gc `[v`]

" ペーストしたテキストを再選択
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" ESC2度押しで検索ハイライトを消す
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>

" vvで全選択
nmap VV ggVG
nmap vv ^v$h

nmap <buffer> ( ,mf(
nmap <buffer> ) ,mF(
nmap <buffer> { ,mf{
nmap <buffer> } ,mF{

" タブ移動
nnoremap <Leader>n gt
nnoremap <Leader>p gT

" 行数表示変更
function! s:toggle_nu()
    if !&number && !&relativenumber
        set number
        set norelativenumber
    elseif &number
        set nonumber
        set relativenumber
    elseif &relativenumber
        set nonumber
        set norelativenumber
    endif
endfunction
" nnoremap <silent> <F3> :<C-u>call <SID>toggle_nu()<CR>

" 表示行移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap 0 g0
nnoremap g0 0
nnoremap $ g$
nnoremap g$ $

" ExCommandの履歴を遡るのを楽に
cnoremap <C-p>  <Up>
cnoremap <Up>   <C-p>
cnoremap <C-n>  <Down>
cnoremap <Down> <C-n>

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %

" シフト移動
noremap J 30j
noremap K 30k
noremap L 10l
noremap H 10h

" 分割
noremap <Space>s :sp<CR>
noremap <Space>v :vs<CR>

" キーボードマクロをQに降格
nnoremap Q q

" ノーマルモード時にエンター2回で改行
nnoremap <CR><CR> :<C-u>call append(expand('.'), '')<Cr>j

" tagまわり
set tags=tags
nnoremap <silent> <Space>tl :Tlist<CR>
nnoremap <silent> <Space>te :TagExplorer<CR>
nnoremap <silent> <Space>tt <C-]>
nnoremap <silent> <Space>tn :tn<CR>
nnoremap <silent> <Space>tp :tp<CR>
"nnoremap <silent> <Space>tg :<C-u>UniteWithCursorWord -immediately tag<CR>
nnoremap <silent> <Space>tj <C-]>:<C-u>split<CR><C-o><C-o><C-w>j
nnoremap <silent> <Space>tu :!ctags -R<CR>
nnoremap <silent> <Space>tk <C-]>:<C-u>vsplit<CR><C-o><C-o><C-w>l

" cscope
nnoremap <silent> <space>sa :<C-u>cscope add cscope.out<CR>
nnoremap <silent> <space>ss :<C-u>cscope find s <C-r><C-w><CR>
nnoremap <silent> <space>sg :<C-u>cscope find g <C-r><C-w><CR>
nnoremap <silent> <space>sc :<C-u>cscope find c <C-r><C-w><CR>
nnoremap <silent> <space>sd :<C-u>cscope find d <C-r><C-w><CR>
nnoremap <silent> <space>st :<C-u>cscope find t <C-r><C-w><CR>
nnoremap <silent> <space>sf :<C-u>cscope find f <C-r><C-w><CR>
nnoremap <silent> <space>si :<C-u>cscope find i <C-r><C-w><CR>
