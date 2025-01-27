" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/autoload/custom/plug.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

function custom#plug#check() abort
  let l:root_dir = fnamemodify(custom#utils#stdpath('config'), ':p')
  let l:plug_dir = fnamemodify(l:root_dir . 'autoload', ':p')
  let l:plug_path = l:plug_dir . 'plug.vim'
  return filereadable(l:plug_path)
endfunction

function custom#plug#install() abort
  echomsg 'Installing vim-plug ...'
  let l:root_dir = fnamemodify(custom#utils#stdpath('config'), ':p')
  call mkdir(l:root_dir . '_temp_')
  let l:plug_temp_dir = fnamemodify(l:root_dir . '_temp_', ':p')
  call delete(l:root_dir . '_temp_')
  let l:plug_temp_path = l:plug_temp_dir . 'plug.vim'
  let l:plug_dir = fnamemodify(l:root_dir . 'autoload', ':p')
  let l:plug_path = l:plug_dir . 'plug.vim'
  let l:git_url = 'https://github.com/junegunn/vim-plug.git'
  call system('git clone --depth 1 ' . l:git_url . ' ' . l:plug_temp_dir)
  let l:data = readfile(l:plug_temp_path)
  call writefile(l:data, l:plug_path, 'a')
  call delete(l:plug_temp_dir, 'rf')
  echomsg 'Successfully installed!'
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
