" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/features/light.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 && MIT
" =============================================================================

" {{{Color schemes
execute 'call custom#colorscheme#' . g:vim_color_scheme . '()'
" }}}
" {{{Additional UI components
" {{{vim-which-key
let g:which_key_sort_horizontal = 1
let g:which_key_sep = ''
let g:which_key_display_names = {' ': '', '<CR>': '↵', '<C-H>': '', '<C-I>': 'ﲑ', '<TAB>': '⇆'}
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
call which_key#register('<Space>', 'g:which_key_map')
if !exists('g:which_key_map')
  let g:which_key_map = {
        \ 'name': 'Alpha',
        \ "\<space>": {
          \ 'name': 'Beta',
          \ "\<space>": {
            \ 'name': 'Omega'
            \ }
          \ }
        \ }
endif
let g:which_key_map['p'] = 'paste'
let g:which_key_map['q'] = 'close quickfix'
let g:which_key_map['y'] = 'yank'
let g:which_key_map["\<space>"]["\<space>"]['h'] = 'highlight'
" }}}
" {{{incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
augroup IncsearchCustom
  autocmd!
  autocmd User IncSearchEnter set hlsearch
augroup END
" }}}
" }}}
" {{{Text objects
call textobj#user#plugin('line', {
      \   '-': {
      \     'select-a-function': 'custom#textobj#al',
      \     'select-a': 'al',
      \     'select-i-function': 'custom#textobj#il',
      \     'select-i': 'il',
      \   },
      \ })
" }}}
" {{{Git Integration
if !exists("g:which_key_map['g']")
  let g:which_key_map['g'] = {'name': 'git'}
endif
let g:which_key_map['g']['d'] = 'diff unstaged'
let g:which_key_map['g']['w'] = 'write and stage'
noremap <silent> <leader>gd :Gdiffsplit<cr>
noremap <silent> <leader>gw :Gwrite<cr>
" {{{twiggy
command Gbranch Twiggy
nnoremap <silent> <leader>gB :<C-u>Twiggy<CR>
let g:which_key_map['g']['B'] = 'branch'
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_num_columns = 35
let g:twiggy_close_on_fugitive_command = 1
let g:twiggy_remote_branch_sort = 'date'
let g:twiggy_show_full_ui = 0
" }}}
" {{{mergetool
let g:mergetool_layout = 'lr,m'  " `l`, `b`, `r`, `m`
let g:mergetool_prefer_revision = 'base'  " `local`, `base`, `remote`
nmap <leader>gm <plug>(MergetoolToggle)
let g:which_key_map['g']['m'] = 'merge'
" }}}
" }}}
" {{{Movement
" {{{comfortable-motion.vim
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
nnoremap <silent> <pagedown> :<C-u>call comfortable_motion#flick(130)<CR>
nnoremap <silent> <pageup> :<C-u>call comfortable_motion#flick(-130)<CR>
" }}}
" {{{vim-sneak
let g:sneak#s_next = 1
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
" }}}
" {{{any-jump.vim
let g:any_jump_disable_default_keybindings = 1
nnoremap gd :AnyJump<CR>
xnoremap gd :AnyJumpVisual<CR>
" }}}
" {{{vim-wordmotion
let g:wordmotion_disable_default_mappings = v:true
nmap W <Plug>WordMotion_w
omap W <Plug>WordMotion_w
xmap W <Plug>WordMotion_w
nmap B <Plug>WordMotion_b
omap B <Plug>WordMotion_b
xmap B <Plug>WordMotion_b
nmap E <Plug>WordMotion_e
omap E <Plug>WordMotion_e
xmap E <Plug>WordMotion_e
nmap gE <Plug>WordMotion_ge
omap gE <Plug>WordMotion_ge
xmap gE <Plug>WordMotion_ge
omap aW <Plug>WordMotion_aw
xmap aW <Plug>WordMotion_aw
omap iW <Plug>WordMotion_iw
xmap iW <Plug>WordMotion_iw
" }}}
" }}}
" {{{Pairs
" {{{auto-pairs
let g:AutoPairsShortcutToggle = '<A-c>p'
let g:AutoPairsShortcutFastWrap = '<A-c>`sadsfvf'
let g:AutoPairsShortcutJump = '<A-n>'
let g:AutoPairsWildClosedPair = ''
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0
let g:AutoPairsMapCh = 0
inoremap <A-c>' '
inoremap <A-c>" "
inoremap <A-c>` `
inoremap <A-c>( (
inoremap <A-c>[ [
inoremap <A-c>{ {
inoremap <A-c>) )
inoremap <A-c>] ]
inoremap <A-c>} }
inoremap <A-Backspace> <Space><Esc><left>"_xa<Backspace>
" }}}
" {{{vim-matchup
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_hi_surround_always = 1
let g:matchup_delim_noskips = 2
let g:matchup_mouse_enabled = 0
" }}}
" {{{vim-closetag
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<A-c>>'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx'
" }}}
" }}}
" {{{Other basic features
" {{{vim-peekaboo
let g:peekaboo_delay = 500
" }}}
" {{{filetype.nvim
let g:did_load_filetypes = 1
" }}}
" }}}
" {{{Extended functional components
" {{{vim-visual-multi
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Switch Mode']                 = 'v'
let g:VM_maps['Add Cursor At Pos']           = '`'
let g:VM_maps['Visual Cursors']              = '`'
" }}}
" {{{nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDCreateDefaultMappings = 0
nmap <leader>ca <Plug>NERDCommenterComment
nmap <leader>cu <Plug>NERDCommenterUncomment
nmap <leader>cc <Plug>NERDCommenterToggle
xmap <leader>ca <Plug>NERDCommenterComment
xmap <leader>cu <Plug>NERDCommenterUncomment
xmap <leader>cc <Plug>NERDCommenterToggle
let g:which_key_map['c'] = {
      \   'name': 'comment',
      \   'a': 'comment',
      \   'u': 'uncomment',
      \   'c': 'toggle',
      \   }
" }}}
" {{{asynctasks
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asynctasks_term_pos = 'bottom' " tab
let g:asynctasks_term_rows = 10
let g:asynctasks_config_name = '.git/tasks.ini'
noremap <silent> <leader>trf :AsyncTask file-run<cr>
noremap <silent> <leader>trp :AsyncTask project-run<cr>
noremap <silent> <leader>tbf :AsyncTask file-build<cr>
noremap <silent> <leader>tbp :AsyncTask project-build<cr>
noremap <silent> <leader>te :AsyncTaskEdit<cr>
noremap <silent> <leader>g^s :AsyncRun git config --global http.proxy "socks5://127.0.0.1:1080"<cr>
noremap <silent> <leader>g^h :AsyncRun git config --global http.proxy "http://127.0.0.1:1081"<cr>
noremap <silent> <leader>g$ :AsyncRun git config --global --unset http.proxy<cr>
noremap <silent> <leader>gp :AsyncRun git push origin HEAD<cr>
noremap <silent> <leader>gf :AsyncRun git fetch origin<cr>
noremap <silent> <leader>gc :Git commit<cr>
let g:which_key_map['t'] = {
      \ 'name': 'task',
      \ 'r': {'name': 'run task', 'f': 'file', 'p': 'project'},
      \ 'b': {'name': 'build task', 'f': 'file', 'p': 'project'},
      \ 'e': 'edit config'
      \ }
let g:which_key_map['g']['^'] = {'name': 'set proxy', 's': 'socks5', 'h': 'http'}
let g:which_key_map['g']['$'] = 'unset proxy'
let g:which_key_map['g']['c'] = 'commit'
let g:which_key_map['g']['p'] = 'push'
let g:which_key_map['g']['f'] = 'fetch'
" }}}
" {{{vim-translator
let g:translator_target_lang = 'zh'
let g:translator_source_lang = 'auto'
let g:translator_default_engines = ['haici']
nmap <leader><space>t <Plug>TranslateW
vmap <leader><space>t <Plug>TranslateWV
let g:which_key_map["\<space>"]['t'] = 'translate'
" }}}
" {{{limelight.vim
let g:limelight_default_coefficient = 0.7
" }}}
" {{{goyo.vim
let g:goyo_width = 95
let g:goyo_height = 85
let g:goyo_linenr = 0
augroup GoyoCustom
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END
nnoremap <silent> <leader><space><space>f :<C-u>Limelight!!<CR>
nnoremap <silent> <leader><space><space>r :<C-u>Goyo<CR>
let g:which_key_map["\<space>"]["\<space>"]['f'] = 'focus mode'
let g:which_key_map["\<space>"]["\<space>"]['r'] = 'reading mode'
" }}}
" {{{pomodoro.vim
let g:pomodoro_time_work = 25
let g:pomodoro_time_slack = 5
let g:pomodoro_status = 0
nnoremap <silent> <leader><space><space>p :<c-u>call custom#utils#toggle_pomodoro()<cr>
let g:which_key_map["\<space>"]["\<space>"]['p'] = 'pomodoro toggle'
" }}}
" {{{mundo
let g:mundo_right = 1
nnoremap <silent> <leader><space><space>u :<c-u>MundoToggle<cr>
let g:which_key_map["\<space>"]["\<space>"]['u'] = 'undo'
" }}}
" {{{inline_edit.vim
nnoremap <silent> <leader><space>e :<C-u>InlineEdit<CR>
vnoremap <silent> <leader><space>e :InlineEdit<CR>
let g:which_key_map["\<space>"]['e'] = 'inline edit'
" }}}
" {{{suda.vim
command! -nargs=1 E  edit  suda://<args>
command W w suda://%
" }}}
" {{{vim-manpager
if exists('g:vim_man_pager') && !has('win32')
  function! s:vim_manpager_mappings() abort
    nmap <C-]> <Plug>(manpager-open)
    nmap <silent><buffer> <C-j> ]t
    nmap <silent><buffer> <C-k> [t
    nnoremap <silent><buffer> E :<C-u>set modifiable<CR>
  endfunction
  augroup ManPagerCustom
    autocmd!
    autocmd FileType man call s:vim_manpager_mappings()
  augroup END
endif
" }}}
" {{{vim-paste-rs
nmap <leader><space>p <Plug>(paste-rs)
xmap <leader><space>p <Plug>(paste-rs)
let g:which_key_map["\<space>"]['p'] = 'paste.rs'
" }}}
" }}}
" {{{Productivity
if g:vim_mode ==# 'light'
  " {{{nerdtree
  nnoremap <silent> <C-b> :<C-u>NERDTreeToggle<CR>
  let g:NERDTreeMinimalUI=1
  " }}}
  " {{{vim-mucomplete
  let g:mucomplete#enable_auto_at_startup = 1
  " }}}
endif
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
