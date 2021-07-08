" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/mappings.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 && MIT
" =============================================================================

" {{{Vim Compatible
" sed -n l
if !has('nvim')
  execute "set <M-a>=\ea"
  execute "set <M-b>=\eb"
  execute "set <M-c>=\ec"
  execute "set <M-d>=\ed"
  execute "set <M-e>=\ee"
  execute "set <M-f>=\ef"
  execute "set <M-g>=\eg"
  execute "set <M-h>=\eh"
  execute "set <M-i>=\ei"
  execute "set <M-j>=\ej"
  execute "set <M-k>=\ek"
  execute "set <M-l>=\el"
  execute "set <M-m>=\em"
  execute "set <M-n>=\en"
  execute "set <M-o>=\eo"
  execute "set <M-p>=\ep"
  execute "set <M-q>=\eq"
  execute "set <M-r>=\er"
  execute "set <M-s>=\es"
  execute "set <M-t>=\et"
  execute "set <M-u>=\eu"
  execute "set <M-v>=\ev"
  execute "set <M-w>=\ew"
  execute "set <M-x>=\ex"
  execute "set <M-y>=\ey"
  execute "set <M-z>=\ez"
  execute "set <M-,>=\e,"
  execute "set <M-.>=\e."
  execute "set <M-->=\e-"
  execute "set <M-=>=\e="
endif
" }}}
" {{{Normal Mode
" Leader key
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<A-z>"
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
" Alt+Up/Down to move tabs
nnoremap <silent> <A-up> :<C-u>tabm -1<CR>
nnoremap <silent> <A-down> :<C-u>tabm +1<CR>
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
" zo/zc to open/close foldings
nnoremap zo zO
nnoremap zc zC
" zO/zC to open/close foldings recursively
nnoremap zO zR
nnoremap zC zM
" zf/zd to create/delete new foldings
nnoremap zf zf
nnoremap zd zd
" zs/zl to save/load folding views
nnoremap zs :<C-u>mkview<CR>
nnoremap zl :<C-u>loadview<CR>
" Get the hi groups under current cursor
nnoremap <leader><Space>h :<C-u>call custom#utils#get_highlight()<CR>
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
vnoremap <S-right> $<left>
" Shift+HJKL to quickly move cursor
vnoremap K 5<up>
vnoremap J 5<down>
vnoremap H 0
vnoremap L $h
" <leader>y to yank to system clipboard
vnoremap <leader>y "+y
" <leader>p to paste from system clipboard
vnoremap <leader>p "+p
" * to search for selected text
vnoremap <silent> * :<C-u>call custom#utils#escaped_search()<CR>/<C-R>=@/<CR><CR>N
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
if has('nvim')
  " Alt+X to enter normal mode
  tnoremap <A-x> <C-\><C-n>
  " Shift+ArrowKeys to quickly move cursor
  tnoremap <S-left> <C-a>
  tnoremap <S-right> <C-e>
endif
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
