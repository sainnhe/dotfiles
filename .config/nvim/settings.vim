" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/settings.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 License
" =============================================================================

filetype plugin indent on
syntax enable
set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
set fileformats=unix,dos,mac
set autoindent smartindent breakindent
set list listchars=tab:>-,trail:~,extends:>,precedes:<
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set timeout timeoutlen=500
set incsearch nohlsearch
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
execute 'set undofile undodir=' . fnamemodify(stdpath('cache'), ':p') . 'undo'

if !has('win32')
  set dictionary+=/usr/share/dict/words
  set dictionary+=/usr/share/dict/american-english
endif

if has('nvim')
  set inccommand=split
  set wildoptions=pum
endif

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

if g:vim_mode ==# 'minimal'
  colorscheme desert
endif

augroup VimSettings
  autocmd!
  autocmd FileType html,css,scss,typescript,vim set shiftwidth=2
  autocmd VimLeave * set guicursor=a:ver25-Cursor/lCursor
augroup END

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
