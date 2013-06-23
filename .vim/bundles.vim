set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.git/

  call neobundle#rc(expand('~/.vim/.bundle'))
endif



" color-scheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'git://github.com/vim-scripts/mrkn256.vim.git'

" lib
NeoBundle 'mattn/webapi-vim'
NeoBundle 'thinca/vim-openbuf'

" 擬似capslock
NeoBundle 'git://github.com/vim-scripts/capslock.vim.git'

" lingr
NeoBundle 'tsukkee/lingr-vim'

" 究極補完
NeoBundle 'Shougo/neocomplcache'

" コメントorコメントアウト
NeoBundle 'scrooloose/nerdcommenter'

" easymotion
"NeoBundle 'Lokaltog/vim-easymotion'

" ブラウザで開く
"NeoBundle 'tyru/open-browser.vim'

" ambicmd
NeoBundle 'thinca/vim-ambicmd'

" coffeescriptなどに使う
NeoBundle 'ujihisa/shadow.vim'

" unite関連
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'choplin/unite-vim_hacks'

" 整形
NeoBundle 'h1mesuke/vim-alignta'

" インデントの可視化
NeoBundle 'nathanaelkane/vim-indent-guides'

" 言語別
NeoBundle 'kchmck/vim-coffee-script'

" 即座に実行
NeoBundle 'thinca/vim-quickrun'

" リファレンスを開く
NeoBundle 'thinca/vim-ref'
NeoBundle 'mojako/ref-alc.vim'
NeoBundle 'mojako/ref-sources.vim'

" cocoa
NeoBundle 'msanders/cocoa.vim'

" 外側テキストオブジェクト
NeoBundle 'tpope/vim-surround'
NeoBundle 't9md/vim-surround_custom_mapping'

" テキスト移動
NeoBundle 't9md/vim-textmanip'

" wやeを賢く
NeoBundle 'kana/vim-smartword'

" 複数ハイライト
NeoBundle 't9md/vim-quickhl'

" ファイラ
NeoBundle 'Shougo/vimfiler'

" shell
NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'ujihisa/vimshell-ssh'

" echodoc
NeoBundle 'Shougo/echodoc'

" 移動
NeoBundle 'git://github.com/vim-scripts/Visual-Mark.git'

" html高速入力
NeoBundle 'mattn/zencoding-vim'

" 文字入力を賢く
NeoBundle 'kana/vim-smartchr'

" 同時押しマッピング
NeoBundle 'kana/vim-arpeggio'

" vim再起動
NeoBundle 'tyru/restart.vim'

" あのファイルを開く
NeoBundle 'kana/vim-altr'

" git
NeoBundle 'tpope/vim-fugitive'

" scouter
NeoBundle 'thinca/vim-scouter.git'

" localvimrc
NeoBundle 'thinca/vim-localrc'

" eskk.vim
NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/savemap.vim'
NeoBundle 'tyru/vice.vim'

" skk.vim
" NeoBundle 'tyru/skk.vim'

" matrix
NeoBundle 'git://github.com/vim-scripts/matrix.vim--Yang.git'

" gundo
NeoBundle 'sjl/gundo.vim'

" Phrase
NeoBundle 'git://github.com/vim-scripts/phrase.vim.git'

" zoom
NeoBundle 'taku-o/vim-zoom'

" zoomwin
NeoBundle 'git://github.com/vim-scripts/ZoomWin.git'

" 移動を細かく記録する
NeoBundle 'thinca/vim-poslist'

" <c-a><c-x>で変更できるものを増やす
NeoBundle 'tekkoc/monday'

" コマンドラインでemacsライクな移動ができるように
NeoBundle 'houtsnip/vim-emacscommandline'

" 変数名を規則に従って変換
NeoBundle 'tpope/vim-abolish'

" 変数名の規則に従って移動
NeoBundle 'ujihisa/camelcasemotion'

" Vim script doc
NeoBundle 'https://github.com/mattn/learn-vimscript.git'

" Game
NeoBundle 'mattn/invader-vim'
NeoBundle 'mfumi/snake.vim'
NeoBundle 'mfumi/viminesweeper'
NeoBundle 'mfumi/lightsout.vim'

" Add from itochan315
"NeoBundle 'Align'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'ruby-matchit'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'nono/jquery.vim'
"NeoBundle 'nginx.vim'
NeoBundle 'basyura/jslint.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'hallison/vim-ruby-sinatra'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-surround'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'skammer/vim-css-color'
NeoBundle 'cakebaker/scss-syntax.vim'
"NeoBundle 'YankRing.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'tyru/operator-html-escape.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'mattn/gist-vim'
"NeoBundle 'sudo.vim'
"NeoBundle 'The-NERD-Commenter'

NeoBundle 'taichouchou2/alpaca_powertabline'
" ステータスラインをカッコよくする
NeoBundle 'Lokaltog/vim-powerline'
" 上のはDeprecatedだけど下のがうまくはいらなかった...
"NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}

filetype plugin on
filetype indent on
