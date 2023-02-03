" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/explorer.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

let g:custom#explorer#first_launch = 1

function custom#explorer#toggle() abort
  execute 'CocCommand explorer ' . getcwd()
endfunction

function custom#explorer#startify() abort
  execute 'Startify'
  if g:custom#explorer#first_launch
    execute 'Rooter'
    let g:custom#explorer#first_launch = 0
  endif
  call custom#explorer#toggle()
endfunction

function custom#explorer#close_last() abort
  if winnr('$') == 1 && (&filetype ==# 'coc-explorer' || &filetype ==# 'coctree')
    if tabpagenr() == 1
      call custom#utils#set_cursor_shape()
    endif
    quit
  endif
endfunction

function custom#explorer#close_startify() abort
  quit
  if winnr('$') == 1 && &filetype ==# 'startify'
    if tabpagenr() == 1
      call custom#utils#set_cursor_shape()
    endif
    quit
  endif
endfunction

function! custom#explorer#toggle_outline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
