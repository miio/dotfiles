"---------------------------------------------------------
" プラグイン設定
"---------------------------------------------------------

" TODO:大文字対応
" mondayプラグインの設定例
let g:monday_patterns = [
            \["ASC", "DESC"],
            \["asc", "desc"],
            \]

" F3でGundoを開く
noremap <F3> :GundoToggle<CR>

if has('vim_starting')
    let g:eskk#large_dictionary = '~/.vim/skk/skk-jisyo.l'
    let g:eskk#show_candidates_count = 3
endif


" lingr
let g:lingr_vim_user = 'miio'
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


autocmd FileType objc nmap <Leader>r <d-r>

" arpeggio(同時押し設定)
let g:arpeggio_timeoutlen = 70
call arpeggio#load()

Arpeggio inoremap jk <Esc>
Arpeggio onoremap jk <Esc>
Arpeggio vnoremap jk <Esc>


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
map <silent> <Leader>vs <Plug>Vm_toggle_sign
map <silent> <Leader>vv <Plug>Vm_toggle_sign
map <silent> <Leader>vj <Plug>Vm_goto_next_sign
map <silent> <Leader>vk <Plug>Vm_goto_prev_sign

" easymotion
let g:EasyMotion_leader_key='<Leader>m'

" capslock設定
imap <C-a> <C-o><Plug>CapsLockToggle


" surround.vim
let g:surround_custom_mapping = {}
let g:surround_custom_mapping._ = {
            \'[': "[\r]",
            \'(': "(\r)",
            \}
let g:surround_custom_mapping.php= {
            \'{': "{\r}",
            \'f': "\1name: \r..*\r&\1(\r)",
            \'a': "['\r']",
            \'v': "v(\r);",
            \'s': "self::\r"
            \}
let g:surround_custom_mapping.smarty= {
            \'S': "{{\r}}",
            \'s': "{{\1name: \r..*\r&\1}}\r{{/\1\1}}",
            \'{': "{{\r}}"
            \}

imap <C-k> <C-g>s


" NERD Commnterの設定
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle

" vimrefのショートカットコマンド
command! -nargs=1 Alc :Ref alc2 <args>

" vimref用のphpmanualのパス
let g:ref_phpmanual_path = $HOME . '/.vim/phpmanual'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" vimproc
if has('mac')
	let g:vimproc_dll_path = $HOME . '/.vim/autoload/proc.so'
elseif has('win32')
else
	let g:vimproc_dll_path = $HOME . '/.vim/vimproc/autoload/proc.so'
endif
