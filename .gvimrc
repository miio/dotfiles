if has('gui_macvim')
    " 全画面表示
    " set fuoptions=maxvert,maxhorz
    " au GUIEnter * set fullscreen

    " カラースキーム
    set background=dark
    let g:solarized_contrast="high"
    let g:solarized_italic=0
    let g:solarized_visibility="normal"
    colorscheme solarized

    set showtabline=2    " タブを常に表示
    set imdisable        " IME OFF
    set antialias        " アンチエイリアス

    set gfn=Ricty\ Bold:h11
    set gfw=

    set lines=94 columns=317
    set guioptions-=T
    set guioptions-=m

    set nomousefocus

    set cursorline
    set cursorcolumn

    " indentguides
    IndentGuidesEnable

    let g:indent_guides_color_change_percent = 30
    let g:indent_guides_guide_size = 1

    " 全角スペース表示
    highlight ZenkakuSpace cterm=underline ctermfg=red guibg=red guifg=white
    match ZenkakuSpace /　/

    " visualmark
    if &bg == "dark"
        " highlight SignColor ctermfg=white ctermbg=blue guibg=#073672
        highlight SignColor ctermfg=white ctermbg=blue guibg=darkblue
    else
        highlight SignColor ctermbg=white ctermfg=blue guibg=grey guifg=RoyalBlue3
    endif

    " カーソル位置
    highlight CursorLine guibg=#073672
    highlight CursorColumn guibg=#073672
else
endif
