"---------------------------------------------------------
" 基本設定
"---------------------------------------------------------

" 自動コマンド削除
autocmd!

" Vundleの設定を読み込む
if filereadable(expand('~/.vim/bundles.vim'))
    source ~/.vim/bundles.vim
endif

set nocompatible

set fileencodings=utf-8,cp932

" シンタックス有効
syntax on

" ファイルタイプ判定ON
filetype plugin indent on

" Ev/Rvでvimrcの編集と反映
command! Ev edit ~/dotfiles/.vimrc
command! Rv source ~/dotfiles/.vimrc

" Eg/Rgでgvimrcの編集と反映
command! Eg edit ~/dotfiles/.gvimrc
command! Rg source ~/dotfiles/.gvimrc

" BundleEditでVundleの設定ファイルを開く
command! BundleEdit edit ~/dotfiles/.vim/bundles.vim

"変更されたときに自動読み込み
set autoread

" カーソルを中央行に
set scrolloff=999

" <Leader>を,に
let mapleader = ","

" モードラインを無効にする
set nomodeline
set modelines=0

" 行数を表示
set number

" バックアップはとらない
set nobackup
set noswapfile
set directory=~/.vim/swp

" バックスペースで何でも消せるように
set backspace=indent,eol,start

" ペアとなる括弧の定義
set matchpairs+=<:>

" undoを記録
" set undofile

" 編集中もほかファイルを開けるように
set hidden

" koriya版に同梱されているプラグインを無効化する
let plugin_dicwin_disable = 1

"---------------------------------------------------------
" コマンドライン
"---------------------------------------------------------

set cmdheight=2            " コマンドラインは２行
set showcmd                " コマンドを表示
set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
set complete+=k            " 補完に辞書ファイル追加

"---------------------------------------------------------
" インデント
"---------------------------------------------------------
set smartindent

" set autoindent
" set cindent

" タブ幅４
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set fileformats=unix,dos,mac

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

"---------------------------------------------------------
" 文字コード関連
"---------------------------------------------------------

" 文字コードの自動認識
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
        " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    " 定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

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
" Ctrl-iでヘルプ
" nnoremap <C-i> :<C-u>help<Space><C-r><C-w><Enter>

"---------------------------------------------------------
" マッピング
"---------------------------------------------------------

" コロンとセミコロンを入れ替え
noremap : ;
noremap ; :

" 最後に編集したところを選択
nnoremap gc `[v`]

" ペーストしたテキストを再選択
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" ESC2度押しで検索ハイライトを消す
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>

" vvで全選択
nmap VV ggVG
nmap vv ^v$

" 分割画面移動
nnoremap <silent> <space>wj <C-w>j
nnoremap <silent> <space>wk <C-w>k
nnoremap <silent> <space>wl <C-w>l
nnoremap <silent> <space>wh <C-w>h
nnoremap <silent> <space>wr <C-w>r
nnoremap <silent> <space>w= <C-w>=
nnoremap <silent> <space>ww <C-w>w
nnoremap <silent> <space>wo :<C-u>ZoomWin<CR>

" タブ移動
nnoremap <Leader>n gt
nnoremap <Leader>p gT

" インサートモードでもhjklで移動（Ctrl押すけどね）
" imap <C-j> <Down>
" imap <C-k> <Up>
" imap <C-h> <Left>
" imap <C-l> <Right>

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

" スクロール
" noremap <Space>j 10j
" noremap <Space>k 10k

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
" nnoremap q Q

" ノーマルモード時にエンター2回で改行
nnoremap <CR><CR> :<C-u>call append(expand('.'), '')<Cr>j

" ビジュアルモード時の$で改行文字を含まない
vnoremap $ $h

" tagまわり
set tags=tags
nnoremap <silent> <Space>tl :Tlist<CR>
nnoremap <silent> <Space>te :TagExplorer<CR>
nnoremap <silent> <Space>tt <C-]>
nnoremap <silent> <Space>tn :tn<CR>
nnoremap <silent> <Space>tp :tp<CR>
nnoremap <silent> <Space>tg :<C-u>UniteWithCursorWord -immediately tag<CR>
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

"---------------------------------------------------------
" プラグイン設定
"---------------------------------------------------------

" mondayプラグインの設定例
let g:monday_patterns = [
            \["abc", "cde", "edf"],
            \["koreha", "hidoi", "desune"]
            \]

" F5でGundoを開く
noremap <F3> :GundoToggle<CR>

if has('vim_starting')
    let g:eskk#large_dictionary = '~/.vim/skk/skk-jisyo.l'
    let g:eskk#show_candidates_count = 2
endif

" TODO: eskkとskkを両立できるようにする
" let g:skk_large_jisyo = $home . '/.vim/skk/skk-jisyo.l'
" let g:skk_auto_save_jisyo = 1
" let g:skk_show_candidates_count = 2

" lingr
let g:lingr_vim_user = 'tek_koc'
if filereadable(expand('~/Dropbox/.password/.lingr_account.vim'))
    source ~/Dropbox/.password/.lingr_account.vim
endif

" poslist.vim
map <c-o> <Plug>(poslist-prev-pos)
map <c-i> <Plug>(poslist-next-pos)
let g:poslist_histsize = 10000

" echodoc
" let g:echodoc_enable_at_startup = 1

" quickhl
nmap <Leader>hh <Plug>(quickhl-toggle)
xmap <Leader>hh <Plug>(quickhl-toggle)
nmap <Leader>hr <Plug>(quickhl-reset)
xmap <Leader>hr <Plug>(quickhl-reset)
nmap <Leader>hm <Plug>(quickhl-match)

let g:vimfiler_as_default_explorer = 1

" quickrun
" for quickrun.vim

" let g:quickrun_config = {
            " \'objc': {
            " \'command': 'cc',
            " \'exec': ['%c %s -o %s:p:r -std=c99 -framework Foundation', '%s:p:r %a', 'rm -f %s:p:r'],
            " \'tempfile': '{tempname()}.m',
            " \}
            " \}

autocmd FileType objc nmap <Leader>r <d-r>

" arpeggio(同時押し設定)
let g:arpeggio_timeoutlen = 70
call arpeggio#load()

Arpeggio inoremap jk <Esc>
Arpeggio onoremap jk <Esc>
Arpeggio vnoremap jk <Esc>

" smartchr.vim
" inoremap <buffer><expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
" inoremap <buffer><expr> , smartchr#one_of(', ', ',')

" other
" inoremap ( ()<Left>
" inoremap < <><Left>
" inoremap ' ''<Left>
" inoremap " ""<Left>

" Alignta(仮設定)
vnoremap <Leader>a :Alignta 

" コマンド展開
cnoremap <expr> <Space> ambicmd#expand("\<Space>")
cnoremap <expr> <CR>    ambicmd#expand("\<CR>")

" あのファイル
nmap <F4> <Plug>(altr-forward) call altr#define('*/tpl/*/%.html', '*/public_html/*/%.php')

" vim-ref
nmap <Leader>k <Plug>(ref-keyword)
let objc_man_key = '<Leader>k'

" smartword.vim
nmap w  <Plug>(smartword-w)
nmap b  <Plug>(smartword-b)
nmap ge  <Plug>(smartword-ge)
xmap w  <Plug>(smartword-w)
xmap b  <Plug>(smartword-b)
xmap e  <Plug>(smartword-e)
" Operator pending mode.
omap <Leader>w  <Plug>(smartword-w)
omap <Leader>b  <Plug>(smartword-b)
omap <Leader>ge  <Plug>(smartword-ge)

" visualmark設定
" map <silent> <Leader>vs <Plug>Vm_toggle_sign
" map <silent> <Leader>vj <Plug>Vm_goto_next_sign
" map <silent> <Leader>vk <Plug>Vm_goto_prev_sign
map <silent> <Leader>vs <Plug>Place_sign
map <silent> <Leader>vv <Plug>Place_sign
map <silent> <Leader>vr <Plug>Remove_all_signs
map <silent> <Leader>vj <Plug>Goto_next_sign
map <silent> <Leader>vn <Plug>Goto_next_sign
map <silent> <Leader>vk <Plug>Goto_prev_sign
map <silent> <Leader>vp <Plug>Goto_prev_sign


" easymotion
let g:EasyMotion_leader_key='<Leader>m'

" capslock設定
imap <C-a> <C-o><Plug>CapsLockToggle

" vimshell設定

let g:vimshell_enable_auto_slash = 1		" ディレクトリ補完時にスラッシュを補う
let g:vimshell_vcs_print_null = 1			" vcs情報を表示
let g:vimshell_max_command_history = 100000000			" ヒストリの保存数
noremap <Leader>s :<C-u>VimShellTab<CR>
noremap <Leader>ss :<C-u>VimShellTab<CR>
noremap <Leader>sj :<C-u>new<CR>:<C-u>VimShellCreate<CR>
noremap <Leader>sk :<C-u>vnew<CR>:<C-u>VimShellCreate<CR>
noremap <Leader>f :<C-u>VimFilerTab<CR>

" surround.vim
let g:surround_{char2nr('S')}= "{{\r}}"

let g:surround_custom_mapping = {}
let g:surround_custom_mapping._ = {
            \'[': "[\r]",
            \'(': "(\r)",
            \}
let g:surround_custom_mapping.php= {
            \'{': "{\r}",
            \'f': "\1name: \r..*\r&\1(\r)",
            \'a': "['\r']",
            \'v': "v(\r);"
            \}
let g:surround_custom_mapping.smarty= {
            \'s': "{{\1name: \r..*\r&\1}}\r{{/\1\1}}", 
            \'{': "{{\r}}"
            \}

imap <C-k> <C-g>s

" unite
" 入力モードで開始する
let g:unite_enable_start_insert=1
" let g:unite_source_file_rec_ignore_pattern= '/templates_c'
let g:unite_source_file_mru_limit = 10000
" let g:unite_source_file_rec_ignore_pattern= '\%(^\|/\)\.$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'
" let g:unite_enable_split_vertically=1
" let g:unite_winwidth=50

" ファイル一覧
noremap <Leader>uf :<C-u>Unite file_rec/async file -buffer-name=file<CR>
" バッファ一覧(bookmarkと被るので、とりあえずヒストリのhで妥協)
noremap <Leader>uh :<C-u>Unite buffer -buffer-name=file<CR>
" お気に入り
noremap <Leader>ub :<C-u>Unite bookmark -default-action=cd<CR>
" 最近使ったファイルの一覧
noremap <Leader>um :<C-u>Unite file_mru -buffer-name=file<CR>
" grep
noremap <Leader>ug :<C-u>Unite grep -no-quit<CR>/*.
" grep
au FileType php noremap <Leader>ug :<C-u>Unite grep -no-quit<CR>/*.php<CR>
" ref
au FileType php noremap <Leader>ur :<C-u>Unite ref/phpmanual<CR>
au FileType vim noremap <Leader>ur :<C-u>Unite help<CR>
" outline
noremap <Leader>uo :<C-u>Unite outline -no-quit -vertical -winwidth=30 -buffer-name=side<CR>
" tags
noremap <Leader>ut :<C-u>Unite tag -no-quit -vertical -winwidth=30 -buffer-name=side<CR>
" command
noremap <Leader>uc :<C-u>Unite history/command<CR>
" line
noremap <Leader>ul :<C-u>Unite line -no-quit -vertical -winwidth=30 -buffer-name=side<CR>
" register
noremap <Leader>uy :<C-u>Unite register<CR>
" source(sourceが増えてきたので、sourceのsourceを経由する方針にしてみる)
noremap <Leader>uu :<C-u>Unite source<CR>
" snippet
noremap <Leader>us :<C-u>Unite snippet<CR>
" svn
" noremap <Leader>uss :Unite svn/status<CR>
" noremap <Leader>usd :Unite svn/diff<CR>

" カラースキーム用コマンド
command! UniteColorScheme :Unite colorscheme -auto-preview

" ウィンドウを横に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ウィンドウをタブで開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" 初期設定関数を起動する
au FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " Overwrite settings.
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    nmap <buffer> <space><space> <Plug>(unite_toggle_mark_current_candidate)
    nnoremap <buffer> p p
    nnoremap <buffer> <Space> <Space>
endfunction

" NERD Commnterの設定
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

" vimrefのショートカットコマンド
command! -nargs=1 Alc :Ref alc <args>

" vimref用のphpmanualのパス
let g:ref_phpmanual_path = $HOME . '/.vim/phpmanual'

" neocomplcache設定

" ファイル名補完
inoremap <expr><C-x><C-f>  neocomplcache#manual_filename_complete()

" omni補完
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplcache#manual_omni_complete()

" <C-h>のときにポップアップを消す
inoremap <expr><C-h> neocomplcache#smart_close_popup()."<C-h>"

" <C-y>で補完を確定
inoremap <expr><C-y> neocomplcache#close_popup()

" <C-e>で補完をキャンセル
inoremap <expr><C-e> neocomplcache#cancel_popup()

" スニペット
imap <C-s> <Plug>(neocomplcache_snippets_expand)
smap <C-s> <Plug>(neocomplcache_snippets_expand)

let g:neocomplcache_enable_at_startup = 1 " 自動起動
let g:neocomplcache_enable_smart_case = 1 " 大文字打つまで、小文字大文字区別しない
let g:neocomplcache_enable_underbar_completion = 1	" 区切り文字の補完を有効化
let g:neocomplcache_caching_limit_file_size = 500000000 " キャッシュするファイルサイズを増やす
let g:neocomplcache_min_syntax_length = 3
let g:NeoComplCache_EnableInfo = 1
let g:neocomplcache_dictionary_file_type_lists = {
            \'default' : '',
            \'php' : $HOME.'/.vim/dict/php.dict',
            \'scala' : $HOME.'/.vim/dict/scala.dict',
            \'vimshell' : $HOME.'/.vim/.vimshell_hist'
            \}
let g:NeoComplCache_SnippetsDir = $HOME . '/.vim/snippets'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
" if !exists('g:neocomplcache_omni_patterns')
" let g:neocomplcache_omni_patterns = {}
" endif
" let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" autocmd FileType php setlocal omnifunc=phpcomplete#Complete

" vimproc
let g:vimproc_dll_path = $HOME . '/.vim/autoload/proc.so'

" textmanip
" 選択したテキストの移動
vmap <C-j> <Plug>(textmanip-move-down)
vmap <C-k> <Plug>(textmanip-move-up)
vmap <C-h> <Plug>(textmanip-move-left)
vmap <C-l> <Plug>(textmanip-move-right)

" 行の複製
vmap <C-D> <Plug>(textmanip-duplicate-up)
nmap <C-D> <Plug>(textmanip-duplicate-up)
vmap <C-d> <Plug>(textmanip-duplicate-down)
nmap <C-d> <Plug>(textmanip-duplicate-down)

" open-browser.vim
nmap <Leader>o <Plug>(openbrowser-smart-search)
vmap <Leader>o <Plug>(openbrowser-smart-search)
command! -nargs=1 Google :OpenBrowserSearch <args>

" フォントサイズ変更
noremap <UP> :<C-u>ZoomIn<CR>
noremap <DOWN> <C-u>:ZoomOut<CR>

"---------------------------------------------------------
" 未整理
"---------------------------------------------------------

" 覚えていない
" augroup Binary
" autocmd!
" autocmd BufReadPre  *.bin let &bin=1
" autocmd BufReadPost * if &bin | silent %!xxd -g 1
" autocmd BufReadPost * set filetype=xxd | endif
" autocmd BufWritePre * if &bin | %!xxd -r
" autocmd BufWritePost * if &bin | silent %!xxd -g 1
" autocmd BufWritePost * set nomod | endif

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
" メモ一覧をUniteで呼び出すコマンド
command! -nargs=0 MemoRead :Unite file_rec:~/Dropbox/Memo/ -buffer-name=file -auto-preview

command! -nargs=0 WeightRecode :edit ~/Dropbox/Recode/weight.cvs

" patemodeにF2でトグル
set pastetoggle=<F2>


" ヤンクしたものをクリップボードにも
set clipboard=unnamed

" autocmd BufWritePre * :%s/\s\+$//ge


" 折り畳み関連
set foldmethod=manual

" ファイルタイプのショートカットコマンド
command! -nargs=1 Type :set filetype=<args>

function! PHPLint()
    let result = system( &ft . ' -l ' . bufname(""))
    echo result
endfunction
" autocmd BufWritePost *.php call PHPLint()
noremap <Leader>l :<C-u>call PHPLint()<CR>

" マッピングチェック
command!
            \   -nargs=* -complete=mapping
            \   AllMaps
            \   map <args> | map! <args> | lmap <args>

" テンプレート設定
autocmd BufNewFile *.php 0r $HOME/.vim/template/php.txt
autocmd BufNewFile *.pm 0r $HOME/.vim/template/perl.txt
autocmd BufNewFile *.html 0r $HOME/.vim/template/html.txt

au BufNewFile,BufRead *.scala set filetype=scala
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.js set filetype=coffee
au BufNewFile,BufRead *.html set filetype=smarty.html

autocmd FileType php :set dictionary+=~/.vim/dict/php.dict
autocmd FileType scala :set dictionary+=~/.vim/dict/scala.dict
set complete+=k


" コマンド実行中は再描画しない
" set lazyredraw
" 高速ターミナル接続を行う
" set ttyfast

" バッファの戻る・進む
noremap <Space>n :bn<CR>
noremap <Space>p :bp<CR>

" バッファを閉じる
noremap <Space>q :bd<CR>


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

if has("gui_running")
    " gvimrcも読み込む
    source ~/dotfiles/.gvimrc
else
    " CUI版Vim用のコード
    set background=dark
    colorscheme mrkn256
endif
