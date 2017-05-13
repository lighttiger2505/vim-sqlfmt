function! s:sqlfmt() abort
  call setqflist([])
  let lines = system(get(g:, 'sqlfmt_program', 'sqlformat -r -k upper -'), getline(1, '$'))
  if v:shell_error != 0
    echoerr substitute(lines, '[\r\n]', ' ', 'g')
    return
  endif
  let pos = getcurpos()
  silent! %d _
  call setline(1, split(lines, "\n"))
  call setpos('.', pos)
endfunction

nnoremap <silent> <Plug>(sqlfmt) :<c-u>call <SID>sqlfmt()<cr>

command! -nargs=0 SQLFmt call <SID>sqlfmt()
