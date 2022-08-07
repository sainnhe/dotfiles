" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/base.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

" Settings in tmux
if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:vim_is_in_tmux = 1
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
  let g:vim_is_in_tmux = 0
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
if exists('g:neovide')
  let g:neovide_cursor_vfx_mode = 'sonicboom'
  let g:neovide_cursor_vfx_opacity = 50
  let g:neovide_remember_window_size = v:true
endif

" Nvui
if exists('g:nvui')
  NvuiCursorHideWhileTyping v:true
  NvuiFrameless v:true
  NvuiAnimationsEnabled v:true
  NvuiFullscreen v:true
endif

" Initialize environment variables
let s:envs_path = fnamemodify(custom#utils#stdpath('config'), ':p') . 'envs.vim'
if !filereadable(s:envs_path) " Create envs.vim if it doesn't exist
  call writefile([
        \ "if !exists('g:vim_mode')",
        \ "  let g:vim_mode = 'minimal'",
        \ 'endif',
        \ 'let g:vim_plug_auto_install = 0',
        \ 'let g:vim_lightline_artify = 0',
        \ "let g:vim_color_scheme = 'edge_dark'",
        \ 'let g:vim_italicize_keywords = 0',
        \ "if !has('win32')",
        \ '  let g:startify_bookmarks = [',
        \ "        \\ {'z': '~/.zshrc'},",
        \ "        \\ {'t': '~/.tmux.conf'},",
        \ "        \\ {'r': '~/repo/'},",
        \ "        \\ {'p': '~/playground/'},",
        \ '        \ ]',
        \ 'else',
        \ '  let g:startify_bookmarks = [',
        \ "        \\ {'c': '~/Documents/WindowsPowerShell/Profile.ps1'},",
        \ "        \\ {'R': '~/repo/'},",
        \ "        \\ {'P': '~/playground/'},",
        \ '        \ ]',
        \ 'endif',
        \ "if has('gui_running') || exists('g:fvim_loaded') || exists('g:neovide') || exists('g:nvui')",
        \ "  if !has('nvim') && !has('win32') && !has('osxdarwin')",
        \ '    set guifont=MonoLisa\ 12',
        \ '  else',
        \ '    set guifont=MonoLisa:h12',
        \ '  endif',
        \ 'endif'
        \ ], s:envs_path, 'a')
  call custom#mode#update()
endif
execute 'source ' . fnamemodify(custom#utils#stdpath('config'), ':p') . 'envs.vim'

command! Mode call custom#mode#update()

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
