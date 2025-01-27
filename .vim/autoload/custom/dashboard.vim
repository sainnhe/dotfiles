" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .vim/autoload/custom/dashboard.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

let g:custom#dashboard#first_launch = 1

function custom#dashboard#close_last_win() abort
  if tabpagenr() == 1
        \ && winnr('$') == 1
        \ && (&filetype ==# 'coc-explorer'
        \ || &filetype ==# 'coctree'
        \ || &filetype ==# 'startify')
    call custom#utils#set_cursor_shape()
    quitall
  endif
endfunction

function custom#dashboard#close() abort
  " Check if current tab page contains startify
  let l:exist_startify = v:false
  let l:tabpagenr = tabpagenr()
  for l:winnr in range(1, tabpagewinnr(l:tabpagenr, '$'))
    let l:winid = win_getid(l:winnr, l:tabpagenr)
    let l:bufnr = winbufnr(l:winid)
    if getbufvar(l:bufnr, '&filetype') ==# 'startify'
      let l:exist_startify = v:true
    endif
  endfor
  " If contains startify, close tab. Fallback to close window and trigger
  " custom#dashboard#close_last_win() to close last tab.
  if l:exist_startify
    try
      tabclose
    catch
      quit
    endtry
  else
    " If current tab doesn't contain startify, simply quit current window.
    quit
  endif
endfunction

function custom#dashboard#toggle_explorer() abort
  execute 'CocCommand explorer ' . getcwd()
endfunction

function custom#dashboard#launch_startify() abort
  execute 'Startify'
  if g:custom#dashboard#first_launch
    execute 'Rooter'
    let g:custom#dashboard#first_launch = 0
  endif
  call custom#dashboard#toggle_explorer()
endfunction

function! custom#dashboard#toggle_outline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
