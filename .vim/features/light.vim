" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .vim/features/light.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

" {{{Color schemes
execute 'call custom#colorscheme#' . g:vim_color_scheme . '()'
" }}}
" {{{Additional UI components
" {{{vim-which-key
let g:which_key_sort_horizontal = 1
let g:which_key_sep = ''
let g:which_key_display_names = {' ': '', '<CR>': '󰌑', '<C-H>': '', '<C-I>': '󰞓', '<TAB>': '⇆'}
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
call which_key#register('<Space>', 'g:which_key_map')
" Mappings registered in mappings.vim
let g:which_key_map['p'] = 'paste'
let g:which_key_map['q'] = 'close quickfix'
let g:which_key_map['y'] = 'yank'
let g:which_key_map["\<space>"]['h'] = 'highlight'
if !exists("g:which_key_map['j']")
  let g:which_key_map['j'] = { 'name': 'jump'}
endif
let g:which_key_map['j']['i'] = 'next indent'
let g:which_key_map['j']['I'] = 'prev indent'
" }}}
" {{{indentLine
call plug#load('indentLine')
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_char = ''  " ¦┆│⎸▏
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = [ 'startify', 'coc-explorer', 'codi', 'help', 'man', 'vtm', 'markdown' ]
let g:indentLine_setColors = 0  " disable overwrite with grey by default, use colorscheme instead
" }}}
" }}}
" {{{Operators
" {{{vim-operator-replace
map <silent> <leader>r <Plug>(operator-replace)
let g:which_key_map['r'] = 'replace'
" }}}
" {{{vim-operator-surround
map <silent> <leader>sa <Plug>(operator-surround-append)
map <silent> <leader>sd <Plug>(operator-surround-delete)
map <silent> <leader>sr <Plug>(operator-surround-replace)
let g:which_key_map['s'] = {
      \ 'name': 'surround',
      \ 'a': 'append',
      \ 'd': 'delete',
      \ 'r': 'replace'
      \ }
" }}}
" }}}
" {{{Git Integration
" {{{vim-fugitive
if !exists("g:which_key_map['g']")
  let g:which_key_map['g'] = {'name': 'git'}
endif
noremap <silent> <leader>gc :<C-u>Git commit<cr>
noremap <silent> <leader>gd :<C-u>Gdiffsplit<cr>:wincmd h<cr>:set wrap<cr>:wincmd l<cr>:set wrap<cr>
noremap <silent> <leader>gw :<C-u>Gwrite<cr>
let g:which_key_map['g']['c'] = 'commit'
let g:which_key_map['g']['d'] = 'diff unstaged'
let g:which_key_map['g']['w'] = 'write and stage'
" {{{twiggy
function s:twiggy_toggle() abort
  if g:twiggy_loaded == 0
    call plug#load('vim-fugitive')
    call FugitiveDetect(getcwd())
    let g:twiggy_loaded = 1
  endif
  Twiggy
endfunction
let g:twiggy_loaded = 0
command Gbranch Twiggy
nnoremap <silent> <leader>gb :<C-u>call <SID>twiggy_toggle()<CR>
let g:which_key_map['g']['b'] = 'branch'
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_num_columns = 35
let g:twiggy_close_on_fugitive_command = 1
let g:twiggy_remote_branch_sort = 'date'
let g:twiggy_show_full_ui = 0
" }}}
" }}}
" {{{mergetool
let g:mergetool_layout = 'lr,m'  " `l`, `b`, `r`, `m`
let g:mergetool_prefer_revision = 'base'  " `local`, `base`, `remote`
nmap <leader>gm <plug>(MergetoolToggle)
let g:which_key_map['g']['m'] = 'merge'
" }}}
" }}}
" {{{Movement
" {{{CamelCaseMotion
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
" }}}
" {{{vim-smartword
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
function s:smartword_mappings() abort
  map <Plug>(smartword-basic-w) <Plug>CamelCaseMotion_w
  map <Plug>(smartword-basic-b) <Plug>CamelCaseMotion_b
  map <Plug>(smartword-basic-e) <Plug>CamelCaseMotion_e
endfunction
augroup SmartWordCustom
  autocmd!
  autocmd VimEnter * call <SID>smartword_mappings()
augroup END
" }}}
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
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
" }}}
" }}}
" {{{Search
" {{{vim-asterisk
map *   <Plug>(asterisk-z*)
map #   <Plug>(asterisk-z#)
map g*  <Plug>(asterisk-gz*)
map g#  <Plug>(asterisk-gz#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
" }}}
" {{{vim-cool
let g:cool_total_matches = 1
" }}}
" }}}
" {{{Pairs
" {{{auto-pairs
let g:AutoPairsShortcutToggle = '<A-c>p'
let g:AutoPairsShortcutFastWrap = '<A-c>`sadsfvf'
let g:AutoPairsShortcutJump = '<A-c>n'
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
inoremap <A-c><Backspace> <Space><Esc><left>"_xa<Backspace>
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
" {{{vim-fixkey
" sed -n l
if !has('nvim')
  execute "set <M-,>=\e,"
  execute "set <M-.>=\e."
  execute "set <M-->=\e-"
  execute "set <M-=>=\e="
endif
" }}}
" {{{editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" }}}
" {{{vim-peekaboo
let g:peekaboo_delay = 500
" }}}
" {{{vim-rooter
let g:rooter_patterns = g:root_patterns
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1
" }}}
" }}}
" {{{Functional components
" {{{asynctasks
let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'bottom' " tab
let g:asynctasks_term_rows = 10
let g:asynctasks_config_name = '.git/tasks.ini'
noremap <silent> <leader>trf :<C-u>AsyncTask file-run<cr>
noremap <silent> <leader>trp :<C-u>AsyncTask project-run<cr>
noremap <silent> <leader>tbf :<C-u>AsyncTask file-build<cr>
noremap <silent> <leader>tbp :<C-u>AsyncTask project-build<cr>
noremap <silent> <leader>te :<C-u>AsyncTaskEdit<cr>
noremap <silent> <leader>gp :<C-u>AsyncRun git push origin HEAD<cr>
let g:which_key_map['t'] = {
      \ 'name': 'task',
      \ 'r': {'name': 'run task', 'f': 'file', 'p': 'project'},
      \ 'b': {'name': 'build task', 'f': 'file', 'p': 'project'},
      \ 'e': 'edit config'
      \ }
let g:which_key_map['g']['p'] = 'push'
" }}}
" {{{vim-visual-multi
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Add Cursor At Pos'] = '`'
let g:VM_maps['Visual Cursors'] = '`'
let g:VM_maps['Switch Mode'] = 'v'
nmap ` <Plug>(VM-Add-Cursor-At-Pos)
vmap ` <Plug>(VM-Visual-Cursors)
xmap ` <Plug>(VM-Visual-Cursors)
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
      \ 'name': 'comment',
      \ 'a': 'comment',
      \ 'u': 'uncomment',
      \ 'c': 'toggle',
      \ }
" }}}
" {{{vim-test
nmap <silent> <leader>atc :<C-u>TestNearest<CR>
nmap <silent> <leader>atC :<C-u>TestClass<CR>
nmap <silent> <leader>atf :<C-u>TestFile<CR>
nmap <silent> <leader>ats :<C-u>TestSuite<CR>
nmap <silent> <leader>att :<C-u>TestLast<CR>
nmap <silent> <leader>ato :<C-u>TestVisit<CR>
let test#strategy = 'asyncrun'
if !exists("g:which_key_map['a']")
  let g:which_key_map['a'] = { 'name': 'action'}
endif
let g:which_key_map['a']['t'] = {
      \ 'name': 'test',
      \ 'c': 'cursor',
      \ 'C': 'class',
      \ 'f': 'file',
      \ 's': 'suite',
      \ 't': 'last test',
      \ 'o': 'open',
      \ }
" }}}
" {{{vim-dadbod-ui
let g:db_ui_save_location = custom#utils#get_path([custom#utils#stdpath('cache'), 'dbui'])
let g:db_ui_win_position = 'right'
let g:db_ui_winwidth = 40
let g:db_ui_show_database_icon = 1
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_icons = {
      \ 'expanded': {
        \ 'db': '▾ ',
        \ 'buffers': '▾ ',
        \ 'saved_queries': '▾ ',
        \ 'schemas': '▾ ',
        \ 'schema': '▾ ',
        \ 'tables': '▾ ',
        \ 'table': '▾ 󰓫',
        \ },
      \ 'collapsed': {
        \ 'db': '▸ ',
        \ 'buffers': '▸ ',
        \ 'saved_queries': '▸ ',
        \ 'schemas': '▸ ',
        \ 'schema': '▸ ',
        \ 'tables': '▸ ',
        \ 'table': '▸ 󰓫',
        \ },
      \ 'saved_query': '',
      \ 'new_query': '󰓰',
      \ 'tables': '',
      \ 'buffers': '',
      \ 'add_connection': '󰆺',
      \ 'connection_ok': '✓',
      \ 'connection_error': '✕',
      \ }
nmap <leader><space>D :<C-u>DBUIToggle<CR>
let g:which_key_map["\<space>"]['D'] = 'database'
" }}}
" {{{devdocs.vim
nmap <leader><space>dbc <Plug>(devdocs-under-cursor)
nmap <leader><space>dba <Plug>(devdocs-under-cursor-all)
let g:which_key_map["\<space>"]['d'] = {
      \ 'name': 'API docs',
      \ 'b' : {
        \ 'name': 'devdocs (browser)',
        \ 'c': 'search in current file type',
        \ 'a': 'search in all file types'
        \ },
      \ }
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
nnoremap <silent> <leader><space>f :<C-u>Limelight!!<CR>
let g:which_key_map["\<space>"]['f'] = 'focus mode'
" }}}
" {{{goyo.vim
let g:goyo_width = 95
let g:goyo_height = 85
let g:goyo_linenr = 0
augroup GoyoCustom
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END
nnoremap <silent> <leader><space>r :<C-u>Goyo<CR>
let g:which_key_map["\<space>"]['r'] = 'reading mode'
" }}}
" {{{undotree
let g:undotree_WindowLayout = 3
let g:undotree_SplitWidth = 30
let g:undotree_SetFocusWhenToggle = 1
nnoremap <silent> <leader><space>u :<c-u>UndotreeToggle<cr>
let g:which_key_map["\<space>"]['u'] = 'undo tree'
" }}}
" {{{inline_edit.vim
nnoremap <silent> <leader><space>e :<C-u>InlineEdit<CR>
vnoremap <silent> <leader><space>e :InlineEdit<CR>
let g:which_key_map["\<space>"]['e'] = 'inline edit'
" }}}
" {{{vim-paste-rs
nmap <leader><space>sp <Plug>(paste-rs)
xmap <leader><space>sp <Plug>(paste-rs)
let g:which_key_map["\<space>"]['s'] = {
      \ 'name': 'share code snippet',
      \ 'p': 'paste.rs',
      \ }
" }}}
" {{{vim-carbon-now-sh
nnoremap <silent> <leader><space>sc ggVG:<C-u>CarbonNowSh<CR>
vnoremap <silent> <leader><space>sc :CarbonNowSh<CR>
let g:which_key_map["\<space>"]['s']['c'] = 'carbon.now.sh'
let g:carbon_now_sh_options = {
      \ 'ln': 'true',
      \ 'fm': 'Source Code Pro'
      \ }
" }}}
" {{{vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_auto_save = 1
let g:bookmark_auto_save_file = custom#utils#get_path([custom#utils#stdpath('cache'), 'bookmarks'])
let g:bookmark_save_per_working_dir = 1
let g:bookmark_highlight_lines = 1
nnoremap <silent> <leader>bb :<C-u>BookmarkToggle<CR>
nnoremap <silent> <leader>ba :<C-u>BookmarkAnnotate<CR>
nnoremap <silent> <leader>bc :<C-u>BookmarkClear<CR>
nnoremap <silent> <leader>bC :<C-u>BookmarkClearAll<CR>
nnoremap <silent> <leader>bs :<C-u>BookmarkShowAll<CR>
nnoremap <silent> <leader>jb :<C-u>BookmarkNext<CR>
nnoremap <silent> <leader>jB :<C-u>BookmarkPrev<CR>
let g:which_key_map['b'] = {
      \ 'name': 'bookmarks',
      \ 'b': 'toggle',
      \ 'a': 'annotate',
      \ 'c': 'clear current buffer',
      \ 'C': 'clear all',
      \ 's': 'show all',
      \ }
let g:which_key_map['j']['b'] = 'next bookmark'
let g:which_key_map['j']['B'] = 'prev bookmark'
" }}}
" {{{vim-manpager
let g:manpager_disable_default_mappings = 1
function! s:manpager_mappings() abort
  nmap <buffer><nowait> <CR>          <Plug>(manpager-open)
  nmap <buffer><nowait> <C-]>         <Plug>(manpager-open)
  nmap <buffer><nowait> <2-LeftMouse> <Plug>(manpager-open)
  xmap <buffer><nowait> <CR>          <Plug>(manpager-open)
  xmap <buffer><nowait> <C-]>         <Plug>(manpager-open)
  xmap <buffer><nowait> <2-LeftMouse> <Plug>(manpager-open)
  nmap <buffer><nowait> <Tab>         <Plug>(manpager-open-next)
  nmap <buffer><nowait> <S-Tab>       <Plug>(manpager-open-previous)
  nmap <buffer><nowait> ]t            <Plug>(manpager-next-keyword)
  nmap <buffer><nowait> [t            <Plug>(manpager-previous-keyword)
  nmap <buffer><nowait> q             <Plug>(manpager-close)
endfunction
augroup ManPagerCustom
  autocmd!
  autocmd FileType man call s:manpager_mappings()
augroup END
" }}}
if !has('win32')
" {{{vim-dasht
  " Note:
  " To find available docsets: https://kapeli.com/dash#docsets
  " To install a docset: dasht-docsets-install <docset>
  " To find installed docsets: ls ~/.local/share/dasht/docsets
  " In the following dictionary, key is &filetype, value is docset name.
  let g:dasht_filetype_docsets = {}
  let g:dasht_filetype_docsets['c'] = ['C', 'GLib']
  let g:dasht_filetype_docsets['cpp'] = ['C\+\+', 'C', 'GLib', 'Qt_5', 'Qt_6']
  let g:dasht_filetype_docsets['python'] = ['Python_3', 'NumPy', 'SciPy']
  nnoremap <silent> <leader><space>dt :call Dasht(dasht#cursor_search_terms())<Return>
  vnoremap <silent> <leader><space>dt y:<C-U>call Dasht(getreg(0))<Return>
  let g:which_key_map["\<space>"]['d']['t'] = 'dasht (terminal)'
" }}}
endif
if has('nvim')
" {{{nabla.nvim
nnoremap <silent> <leader>aF :<C-u>lua require("nabla").popup()<CR>
let g:which_key_map['a']['F'] = 'preview formula'
" }}}
endif
" }}}
" {{{Unix-like OS specific
if !has('win32')
" {{{suda.vim
command! -nargs=1 E  edit  suda://<args>
command W w suda://%
" }}}
endif
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
