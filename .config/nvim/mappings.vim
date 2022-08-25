" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/mappings.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

" {{{Normal Mode
" Leader key
let g:mapleader = "\<Space>"
nnoremap <SPACE> <Nop>
" Alt+X to enter normal mode
nnoremap <A-x> <ESC>
if !has('nvim')
  nnoremap ^@ <ESC>
else
  nnoremap <silent> <C-l> :<C-u>wincmd p<CR>
endif
" ; to enter command mode
nnoremap ; :
" q to quit
nmap <silent> q :<C-u>q<CR>
" Q to force quit
nmap <silent> Q :<C-u>q!<CR>
" <leader>q to close quickfix list
nnoremap <silent> <leader>q :<C-u>cclose<CR>
" m to record macro
nnoremap m q
" Ctrl+S to save file
nnoremap <silent> <C-S> :<C-u>w<CR>
" Shift+HJKL to quickly move cursor
nnoremap K 7<up>
nnoremap J 7<down>
nnoremap H 0
nnoremap L $
" Shift+ArrowKeys to quickly move cursor
nnoremap <S-up> <Esc>7<up>
nnoremap <S-down> <Esc>7<down>
nnoremap <S-left> <Esc>0
nnoremap <S-right> <Esc>$
" x to delete chars but not yank
nnoremap x "_x
" <leader>y to yank to system clipboard
nnoremap <leader>y "+y
" <leader>p to paste from system clipboard
nnoremap <leader>p "+p
" Alt+T to create a new tab
if g:vim_mode ==# 'full'
  nnoremap <silent> <A-t> :<C-u>tabnew<CR>:call custom#explorer#startify()<CR>
else
  nnoremap <silent> <A-t> :<C-u>tabnew<CR>
endif
" Alt+W to close current tab
nnoremap <silent> <A-w> :<C-u>call custom#utils#close_on_last_tab()<CR>
" Alt+Left/Right to switch tabs
nnoremap <A-left> <Esc>gT
nnoremap <A-right> <Esc>gt
" Alt+</> to switch tabs
nnoremap <A-,> <Esc>gT
nnoremap <A-.> <Esc>gt
" Alt+Up/Down to move tabs
nnoremap <silent> <A-up> :<C-u>tabm -1<CR>
nnoremap <silent> <A-down> :<C-u>tabm +1<CR>
" Alt+z Alt+</> to move tabs
nnoremap <silent> <A-z><A-,> :<C-u>tabm -1<CR>
nnoremap <silent> <A-z><A-.> :<C-u>tabm +1<CR>
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
" In neovim, Alt+Shift+V/S to toggle vertical/horizontal layout
if has('nvim')
  nnoremap <silent> <A-V> :<C-u>wincmd t<CR>:wincmd H<CR>
  nnoremap <silent> <A-S> :<C-u>wincmd t<CR>:wincmd K<CR>
endif
" z+ArrowKeys to jump between folding nodes
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
" Get the hi groups under current cursor
nnoremap <leader><space><space>h :<C-u>call custom#utils#get_highlight()<CR>
" gi/gI to jump between indents
nnoremap <silent> gi :<C-u>call custom#utils#go_indent(v:count1, 1)<cr>
nnoremap <silent> gI :<C-u>call custom#utils#go_indent(v:count1, -1)<cr>
" }}}
" {{{Insert Mode
" Alt+X to enter normal mode
inoremap <A-x> <ESC><right>
if !has('nvim')
  inoremap ^@ <ESC>
endif
" Ctrl+V to paste from buffer
inoremap <C-V> <Space><Backspace><ESC>pa
" <A-z><C-v> to paste from system clipboard
inoremap <A-z><C-V> <Space><Backspace><ESC>"+pa
" Ctrl+S to save file
inoremap <silent> <C-S> <Esc>:w<CR>a
" Shift+ArrowKeys to quickly move cursor
inoremap <silent><expr> <S-up> pumvisible() ? "\<Space>\<Backspace>\<up>\<up>\<up>\<up>\<up>" : "\<up>\<up>\<up>\<up>\<up>"
inoremap <silent><expr> <S-down> pumvisible() ? "\<Space>\<Backspace>\<down>\<down>\<down>\<down>\<down>" : "\<down>\<down>\<down>\<down>\<down>"
inoremap <S-left> <ESC>I
inoremap <S-right> <ESC>A
" }}}
" {{{Visual Mode
" Alt+X to enter normal mode
vnoremap <A-x> <ESC>
snoremap <A-x> <ESC>
if !has('nvim')
  vnoremap ^@ <ESC>
endif
" ; to enter command mode
vnoremap ; :
" x to delete selected text but not yank
vnoremap x "_x
" Shift+ArrowKeys to quickly move cursor
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
vnoremap <leader>y "+y
" <leader>p to paste from system clipboard
vnoremap <leader>p "+p
" }}}
" {{{Command Mode
" Alt+X to enter normal mode
cmap <A-x> <ESC>
if !has('nvim')
  cmap ^@ <ESC>
endif
" Ctrl+S to save file
cmap <C-S> :<C-u>w<CR>
" }}}
" {{{Terminal Mode
" Alt+X to enter normal mode
tnoremap <A-x> <C-\><C-n>
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
" Shift+ArrowKeys to quickly move cursor
tnoremap <S-left> <C-a>
tnoremap <S-right> <C-e>
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
