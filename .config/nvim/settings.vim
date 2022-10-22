" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/settings.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

filetype plugin indent on
syntax enable
set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
set fileformats=unix,dos,mac
set autoindent smartindent breakindent
set list listchars=tab:>-,trail:~,extends:>,precedes:<
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
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

if !has('win32')
  set dictionary+=/usr/share/dict/words
  set dictionary+=/usr/share/dict/american-english
endif

if has('nvim')
  set inccommand=split
  set laststatus=3
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

if g:vim_mode ==# 'minimal'
  colorscheme desert
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

augroup VimSettings
  autocmd!
  autocmd FileType html,css,scss,typescript,vim set shiftwidth=2
  autocmd VimLeave * call custom#utils#set_cursor_shape()
augroup END

" Cursor Shape in Vim
if !has('nvim')
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
