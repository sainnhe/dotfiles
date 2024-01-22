" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/mode.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

function custom#mode#get() abort " Get mode
  let l:input = input("[1] Minimal:  No plugins.\n[2] Light:    Install plugins with no extra dependencies except git.\n[3] Full:     Full featured development environment.\n==> ")
  echomsg ' '
  let l:mode_num = str2nr(l:input)
  if l:mode_num == 1
    let l:vim_mode = 'minimal'
  elseif l:mode_num == 2
    if executable('git')
      let l:vim_mode = 'light'
    else
      echomsg "[error] Doesn't have git installed. Falling back to minimal mode."
      let l:vim_mode = 'minimal'
    endif
  elseif l:mode_num == 3
    if executable('git')
      let l:vim_mode = 'full'
    else
      echomsg "[error] Doesn't have git installed. Falling back to minimal mode."
      let l:vim_mode = 'minimal'
    endif
    if custom#mode#check_dependencies() == 0
      echomsg "[warning] Detected uninstalled dependencies."
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
  let l:envs_path = fnamemodify(custom#utils#stdpath('config'), ':p') . 'envs.vim'
  let l:envs_content = join(readfile(l:envs_path), "\n")
  let l:envs_content = substitute(l:envs_content, "  let g:vim_mode = '[[:alpha:]]\\{}'", l:insert_str, 'g')
  call delete(l:envs_path)
  call writefile(split(l:envs_content, "\n"), l:envs_path, 'a')
endfunction

function custom#mode#check_dependencies() abort " Check dependencies
  let l:result = 1
  let l:dependencies = {
        \ 'universal': [
          \ 'cargo',
          \ 'clangd',
          \ 'flake8',
          \ 'gcc',
          \ 'go',
          \ 'gopls',
          \ 'java',
          \ 'node',
          \ 'npm',
          \ 'pnpm',
          \ 'python3',
          \ 'rg',
          \ 'rust-analyzer',
          \ 'tex',
          \ 'texlab',
          \ 'yapf',
          \ ],
        \ 'darwin': [
          \ 'shellcheck',
          \ 'shfmt'
          \ ],
        \ 'unix-like': [
          \ 'shellcheck',
          \ 'shfmt',
          \ 'zenity'
          \ ]
        \ }
  for dependency in l:dependencies['universal']
    if !executable(dependency)
      echomsg "[warning] Doesn't have " . dependency . ' installed.'
      let l:result = 0
    endif
  endfor
  if has('osxdarwin')
    for dependency in l:dependencies['darwin']
      if !executable(dependency)
        echomsg "[warning] Doesn't have " . dependency . ' installed.'
        let l:result = 0
      endif
    endfor
  endif
  if !has('win32') && !has('osxdarwin')
    for dependency in l:dependencies['unix-like']
      if !executable(dependency)
        echomsg "[warning] Doesn't have " . dependency . ' installed.'
        let l:result = 0
      endif
    endfor
  endif
  return l:result
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
