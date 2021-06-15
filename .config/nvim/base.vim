" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/base.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 License
" =============================================================================

" Initialize &runtimepath
if !has('win32')
  set runtimepath-=/usr/share/vim/vimfiles
endif

" Settings in tmux
if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:vim_is_in_tmux = 1
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
  let g:vim_is_in_tmux = 0
endif

" Settings in manpager mode
if exists('g:vim_man_pager')
  let g:vim_enable_startify = 0
else
  let g:vim_enable_startify = 1
endif

" FVim
if exists('g:fvim_loaded')
  FVimCursorSmoothMove v:true
  FVimCursorSmoothBlink v:true
  FVimCustomTitleBar v:true
  FVimFontLigature v:true
  FVimFontNoBuiltinSymbols v:true
  FVimFontAutoSnap v:true
  FVimUIPopupMenu v:false
  FVimToggleFullScreen
endif

" Neovide
let g:neovide_cursor_vfx_mode = 'torpedo'
let g:neovide_fullscreen = v:true

" Initialize environment variables
let s:envs_path = fnamemodify(stdpath('config'), ':p') . 'envs.vim'
if !filereadable(s:envs_path) " Create envs.vim if it doesn't exist
  call writefile([
        \ "if !exists('g:vim_mode')",
        \ "  let g:vim_mode = 'minimal'",
        \ 'endif',
        \ 'let g:vim_plug_auto_install = 1',
        \ 'let g:vim_lightline_artify = 0',
        \ "let g:vim_color_scheme = 'everforest_dark'",
        \ "if !has('win32')",
        \ '  let g:startify_bookmarks = [',
        \ "        \\ {'r': '~/repo/'},",
        \ "        \\ {'p': '~/playground/'},",
        \ "        \\ {'v': '~/repo/dotfiles/.config/nvim/init.vim'},",
        \ "        \\ {'z': '~/.zshrc'},",
        \ "        \\ {'t': '~/.tmux.conf'}",
        \ '        \ ]',
        \ 'else',
        \ '  let g:startify_bookmarks = [',
        \ "        \\ {'R': '~/repo/'},",
        \ "        \\ {'P': '~/playground/'},",
        \ "        \\ {'c': '~/AppData/Local/nvim/init.vim'},",
        \ "        \\ {'c': '~/Documents/WindowsPowerShell/Profile.ps1'}",
        \ '        \ ]',
        \ 'endif',
        \ "if exists('g:fvim_loaded') || exists('g:neovide')",
        \ '  set guifont=SauceCodePro\ NF:h16',
        \ 'endif'
        \ ], s:envs_path, 'a')
  call custom#mode#update()
endif
execute 'source ' . fnamemodify(stdpath('config'), ':p') . 'envs.vim'

command! Mode call custom#mode#update()

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
