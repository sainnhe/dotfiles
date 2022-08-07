" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/mode.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

function custom#utils#close_on_last_tab() abort "{{{
  if tabpagenr('$') == 1
    execute 'windo bd'
    execute 'q'
  elseif tabpagenr('$') > 1
    execute 'windo bd'
  endif
endfunction "}}}
function custom#utils#indent_len(str) abort "{{{
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction "}}}
function custom#utils#go_indent(times, dir) abort "{{{
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = custom#utils#indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if custom#utils#indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction "}}}
function custom#utils#get_highlight() abort "{{{
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc "}}}
function custom#utils#git_status() abort "{{{
  let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  if strlen(l:branchname) > 0
    return ' '.l:branchname.' '
  else
    return ' clean '
  endif
endfunction "}}}
function custom#utils#switch_lightline_color_scheme(colorscheme) abort "{{{
  execute join(['source', globpath(&runtimepath, join(['autoload/lightline/colorscheme/', a:colorscheme, '.vim'], ''), 0, 1)[0]], ' ')
  let g:lightline.colorscheme = a:colorscheme
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction "}}}
function custom#utils#toggle_pomodoro() abort "{{{
  if g:pomodoro_status == 0
    let g:pomodoro_status = 1
    execute 'PomodoroStart'
  elseif g:pomodoro_status == 1
    let g:pomodoro_status = 0
    execute 'PomodoroStop'
  endif
endfunction "}}}
function custom#utils#check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction "}}}
function custom#utils#stdpath(type) abort "{{{
  if has('nvim')
    return stdpath(a:type)
  else
    if !has('win32')
      if a:type ==# 'config'
        return expand('~') . '/.vim'
      elseif a:type ==# 'cache'
        return expand('~') . '/.cache/nvim'
      elseif a:type ==# 'data'
        return expand('~') . '/.local/share/nvim'
      endif
    else
      if a:type ==# 'config'
        return expand('~') . '\vimfiles'
      elseif a:type ==# 'cache'
        return expand('~') . '\AppData\Local\Temp\nvim'
      elseif a:type ==# 'data'
        return expand('~') . '\AppData\Local\nvim-data'
      endif
    endif
  endif
endfunction "}}}
function custom#utils#set_cursor_shape() abort "{{{
  if has('nvim')
    set guicursor=a:ver25-Cursor/lCursor
  else
    let &t_te.="\e[5 q"
  endif
endfunction "}}}
function custom#utils#update() abort "{{{
  PlugUpdate
  PlugUpgrade
  CocUpdate
endfunction "}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
