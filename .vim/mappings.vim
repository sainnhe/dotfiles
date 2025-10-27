" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .vim/mappings.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

" {{{Normal Mode
" Use space as leader key
let g:mapleader = "\<Space>"
nnoremap <SPACE> <Nop>
" Alt+X/Alt+Z/Ctrl+Z to enter normal mode
nnoremap <A-x> <ESC>
nnoremap <A-z> <ESC>
nnoremap <C-z> <ESC>
if !has('nvim')
  nnoremap ^@ <ESC>
else
  nnoremap <silent> <C-l> :<C-u>wincmd p<CR>
endif
" Fix Alt+/
" This mapping will cause vim to exit by default.
augroup FixAltSlash
  autocmd!
  autocmd VimEnter * nnoremap <Char-247> <ESC>
augroup END
" ; to enter command mode
nnoremap ; :
" q to quit
nmap <silent> q :<C-u>q<CR>
" Q to force quit
nmap <silent> Q :<C-u>q!<CR>
" <leader>q to close quickfix list
nnoremap <silent> <leader>q :<C-u>cclose<CR>
" m instead of q to record macro
nnoremap m q
" Ctrl+S to save file
nnoremap <silent> <C-S> :<C-u>w<CR>
" Shift+HJKL to quickly move cursor
nnoremap K 7<up>
nnoremap J 7<down>
nnoremap H 0
nnoremap L $
" Shift+Up/Down/Left/Right to quickly move cursor
nnoremap <S-up> <Esc>7<up>
nnoremap <S-down> <Esc>7<down>
nnoremap <S-left> <Esc>0
nnoremap <S-right> <Esc>$
" x to delete current character without saving it to register
nnoremap x "_x
" <leader>y to yank to system clipboard
if custom#utils#check_clipboard() ==# 1
  nmap <leader>y "*y
else
  nmap <leader>y "+y
endif
" <leader>p to paste from system clipboard
if custom#utils#check_clipboard() ==# 1
  nmap <leader>p "*p
else
  nmap <leader>p "+p
endif
" Alt+T to create a new tab
if g:vim_mode ==# 'full'
  nnoremap <silent> <A-t> :<C-u>tabnew<CR>:call custom#dashboard#launch_startify()<CR>
else
  nnoremap <silent> <A-t> :<C-u>tabnew<CR>
endif
" Alt+W to close current tab
nnoremap <silent> <A-w> :<C-u>tabc<CR>
" Alt+Left/Right to switch tabs
nnoremap <A-left> <Esc>gT
nnoremap <A-right> <Esc>gt
" Alt+</> to switch tabs
nnoremap <A-,> <Esc>gT
nnoremap <A-.> <Esc>gt
" Alt+Up/Down to move tabs
nnoremap <silent> <A-up> :<C-u>tabm -1<CR>
nnoremap <silent> <A-down> :<C-u>tabm +1<CR>
" Alt+N/M to move tabs
nnoremap <silent> <A-n> :<C-u>tabm -1<CR>
nnoremap <silent> <A-m> :<C-u>tabm +1<CR>
" Alt+HJKL to jump between windows
nnoremap <silent> <A-h> :<C-u>wincmd h<CR>
nnoremap <silent> <A-l> :<C-u>wincmd l<CR>
nnoremap <silent> <A-k> :<C-u>wincmd k<CR>
nnoremap <silent> <A-j> :<C-u>wincmd j<CR>
" Alt+Shift+HJKL to adjust window size
nnoremap <silent> <A-J> :<C-u>wincmd +<CR>
nnoremap <silent> <A-K> :<C-u>wincmd -<CR>
nnoremap <silent> <A-H> :<C-u>wincmd <<CR>
nnoremap <silent> <A-L> :<C-u>wincmd ><CR>
" Alt+V/S to split new window
nnoremap <silent> <A-v> :<C-u>vsp<CR>
nnoremap <silent> <A-s> :<C-u>sp<CR>
" Alt+Shift+V/S to toggle vertical/horizontal layout in Neovim
if has('nvim')
  nnoremap <silent> <A-V> :<C-u>wincmd t<CR>:wincmd H<CR>
  nnoremap <silent> <A-S> :<C-u>wincmd t<CR>:wincmd K<CR>
endif
" z+Up/Down/Left/Right to jump between folding nodes
nnoremap z<left> zk
nnoremap z<right> zj
nnoremap z<up> [z
nnoremap z<down> ]z
" z+hjkl to jump between folding nodes
nnoremap zh zk
nnoremap zl zj
nnoremap zj ]z
nnoremap zk [z
" zs/zl to save/load folding views
nnoremap zs :<C-u>mkview<CR>
nnoremap zl :<C-u>loadview<CR>
" <leader><space><space>h to get the hi groups under current cursor
nnoremap <leader><space>h :<C-u>call custom#utils#get_highlight()<CR>
" <leader>ji/jI to jump between indents
nnoremap <silent> <leader>ji :<C-u>call custom#utils#go_indent(v:count1, 1)<cr>
nnoremap <silent> <leader>jI :<C-u>call custom#utils#go_indent(v:count1, -1)<cr>
" }}}
" {{{Insert Mode
" Alt+X/Alt+Z/Ctrl+Z to enter normal mode
inoremap <A-x> <ESC><right>
inoremap <A-z> <ESC><right>
inoremap <C-z> <ESC><right>
if !has('nvim')
  inoremap ^@ <ESC>
endif
" Ctrl+V to paste from buffer
inoremap <C-V> <Space><Backspace><ESC>pa
" <A-v> to paste from system clipboard
if custom#utils#check_clipboard() ==# 1
  imap <A-V> <Space><Backspace><ESC>"*pa
else
  imap <A-V> <Space><Backspace><ESC>"+pa
endif
" Ctrl+S to save file
inoremap <silent> <C-S> <Esc>:w<CR>a
" Alt+Left/Right to switch tabs
inoremap <A-left> <Esc>gTi
inoremap <A-right> <Esc>gti
" Alt+</> to switch tabs
inoremap <A-,> <Esc>gTi
inoremap <A-.> <Esc>gti
" Alt+HJKL to jump between windows
inoremap <silent> <A-h> <Esc>:<C-u>wincmd h<CR>i
inoremap <silent> <A-l> <Esc>:<C-u>wincmd l<CR>i
inoremap <silent> <A-k> <Esc>:<C-u>wincmd k<CR>i
inoremap <silent> <A-j> <Esc>:<C-u>wincmd j<CR>i
" Shift+Up/Down/Left/Right to quickly move cursor
inoremap <silent><expr> <S-up> pumvisible() ? "\<Space>\<Backspace>\<up>\<up>\<up>\<up>\<up>" : "\<up>\<up>\<up>\<up>\<up>"
inoremap <silent><expr> <S-down> pumvisible() ? "\<Space>\<Backspace>\<down>\<down>\<down>\<down>\<down>" : "\<down>\<down>\<down>\<down>\<down>"
inoremap <S-left> <ESC>I
inoremap <S-right> <ESC>A
" }}}
" {{{Visual Mode
" Alt+X/Alt+z/Ctrl+Z to enter normal mode
vnoremap <A-x> <ESC>
snoremap <A-x> <ESC>
vnoremap <A-z> <ESC>
snoremap <A-z> <ESC>
vnoremap <C-z> <ESC>
snoremap <C-z> <ESC>
if !has('nvim')
  vnoremap ^@ <ESC>
endif
" ; to enter command mode
vnoremap ; :
" x to delete selected text without saving it to register
vnoremap x "_x
" Shift+Up/Down/Left/Right to quickly move cursor
vnoremap <S-up> <up><up><up><up><up>
vnoremap <S-down> <down><down><down><down><down>
vnoremap <S-left> 0
if has('nvim')
  vnoremap <S-right> $
else
  vnoremap <S-right> $<left>
endif
" Shift+HJKL to quickly move cursor
vnoremap K 5<up>
vnoremap J 5<down>
vnoremap H 0
vnoremap L $h
" <leader>y to yank to system clipboard
if custom#utils#check_clipboard() ==# 1
  vmap <leader>y "*y
else
  vmap <leader>y "+y
endif
" <leader>p to paste from system clipboard
if custom#utils#check_clipboard() ==# 1
  vmap <leader>p "*p
else
  vmap <leader>p "+p
endif
" }}}
" {{{Command Mode
" Alt+X/Alt+Z/Ctrl+Z to enter normal mode
cmap <A-x> <ESC>
cmap <A-z> <ESC>
cmap <C-z> <ESC>
if !has('nvim')
  cmap ^@ <ESC>
endif
" Ctrl+A to jump to the beginning of line
cmap <C-a> <C-b>
" }}}
" {{{Terminal Mode
" Alt+X/Alt+Z/Ctrl+Z to enter normal mode
tnoremap <A-x> <C-\><C-n>
tnoremap <A-z> <C-\><C-n>
tnoremap <C-z> <C-\><C-n>
" Alt+HJKL to jump between windows
tnoremap <silent> <A-h> <C-\><C-n>:<C-u>wincmd h<CR>
tnoremap <silent> <A-j> <C-\><C-n>:<C-u>wincmd j<CR>
tnoremap <silent> <A-k> <C-\><C-n>:<C-u>wincmd k<CR>
tnoremap <silent> <A-l> <C-\><C-n>:<C-u>wincmd l<CR>
" Alt+Left/Right to switch tabs
tnoremap <A-left> <C-\><C-n>gT
tnoremap <A-right> <C-\><C-n>gt
" Alt+Up/Down to move tabs
tnoremap <silent> <A-up> <C-\><C-n>:<C-u>tabm -1<CR>
tnoremap <silent> <A-down> <C-\><C-n>:<C-u>tabm +1<CR>
" Shift+Up/Down/Left/Right to quickly move cursor
tnoremap <S-left> <C-a>
tnoremap <S-right> <C-e>
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
