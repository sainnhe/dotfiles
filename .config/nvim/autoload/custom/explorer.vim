" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/explorer.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 && MIT
" =============================================================================

function custom#explorer#toggle() abort
  execute 'CocCommand explorer ' . getcwd()
endfunction

function custom#explorer#startify() abort
  execute 'Startify'
  call custom#explorer#toggle()
endfunction

function custom#explorer#close_last() abort
  let filetype = 'coc-explorer'
  if winnr('$') == 1 && &filetype ==# filetype
    if tabpagenr() == 1
      set guicursor=a:ver25-Cursor/lCursor
    endif
    quit
  endif
endfunction

function custom#explorer#close_startify() abort
  quit
  if winnr('$') == 1 && &filetype ==# 'startify'
    if tabpagenr() == 1
      set guicursor=a:ver25-Cursor/lCursor
    endif
    quit
  endif
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
