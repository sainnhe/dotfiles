" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .vim/features/full.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

" {{{Status line
" {{{lightline.vim
let g:lightline = {}
let g:lightline.separator = { 'left': "", 'right': "" }
let g:lightline.subseparator = { 'left': "", 'right': "" }
let g:lightline.tabline_separator = { 'left': "", 'right': "" }
let g:lightline.tabline_subseparator = { 'left': "", 'right': "" }
let g:lightline#asyncrun#indicator_none = ''
let g:lightline#asyncrun#indicator_run = 'Running...'
if g:vim_lightline_artify == 0
  " Coc Based:
  let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'linter_errors', 'linter_warnings', 'linter_info_and_hint', 'linter_ok'],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  " ALE Based:
  " let g:lightline.active = {
  "       \ 'left': [ [ 'mode', 'paste' ],
  "       \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
  "       \ 'right': [ [ 'lineinfo' ],
  "       \            [ 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'linter_unavailable', 'linter_checking'],
  "       \           [ 'asyncrun_status', 'coc_status' ] ]
  "       \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'git_global' ],
        \ [ 'git_buffer' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'tabnum', 'filename', 'modified' ],
        \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
else
  " Coc Based:
  let g:lightline.active = {
        \ 'left': [ [ 'artify_mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'artify_lineinfo' ],
        \            [ 'linter_errors', 'linter_warnings', 'linter_info_and_hint', 'linter_ok'],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  " ALE Based:
  " let g:lightline.active = {
  "       \ 'left': [ [ 'artify_mode', 'paste' ],
  "       \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
  "       \ 'right': [ [ 'artify_lineinfo' ],
  "       \            [ 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'linter_unavailable', 'linter_checking'],
  "       \           [ 'asyncrun_status', 'coc_status' ] ]
  "       \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'artify_lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'git_global' ],
        \ [ 'git_buffer' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'artify_activetabnum', 'artify_filename', 'modified' ],
        \ 'inactive': [ 'artify_inactivetabnum', 'filename', 'modified' ] }
endif
let g:lightline.tab_component_function = {
      \ 'artify_activetabnum': 'custom#lightline#artify_active_tabnum',
      \ 'artify_inactivetabnum': 'custom#lightline#artify_inactive_tabnum',
      \ 'artify_filename': 'custom#lightline#artify_tabname',
      \ 'tabnum': 'custom#lightline#tabnum',
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly'
      \ }
let g:lightline.component = {
      \ 'git_buffer' : '%{get(b:, "coc_git_status", "")}',
      \ 'git_global' : '%{custom#lightline#git_global()}',
      \ 'artify_mode': '%{custom#lightline#artify_mode()}',
      \ 'artify_lineinfo': "%2{custom#lightline#artify_line_percent()} %3{custom#lightline#artify_line_num()}:%-2{custom#lightline#artify_column_num()}",
      \ 'vim_logo': "",
      \ 'mode': '%{lightline#mode()}',
      \ 'filename': '%t',
      \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
      \ 'modified': '%M',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'lineinfo': '%2p%% %3l:%-2v'
      \ }
let g:lightline.component_function = {
      \ 'devicons_filetype': 'custom#lightline#devicons',
      \ 'coc_status': 'custom#lightline#coc_status'
      \ }
" Coc Based:
let g:lightline.component_expand = {
      \ 'linter_info_and_hint': 'custom#lightline#coc_diagnostic_info_and_hint',
      \ 'linter_warnings': 'custom#lightline#coc_diagnostic_warning',
      \ 'linter_errors': 'custom#lightline#coc_diagnostic_error',
      \ 'linter_ok': 'custom#lightline#coc_diagnostic_ok',
      \ 'asyncrun_status': 'lightline#asyncrun#status'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }

" ALE Based:
" let g:lightline.component_expand = {
"       \ 'linter_checking': 'lightline#ale#checking',
"       \ 'linter_infos': 'lightline#ale#infos',
"       \ 'linter_warnings': 'lightline#ale#warnings',
"       \ 'linter_errors': 'lightline#ale#errors',
"       \ 'linter_ok': 'lightline#ale#ok',
"       \ 'linter_unavailable': 'lightline#ale#unavailable',
"       \ 'asyncrun_status': 'lightline#asyncrun#status'
"       \ }
" let g:lightline.component_type = {
"       \ 'linter_warnings': 'warning',
"       \ 'linter_errors': 'error',
"       \ }
" let g:lightline#ale#indicator_checking = 'Linting...'
" let g:lightline#ale#indicator_infos = " "
" let g:lightline#ale#indicator_warnings = " "
" let g:lightline#ale#indicator_errors = " "
" let g:lightline#ale#indicator_ok = ""
" let g:lightline#ale#indicator_unavailable = ""
" }}}
" {{{tmuxline.vim
if g:vim_is_in_tmux == 1 && !has('win32')
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '%R',
        \'c'    : [ '#{sysstat_mem} #[fg=blue]#{sysstat_ntemp} #(~/.tmux/tmuxline/widget-color.sh)󰕒 #{upload_speed}' ],
        \'win'  : [ '#I', '#W' ],
        \'cwin' : [ '#I', '#W', '#F' ],
        \'x'    : [ "#(~/.tmux/tmuxline/widget-color.sh)#{download_speed} 󰇚 #[fg=blue]#{sysstat_itemp} #{sysstat_cpu}" ],
        \'y'    : [ '%a' ],
        \'z'    : '#H #{prefix_highlight}'
        \}
  let g:tmuxline_separators = {
        \ 'left' : "",
        \ 'left_alt': "",
        \ 'right' : "",
        \ 'right_alt' : "",
        \ 'space' : ' '}
endif
" }}}
" }}}
" {{{Additional UI components
" {{{vim-startify
if !exists('g:vim_pager')
  let g:startify_session_dir = custom#utils#get_path([custom#utils#stdpath('data'), 'sessions'])
  let g:startify_files_number = 5
  let g:startify_update_oldfiles = 1
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_dir = 1
  let g:startify_fortune_use_unicode = 1
  let g:startify_padding_left = 3
  let g:startify_session_remove_lines = ['setlocal', 'winheight']
  let g:startify_session_sort = 1
  let g:startify_custom_indices = ['1', '2', '3', '4', '5', '1', '2', '3', '4', '5']
  let g:startify_commands = [
        \ {'l': 'CocList'},
        \ {'u': 'Update'},
        \ ]
  " figlet -f slant <words>
  if has('nvim')
    let g:startify_custom_header = [
          \ '                                                                                    ',
          \ '     _____       _             __        _          _   __                _         ',
          \ '    / ___/____ _(_)___  ____  / /_  ___ ( )_____   / | / /__  ____ _   __(_)___ ___ ',
          \ '    \__ \/ __ `/ / __ \/ __ \/ __ \/ _ \|// ___/  /  |/ / _ \/ __ \ | / / / __ `__ \',
          \ '   ___/ / /_/ / / / / / / / / / / /  __/ (__  )  / /|  /  __/ /_/ / |/ / / / / / / /',
          \ '  /____/\__,_/_/_/ /_/_/ /_/_/ /_/\___/ /____/  /_/ |_/\___/\____/|___/_/_/ /_/ /_/ ',
          \ '                                                                                    ',
          \ ]
  else
    let g:startify_custom_header = [
          \ '                                                                     ',
          \ '     _____       _             __        _          _    ___         ',
          \ '    / ___/____ _(_)___  ____  / /_  ___ ( )_____   | |  / (_)___ ___ ',
          \ '    \__ \/ __ `/ / __ \/ __ \/ __ \/ _ \|// ___/   | | / / / __ `__ \',
          \ '   ___/ / /_/ / / / / / / / / / / /  __/ (__  )    | |/ / / / / / / /',
          \ '  /____/\__,_/_/_/ /_/_/ /_/_/ /_/\___/ /____/     |___/_/_/ /_/ /_/ ',
          \ '                                                                     ',
          \ ]
  endif
  let g:startify_lists = [
        \ { 'type': 'dir',       'header': ["   󰔟 MRU Files in ". getcwd()] },
        \ { 'type': 'files',     'header': ["   󱦟 MRU Files"]            },
        \ { 'type': 'bookmarks', 'header': ["    Bookmarks"]      },
        \ { 'type': 'sessions',  'header': ["    Sessions"]       },
        \ { 'type': 'commands',  'header': ["    Commands"]       },
        \ ]
  let g:startify_skiplist = [
        \ '/mnt/*',
        \ ]
  function! s:startify_mappings() abort
    nmap <silent><buffer> o <CR>
    nmap <silent><buffer> h :<C-u>wincmd h<CR>
    nmap <silent><buffer> q :<C-u>call custom#dashboard#close()<CR>
    nmap <silent><buffer> <Tab> :CocList project<CR>
  endfunction
  augroup StartifyCustom
    autocmd!
    autocmd User CocNvimInit if !argc() | call custom#dashboard#launch_startify() | endif
    autocmd FileType startify call s:startify_mappings()
    autocmd User Startified nmap <silent><buffer> <CR> <plug>(startify-open-buffers):call custom#dashboard#toggle_explorer()<CR>
  augroup END
endif
" }}}
" }}}
" {{{Language features
" {{{llama.vim
if $LLAMA_FIM_MODE ==# 'high'
  let s:llama_params_scale = 4
elseif $LLAMA_FIM_MODE ==# 'medium'
  let s:llama_params_scale = 2
else
  let s:llama_params_scale = 1
endif
let g:llama_config = {
    \ 'enable_at_startup':      $LLAMA_FIM_ENDPOINT !=# '',
    \ 'endpoint_fim':           $LLAMA_FIM_ENDPOINT,
		\ 'endpoint_inst':          $LLAMA_INST_ENDPOINT,
		\ 'api_key':                $LLAMA_INST_API_KEY,
		\ 'model_fim':              '',
		\ 'model_inst':             $LLAMA_INST_MODEL,
    \ 'show_info':              0,
    \ 'auto_fim':               v:true,
    \ 'keymap_fim_trigger':     "<Plug>(llama-trigger)",
    \ 'keymap_fim_accept_full': "<Plug>(llama-accept-all)",
    \ 'keymap_fim_accept_line': "<Plug>(llama-accept-line)",
    \ 'keymap_fim_accept_word': "<Plug>(llama-accept-word)",
    \ 'keymap_inst_trigger':    "?",
    \ 'keymap_inst_accept':     "<C-y>",
    \ 'keymap_inst_cancel':     "<Esc>",
		\ 'n_predict':              256,
		\ 'n_prefix':               256,
		\ 'n_suffix':               96,
		\ 'max_line_suffix':        8,
		\ 'max_cache_keys':         500 * s:llama_params_scale,
		\ 'ring_update_ms':         10000,
		\ 'ring_n_chunks':          8 * s:llama_params_scale,
		\ 'ring_chunk_size':        32,
		\ 'ring_scope':             2048 * s:llama_params_scale,
		\ 't_max_predict_ms':       3000,
		\ 't_max_prompt_ms':        2000,
    \ }
" ring 是一个循环队列，用于模仿短期记忆，队列中有 ring_n_chunks 个 chunk，每个 chunk 有 ring_chunk_size 行
" 当光标移动时，插件会在光标前后的 ring_scope 行内寻找值得记住的代码
" 当处于 normal 模式或者停止插入时，每过 ring_update_ms 毫秒，插件会将 ring 中的 chunks 送给 llama.cpp 进行处理。
" llama_params_scale == 1 时适用于 8k context
" 远程上下文 8 * 32=256 lines
" 眼前上文 256 lines
" 眼前下文 96 lines
" 总 token 数约 13 * (256+256+96) = 7904 刚好卡在 8k，不至于截断
" }}}
" {{{coc.nvim
" {{{coc-init
let g:coc_data_home = custom#utils#get_path([custom#utils#stdpath('data'), 'coc'])
let g:coc_filetype_map = {
      \ 'tex': 'latex',
      \ 'plaintex': 'latex',
      \ 'text': 'plaintext',
      \ 'help': 'plaintext',
      \ 'gitcommit': 'plaintext',
      \ }
let g:coc_global_extensions = [
      \ 'coc-angular',
      \ 'coc-basedpyright',
      \ 'coc-calc',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-css',
      \ 'coc-deno',
      \ 'coc-diagnostic',
      \ 'coc-dictionary',
      \ 'coc-docker',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-github-copilot',
      \ 'coc-gitignore',
      \ 'coc-go',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-htmlhint',
      \ 'coc-imselect',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-lua',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-markdownlint',
      \ 'coc-marketplace',
      \ 'coc-prettier',
      \ 'coc-project',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-svg',
      \ 'coc-syntax',
      \ 'coc-tag',
      \ 'coc-terminal',
      \ 'coc-texlab',
      \ 'coc-todo-tree',
      \ 'coc-toml',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-webview',
      \ 'coc-word',
      \ 'coc-xml',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ '@yaegassy/coc-marksman',
      \ '@yaegassy/coc-nginx',
      \ '@yaegassy/coc-pyrefly',
      \ '@yaegassy/coc-ruff',
      \ '@yaegassy/coc-ty',
      \ '@yaegassy/coc-zuban',
      \ ]
" }}}
" {{{coc-settings
augroup CocCustom
  autocmd!
  autocmd CursorHold * silent if &filetype !=# 'markdown' | call CocActionAsync('highlight') | endif
  autocmd User CocGitStatusChange CocCommand git.refresh
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocGitStatusChange,CocStatusChange,CocDiagnosticChange call lightline#update()
  autocmd QuitPre * CocCommand terminal.Destroy
augroup END
call coc#config('workspace', {
      \ 'rootPatterns': g:root_patterns
      \ })
call coc#config('languageserver', {
      \ 'sql': {
        \ 'command': "sqls",
        \ 'filetypes': ['sql'],
        \ 'args': ['-config', custom#utils#get_path([custom#utils#stdpath('config'), 'resources', 'sqls.yml'])]
        \ }
      \ })
call coc#config('java', {
      \ 'jdt': {
        \ 'ls': {
          \ 'java': {
            \ 'home': g:java_home
            \ }
          \ }
        \ },
      \ 'configuration': {
        \ 'runtimes': [{
          \ 'name': 'JavaSE-21',
          \ 'default': v:true,
          \ 'path': g:java_home
        \ }]
      \ },
      \ 'format': {
        \ 'settings': {
          \ 'url': custom#utils#get_path([custom#utils#stdpath('config'), 'resources', 'eclipse-java-google-style.xml']),
          \ 'profile': 'GoogleStyle'
          \ }
        \ }
      \ })
call coc#config('xml', {
      \ 'java': {
        \ 'home': g:java_home
        \ }
      \ })
call coc#config('project', {
      \ 'dbpath': custom#utils#get_path([custom#utils#stdpath('data'), 'coc', 'project.json']),
      \ 'rootPatterns': g:root_patterns
      \ })
if has('win32')
  call coc#config('terminal', {
        \ 'shellPath': 'powershell',
        \ 'shellArgs': ['-nologo'],
        \ })
endif
" }}}
" {{{coc-mappings
" Select
inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#next(1) : "\<tab>"
inoremap <silent><expr> <S-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-tab>"
" Accept inline
function! s:accept_inline(kind)
  if coc#pum#has_item_selected()
    return coc#pum#confirm()
  endif
  if coc#inline#visible()
    call coc#inline#accept(a:kind)
  elseif g:llama_config.enable_at_startup
    call feedkeys("\<Plug>(llama-accept-" . a:kind . ")", 'm')
  endif
  return ""
endfunction
inoremap <silent><expr> <C-y> <sid>accept_inline("all")
inoremap <silent><expr> <C-l> <sid>accept_inline("line")
inoremap <silent><expr> <C-o> <sid>accept_inline("word")
" Cancel
function! s:cancel()
  if coc#pum#visible()
    call coc#pum#close('cancel')
  endif
  if coc#inline#visible()
    call coc#inline#cancel()
  endif
  return ''
endfunction
inoremap <silent><expr> <C-e> <sid>cancel()
" Snippet
inoremap <silent><expr> <C-j> coc#jumpable() ?
      \ "\<C-R>=coc#rpc#request('snippetNext', [])\<cr>" :
      \ coc#inline#next()
inoremap <silent><expr> <C-k> coc#jumpable() ?
      \ "\<C-R>=coc#rpc#request('snippetPrev', [])\<cr>" :
      \ coc#inline#prev()
" Navigation
" Create placeholder mappings for <up> and <down> to avoid coc adding mappings
" for them.
inoremap <silent><expr> <up> coc#pum#visible() ? "\<up>" : "\<up>"
inoremap <silent><expr> <down> coc#pum#visible() ? "\<down>" : "\<down>"
" Floating window
nnoremap <silent><expr> <A-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-d>"
nnoremap <silent><expr> <A-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-u>"
inoremap <silent><expr> <A-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<A-d>"
inoremap <silent><expr> <A-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<A-u>"
function! s:do_hover()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('definitionHover')
  else
    call feedkeys('?', 'in')
  endif
endfunction
nnoremap <silent> ? :call <sid>do_hover()<CR>
" Outline
nnoremap <silent><nowait> <A-b> :<C-u>call custom#dashboard#toggle_outline()<CR>
" Terminal
nnoremap <silent> <A-=> :<C-u>CocCommand terminal.Toggle<CR>
tnoremap <silent> <A-=> <C-\><C-n>:<C-u>CocCommand terminal.Toggle<CR>
nnoremap <silent> <A--> :<C-u>CocCommand terminal.REPL<CR>
tnoremap <silent> <A--> <C-\><C-n>:<C-u>CocCommand terminal.Toggle<CR>
" List
nmap <silent> <leader>f<Space> :<C-u>CocList<CR>
nmap <silent> <leader>fb :<C-u>CocList buffers<CR>
nmap <silent> <leader>fc :<C-u>CocList vimcommands<CR>
nmap <silent> <leader>fC :<C-u>CocList commands<CR>
nmap <silent> <leader>fd :<C-u>CocList diagnostics<CR>
nmap <silent> <leader>fe :<C-u>CocList extensions<CR>
nmap <silent> <leader>ff :<C-u>CocList files<CR>
nmap <silent> <leader>fg :<C-u>CocList grep<CR>
nmap <silent> <leader>fh :<C-u>CocList helptags<CR>
nmap <silent> <leader>fl :<C-u>CocList --interactive --ignore-case lines<CR>
nmap <silent> <leader>fm :<C-u>CocList mru<CR>
nmap <silent> <leader>fM :<C-u>CocList marketplace<CR>
nmap <silent> <leader>fo :<C-u>CocList outline<CR>
nmap <silent> <leader>fr :<C-u>CocList registers<CR>
nmap <silent> <leader>fs :<C-u>CocList symbols<CR>
nmap <silent> <leader>fw :<C-u>CocList windows<CR>
nmap <silent> <leader>fy :<C-u>CocList yank<CR>
let g:which_key_map['f'] = {
      \ 'name': 'fuzzy finder',
      \ "\<Space>": 'list',
      \ 'b': 'buffers',
      \ 'c': 'vim commands',
      \ 'C': 'coc commands',
      \ 'd': 'diagnostics',
      \ 'e': 'extensions',
      \ 'f': 'files',
      \ 'g': 'grep',
      \ 'h': 'help',
      \ 'l': 'lines',
      \ 'm': 'mru files',
      \ 'M': 'marketplace',
      \ 'o': 'outline',
      \ 'r': 'registers',
      \ 's': 'symbols',
      \ 'w': 'windows',
      \ 'y': 'yank',
      \ }
" Jump
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>jD <Plug>(coc-declaration)
nmap <silent> <leader>jt <Plug>(coc-type-definition)
nmap <silent> <leader>jr <Plug>(coc-references-used)
nmap <silent> <leader>jR <Plug>(coc-references)
nmap <silent> <leader>jm <Plug>(coc-implementation)
nmap <silent> <leader>js :<C-u>CocCommand document.jumpToNextSymbol<CR>
nmap <silent> <leader>jS :<C-u>CocCommand document.jumpToPrevSymbol<CR>
if !exists("g:which_key_map['j']")
  let g:which_key_map['j'] = { 'name': 'jump'}
endif
let g:which_key_map['j']['d'] = 'definition'
let g:which_key_map['j']['D'] = 'declaration'
let g:which_key_map['j']['t'] = 'type definition'
let g:which_key_map['j']['r'] = 'reference used'
let g:which_key_map['j']['R'] = 'reference all'
let g:which_key_map['j']['m'] = 'implementation'
let g:which_key_map['j']['s'] = 'next symbol'
let g:which_key_map['j']['S'] = 'prev symbol'
" Diagnostics
nmap <silent> <leader>jl <Plug>(coc-diagnostic-next)
nmap <silent> <leader>jL <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>je <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>jE <Plug>(coc-diagnostic-prev-error)
let g:which_key_map['j']['l'] = 'next linting'
let g:which_key_map['j']['L'] = 'prev linting'
let g:which_key_map['j']['e'] = 'next error'
let g:which_key_map['j']['E'] = 'prev error'
" Action
nmap <silent> <leader>afc <Plug>(coc-fix-current)
nmap <silent> <leader>afa :<C-u>call CocActionAsync('fixAll')<CR>
nmap <silent> <leader>ai :<C-u>call CocActionAsync('organizeImport')<CR>
nmap <silent> <leader>ar <Plug>(coc-rename)
nmap <silent> <leader>aR <Plug>(coc-refactor)
nmap <silent> <leader>ao <Plug>(coc-openlink)
nmap <silent> <leader>al <Plug>(coc-codelens-action)
nmap <silent> <leader>acb <Plug>(coc-codeaction)
nmap <silent> <leader>acl <Plug>(coc-codeaction-line)
nmap <silent> <leader>acc <Plug>(coc-codeaction-cursor)
vmap <silent> <leader>ac <Plug>(coc-codeaction-selected)
nmap <silent> <leader>aCp :<C-u>CocCommand editor.action.pickColor<CR>
nmap <silent> <leader>aCP :<C-u>CocCommand editor.action.colorPresentation<CR>
nmap <silent> <leader>ahc :<C-u>call CocAction('showOutgoingCalls')<CR>
nmap <silent> <leader>aHc :<C-u>call CocAction('showIncomingCalls')<CR>
nmap <silent> <leader>aht :<C-u>call CocAction('showSubTypes')<CR>
nmap <silent> <leader>aHt :<C-u>call CocAction('showSuperTypes')<CR>
nmap <silent> <leader>amp :<C-u>CocCommand markdown-preview-enhanced.openPreview<cr>
nmap <silent> <leader>ami :<C-u>CocCommand markdown-preview-enhanced.openImageHelper<cr>
nmap <silent> <leader>amI :<C-u>CocCommand markdown-preview-enhanced.showUploadedImages<cr>
nmap <silent> <leader>amr :<C-u>CocCommand markdown-preview-enhanced.runCodeChunk<cr>
nmap <silent> <leader>amR :<C-u>CocCommand markdown-preview-enhanced.runAllCodeChunks<cr>
if !exists("g:which_key_map['a']")
  let g:which_key_map['a'] = { 'name': 'action'}
endif
let g:which_key_map['a']['f'] = {
      \ 'name': 'fix',
      \ 'c': 'current cursor',
      \ 'a': 'all buffer',
      \ }
let g:which_key_map['a']['i'] = 'organize import'
let g:which_key_map['a']['r'] = 'rename'
let g:which_key_map['a']['R'] = 'refactor'
let g:which_key_map['a']['o'] = 'open link'
let g:which_key_map['a']['l'] = 'codeLens'
let g:which_key_map['a']['c'] = {
      \ 'name': 'code action',
      \ 'b': 'current buffer',
      \ 'l': 'current line',
      \ 'c': 'current cursor',
      \ }
let g:which_key_map['a']['C'] = {
      \ 'name': 'color',
      \ 'p': 'pick',
      \ 'P': 'presentation',
      \ }
let g:which_key_map['a']['h'] = {
      \ 'name': 'hierarchy sub',
      \ 'c': 'call',
      \ 't': 'type',
      \ }
let g:which_key_map['a']['H'] = {
      \ 'name': 'hierarchy super',
      \ 'c': 'call',
      \ 't': 'type',
      \ }
let g:which_key_map['a']['m'] = {
      \ 'name': 'markdown',
      \ 'p': 'preview',
      \ 'i': 'image helper',
      \ 'I': 'image uploaded',
      \ 'r': 'run code chunk',
      \ 'R': 'run all code chunks',
      \ }
" Fold
nmap <silent> zM :<C-u>call custom#utils#coc_fold()<CR>
" Format
nmap <silent> <leader><Tab> <Plug>(coc-format)
vmap <silent> <leader><Tab> <Plug>(coc-format-selected)
let g:which_key_map['<Tab>'] = 'format'
" Git
nmap <silent> <leader>jg <Plug>(coc-git-nextchunk)
nmap <silent> <leader>jG <Plug>(coc-git-prevchunk)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nmap <silent> <leader>gD :CocCommand git.diffCached<CR>
nmap <silent> <leader>gi <Plug>(coc-git-chunkinfo)
nmap <silent> <leader>gu :<C-u>CocCommand git.chunkUndo<CR>
nmap <silent> <leader>ga :<C-u>CocCommand git.chunkStage<CR>
nmap <silent> <leader>gs :<C-u>CocList gstatus<cr>
nmap <silent> <leader>gf :<C-u>CocCommand git.foldUnchanged<CR>
nmap <silent> <leader>go :<C-u>CocCommand git.browserOpen<CR>
nmap <silent> <leader>gla :<C-u>CocList commits<cr>
nmap <silent> <leader>glc :<C-u>CocList bcommits<cr>
nmap <silent> <leader>gll <Plug>(coc-git-commit)
let g:which_key_map['j']['g'] = 'next git chunk'
let g:which_key_map['j']['G'] = 'prev git chunk'
let g:which_key_map['g'] = {
      \   'name': 'git',
      \   'D': 'diff staged',
      \   'i': 'chunk info',
      \   'u': 'chunk undo',
      \   'a': 'chunk stage',
      \   's': 'status',
      \   'f': 'toggle fold unchanged',
      \   'o': 'open remote url in the browser',
      \   'l': {'name': 'logs', 'a': 'log (all)', 'c': 'log (cur buf)', 'l': 'log (cur line)'},
      \   }
" Text objects
if !has('nvim')
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
endif
xmap io <Plug>(coc-classobj-i)
omap io <Plug>(coc-classobj-i)
xmap ao <Plug>(coc-classobj-a)
omap ao <Plug>(coc-classobj-a)
" }}}
" {{{coc-explorer
nnoremap <silent> <C-b> :<C-u>execute 'CocCommand explorer --focus ' . getcwd()<CR>
augroup ExplorerCustom
  autocmd!
  autocmd FileType coc-explorer setlocal signcolumn=no
  autocmd FileType coc-explorer nnoremap <buffer><silent> q :<C-u>call custom#dashboard#close()<CR>
  autocmd BufEnter * if stridx(@%, 'term:') != -1 | setlocal nocursorline | endif
augroup END
" }}}
" {{{coc-project
nnoremap <silent> <leader>fp :<c-u>CocList project<cr>
let g:which_key_map['f']['p'] = 'projects'
" }}}
" {{{coc-todo-tree
nnoremap <silent> <leader><space>T :<c-u>CocCommand coc-todo-tree.showTree<cr>
let g:which_key_map["\<space>"]['T'] = 'todo'
" }}}
" }}}
" {{{vim-doge
let g:doge_enable_mappings = 0
let g:doge_mapping_comment_jump_forward = '<C-j>'
let g:doge_mapping_comment_jump_backward = '<C-k>'
let g:doge_doc_standard_python = 'google'
nnoremap <silent> <leader>ad :<C-u>DogeGenerate<CR>
let g:which_key_map['a']['d'] = 'generate docstring'
" }}}
" {{{any-jump.vim
let g:any_jump_disable_default_keybindings = 1
nnoremap <silent> <leader>jj :<C-u>AnyJump<CR>
xnoremap <silent> <leader>jj :AnyJumpVisual<CR>
let g:which_key_map['j']['j'] = 'any jump'
" }}}
" }}}
" {{{Fuzzy Search
if has('python3')
  nmap <silent> <leader>fl :<C-u>Leaderf line<CR>
  let g:Lf_WindowPosition = 'bottom'
  let g:Lf_WindowHeight = 0.38
  let g:Lf_CacheDirectory = custom#utils#get_path([custom#utils#stdpath('cache'), 'leaderf'])
  let g:Lf_StlSeparator = { 'left': '', 'right': '' }
  let g:Lf_RootMarkers = g:root_patterns
  let g:Lf_PreviewInPopup = 1
  let g:Lf_ShortcutF = ''
  let g:Lf_ShortcutB = ''
endif
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
