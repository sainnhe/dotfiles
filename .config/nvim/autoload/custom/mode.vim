" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/mode.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 License
" =============================================================================

function custom#mode#check_dependencies() abort " Check dependencies
  let l:result = 1
  if !has('pythonx')
    echomsg "[dependency] Doesn't have python support."
    let l:result = 0
  endif
  if !executable('node')
    echomsg "[dependency] Doesn't have nodejs installed."
    let l:result = 0
  endif
  if !executable('npm')
    echomsg "[dependency] Doesn't have npm installed."
    let l:result = 0
  endif
  if !executable('yarn')
    echomsg "[dependency] Doesn't have yarn installed."
    let l:result = 0
  endif
  if !executable('clang')
    echomsg "[dependency] Doesn't have clang installed."
    let l:result = 0
  endif
  if !executable('shellcheck')
    echomsg "[dependency] Doesn't have shellcheck installed."
    let l:result = 0
  endif
  if !executable('shfmt')
    echomsg "[dependency] Doesn't have shfmt installed."
    let l:result = 0
  endif
  if !executable('yapf')
    echomsg "[dependency] Doesn't have yapf installed."
    let l:result = 0
  endif
  if !executable('ctags')
    echomsg "[dependency] Doesn't have universal-ctags installed."
    let l:result = 0
  endif
  if !executable('gtags')
    echomsg "[dependency] Doesn't have gnu-global installed."
    let l:result = 0
  endif
  if !executable('julia')
    echomsg "[dependency] Doesn't have julia installed."
    let l:result = 0
  endif
  if !executable('zenity') && !has('win32')
    echomsg "[dependency] Doesn't have zenity installed."
    let l:result = 0
  endif
  return l:result
endfunction

function custom#mode#get() abort " Get mode
  let l:input = input("[1] Minimal:  No plugins\n[2] Light:    Plugins with no extra dependencies\n[3] Full:     Full featured development environment\n==> ")
  echomsg ' '
  let l:mode_num = str2nr(l:input)
  if l:mode_num == 1
    let l:vim_mode = 'minimal'
  elseif l:mode_num == 2
    let l:vim_mode = 'light'
  elseif l:mode_num == 3
    if custom#mode#check_dependencies()
      let l:vim_mode = 'full'
    else
      echomsg "[dependency] Detected uninstalled dependencies, fall back to light mode."
      let l:vim_mode = 'light'
    endif
  else
    echoerr 'Invalid input!'
    let l:vim_mode = 'minimal'
  endif
  return l:vim_mode
endfunction

function custom#mode#update() abort " Update .config/nvim/envs.vim
  let l:vim_mode = custom#mode#get()
  let l:insert_str = "  let g:vim_mode = '" . l:vim_mode . "'"
  let l:envs_path = fnamemodify(stdpath('config'), ':p') . 'envs.vim'
  let l:envs_content = join(readfile(l:envs_path), "\n")
  let l:envs_content = substitute(l:envs_content, "  let g:vim_mode = '[[:alpha:]]\\{}'", l:insert_str, 'g')
  call delete(l:envs_path)
  call writefile(split(l:envs_content, "\n"), l:envs_path, 'a')
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
