" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/mode.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
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
function custom#utils#escaped_search() range "{{{
  let l:saved_reg = @"
  execute 'normal! vgvy'
  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction "}}}
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

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
