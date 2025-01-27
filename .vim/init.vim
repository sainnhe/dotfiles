" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/init.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

" Initialize envs.vim
let s:envs_path = fnamemodify(custom#utils#stdpath('config'), ':p') . 'envs.vim'
if !filereadable(s:envs_path)
  call custom#utils#generate_default_envs()
  call custom#mode#update()
endif

" Source configuration files
execute 'source ' . fnamemodify(custom#utils#stdpath('config'), ':p') . 'envs.vim'
execute 'source ' . fnamemodify(custom#utils#stdpath('config'), ':p') . 'settings.vim'
execute 'source ' . fnamemodify(custom#utils#stdpath('config'), ':p') . 'mappings.vim'
execute 'source ' . fnamemodify(fnamemodify(custom#utils#stdpath('config'), ':p') . 'features', ':p') . 'index.vim'

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
