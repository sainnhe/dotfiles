" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/init.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 License
" =============================================================================

execute 'source ' . fnamemodify(stdpath('config'), ':p') . 'base.vim'
execute 'source ' . fnamemodify(stdpath('config'), ':p') . 'envs.vim'
execute 'source ' . fnamemodify(stdpath('config'), ':p') . 'settings.vim'
execute 'source ' . fnamemodify(stdpath('config'), ':p') . 'mappings.vim'
execute 'source ' . fnamemodify(fnamemodify(stdpath('config'), ':p') . 'features', ':p') . 'index.vim'

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
