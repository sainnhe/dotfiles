" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/settings.vim
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
  let g:neovide_hide_mouse_when_typing = v:true
  let g:neovide_remember_window_size = v:true
  let g:neovide_input_macos_option_key_is_meta = 'both'
  augroup ime_input
    autocmd!
    autocmd InsertLeave * execute "let g:neovide_input_ime=v:false"
    autocmd InsertEnter * execute "let g:neovide_input_ime=v:true"
    autocmd CmdlineEnter [/\?] execute "let g:neovide_input_ime=v:false"
    autocmd CmdlineLeave [/\?] execute "let g:neovide_input_ime=v:true"
  augroup END
endif

" Nvui
if exists('g:nvui')
  NvuiCursorHideWhileTyping v:true
  NvuiFrameless v:true
  NvuiAnimationsEnabled v:true
  NvuiFullscreen v:true
endif

" General
filetype plugin indent on
syntax enable
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
set fileformats=unix,dos,mac
set autoindent smartindent breakindent
set list listchars=tab:\ \ ,trail:~,extends:>,precedes:<
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set timeout timeoutlen=500
set incsearch hlsearch
set autoread
set sessionoptions-=options
set viewoptions-=options
set wildmenu
set termguicolors t_Co=256
set number cursorline signcolumn=yes showtabline=2 laststatus=2
set mouse=a
set hidden
set scrolloff=5 sidescrolloff=10
set history=1000
set updatetime=100
set completeopt=noinsert,noselect,menuone shortmess+=c
set nobackup nowritebackup
set backspace=indent,eol,start
set belloff=all

if !has('win32')
  set dictionary+=/usr/share/dict/words
  set dictionary+=/usr/share/dict/american-english
endif

if has('nvim')
  set inccommand=split
  set laststatus=3
  lua vim.loader.enable()
elseif has('vim9script')
  set wildoptions=pum
  set fillchars=vert:│,fold:-,eob:~
endif

execute 'set backupdir=' . fnamemodify(custom#utils#stdpath('data'), ':p') . 'backup'
execute 'set directory=' . fnamemodify(custom#utils#stdpath('data'), ':p') . 'swap'
execute 'set undofile undodir=' . fnamemodify(custom#utils#stdpath('cache'), ':p') . 'undo' . (has('nvim') ? '-nvim' : '-vim')
if !isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p')
endif
if !isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p')
endif
if !isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p')
endif

" Color scheme in minimal mode
if g:vim_mode ==# 'minimal'
  colorscheme desert
endif

" Status line in minimal mode and light mode
if g:vim_mode !=# 'full'
  set noshowmode
  set statusline=
  set statusline+=%#TabLineSel#
  set statusline+=%{(mode()=='n')?'\ \ NORMAL\ ':''}
  set statusline+=%{(mode()=='i')?'\ \ INSERT\ ':''}
  set statusline+=%{(mode()=='v')?'\ \ VISUAL\ ':''}
  set statusline+=%{(mode()=='r')?'\ \ REPLACE\ ':''}
  set statusline+=%#StatusLine#
  set statusline+=%r\ 
  set statusline+=%f
  set statusline+=%m\ 
  set statusline+=%#Normal#
  set statusline+=%=
  set statusline+=%#StatusLine#
  set statusline+=\ %y
  set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
  set statusline+=\[%{&fileformat}\]
  set statusline+=\ %p%%
  set statusline+=\ %l:%c\ 
  set statusline+=%#TabLineSel#
  set statusline+=%{custom#utils#git_status()}
endif

" Close last window
augroup CloseLastWin
  autocmd!
  autocmd BufEnter * call custom#dashboard#close_last_win()
augroup END

" Cursor shape in Vim
if !has('nvim')
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

augroup CursorShape
  autocmd!
  autocmd VimLeave * call custom#utils#set_cursor_shape()
augroup END

" Register commands
command! Mode call custom#mode#update()

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
