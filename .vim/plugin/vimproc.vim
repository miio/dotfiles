"=============================================================================
" FILE: vimproc.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 12 Sep 2011.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

if v:version < 700
  echoerr 'vimproc does not work this version of Vim "' . v:version . '".'
  finish
elseif exists('g:loaded_vimproc')
  finish
endif

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

if !exists('g:vimproc_shell_commands')
  let g:vimproc_shell_commands = {
        \ 'sh' : 1, 'bash' : 1, 'zsh' : 1, 'csh' : 1, 'tcsh' : 1,
        \ 'tmux' : 1, 'screen' : 1,
        \ 'python' : 1,
        \ }
endif
if !exists('g:stdinencoding')
  let g:stdinencoding = &termencoding
endif
if !exists('g:stdoutencoding')
  let g:stdoutencoding = &termencoding
endif
if !exists('g:stderrencoding')
  let g:stderrencoding = &termencoding
endif

command! -nargs=+ -complete=shellcmd VimProcBang call s:bang(<q-args>)
command! -nargs=+ -complete=shellcmd VimProcRead call s:read(<q-args>)

" Command functions:
function! s:bang(cmdline)"{{{
  " Expand % and #.
  let l:cmdline = join(map(vimproc#parser#split_args_through(
        \ vimproc#util#iconv(a:cmdline, vimproc#util#termencoding(), &encoding)),
        \ 'substitute(expand(v:val), "\n", " ", "g")'))

  " Open pipe.
  let l:subproc = vimproc#pgroup_open(l:cmdline, 1)

  call l:subproc.stdin.close()

  while !l:subproc.stdout.eof || !l:subproc.stderr.eof
    if !l:subproc.stdout.eof
      let l:output = l:subproc.stdout.read(-1, 40)
      if l:output != ''
        let l:output = vimproc#util#iconv(l:output, vimproc#util#stdoutencoding(), &encoding)

        echon l:output
        sleep 1m
      endif
    endif

    if !l:subproc.stderr.eof
      let l:output = l:subproc.stderr.read(-1, 40)
      if l:output != ''
        let l:output = vimproc#util#iconv(l:output, vimproc#util#stderrencoding(), &encoding)
        echohl WarningMsg | echon l:output | echohl None

        sleep 1m
      endif
    endif
  endwhile

  call l:subproc.stdout.close()
  call l:subproc.stderr.close()

  let [l:cond, l:last_status] = l:subproc.waitpid()
endfunction"}}}
function! s:read(cmdline)"{{{
  " Expand % and #.
  let l:cmdline = join(map(vimproc#parser#split_args_through(
        \ vimproc#util#iconv(a:cmdline, vimproc#util#termencoding(), &encoding)),
        \ 'substitute(expand(v:val), "\n", " ", "g")'))

  " Expand args.
  call append('.', split(vimproc#util#iconv(vimproc#system(l:cmdline),
        \ vimproc#util#stdoutencoding(), &encoding), '\r\n\|\n'))
endfunction"}}}

let g:loaded_vimproc = 1

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" vim: foldmethod=marker
