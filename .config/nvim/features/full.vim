" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/features/full.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 && MIT
" =============================================================================

" {{{Status line
" {{{lightline.vim
let g:lightline = {}
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let g:lightline#asyncrun#indicator_none = ''
let g:lightline#asyncrun#indicator_run = 'Running...'
if g:vim_lightline_artify == 0
  let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
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
  let g:lightline.active = {
        \ 'left': [ [ 'artify_mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'artify_lineinfo' ],
        \            [ 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
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
      \ 'artify_lineinfo': "%2{custom#lightline#artify_line_percent()}\uf295 %3{custom#lightline#artify_line_num()}:%-2{custom#lightline#artify_column_num()}",
      \ 'vim_logo': "\ue7c5",
      \ 'pomodoro': '%{custom#lightline#pomodoro()}',
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
let g:lightline.component_expand = {
      \ 'linter_warnings': 'custom#lightline#coc_diagnostic_warning',
      \ 'linter_errors': 'custom#lightline#coc_diagnostic_error',
      \ 'linter_ok': 'custom#lightline#coc_diagnostic_ok',
      \ 'asyncrun_status': 'lightline#asyncrun#status'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
" }}}
" {{{tmuxline.vim
if g:vim_is_in_tmux == 1 && !has('win32')
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '%R',
        \'c'    : [ '#{sysstat_mem} #[fg=blue]#{sysstat_ntemp} #(~/.tmux/tmuxline/widget-color.sh)\ufa51#{upload_speed}' ],
        \'win'  : [ '#I', '#W' ],
        \'cwin' : [ '#I', '#W', '#F' ],
        \'x'    : [ "#(~/.tmux/tmuxline/widget-color.sh)#{download_speed} \uf6d9 #[fg=blue]#{sysstat_itemp} #{sysstat_cpu}" ],
        \'y'    : [ '%a' ],
        \'z'    : '#H #{prefix_highlight}'
        \}
  let g:tmuxline_separators = {
        \ 'left' : "\ue0bc",
        \ 'left_alt': "\ue0bd",
        \ 'right' : "\ue0ba",
        \ 'right_alt' : "\ue0bd",
        \ 'space' : ' '}
endif
" }}}
" }}}
" {{{Additional UI components
" {{{vim-startify
if g:vim_enable_startify == 1
  let g:startify_session_dir = fnamemodify(stdpath('data'), ':p') . 'sessions'
  let g:startify_files_number = 5
  let g:startify_update_oldfiles = 1
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_dir = 1
  let g:startify_fortune_use_unicode = 1
  let g:startify_padding_left = 3
  let g:startify_session_remove_lines = ['setlocal', 'winheight']
  let g:startify_session_sort = 1
  let g:startify_custom_indices = ['1', '2', '3', '4', '5', '1', '2', '3', '4', '5']
  if has('nvim')
    let g:startify_commands = [
          \ {'1': 'CocList'},
          \ {'2': 'terminal'},
          \ ]
  endif
  let g:startify_custom_header = [
        \ '                                                                                    ',
        \ '     _____       _             __        _          _   __                _         ',
        \ '    / ___/____ _(_)___  ____  / /_  ___ ( )_____   / | / /__  ____ _   __(_)___ ___ ',
        \ '    \__ \/ __ `/ / __ \/ __ \/ __ \/ _ \|// ___/  /  |/ / _ \/ __ \ | / / / __ `__ \',
        \ '   ___/ / /_/ / / / / / / / / / / /  __/ (__  )  / /|  /  __/ /_/ / |/ / / / / / / /',
        \ '  /____/\__,_/_/_/ /_/_/ /_/_/ /_/\___/ /____/  /_/ |_/\___/\____/|___/_/_/ /_/ /_/ ',
        \ '                                                                                    ',
        \ ]
  let g:startify_lists = [
        \ { 'type': 'sessions',  'header': [" \ue62e Sessions"]       },
        \ { 'type': 'bookmarks', 'header': [" \uf5c2 Bookmarks"]      },
        \ { 'type': 'files',     'header': [" \ufa1eMRU Files"]            },
        \ { 'type': 'dir',       'header': [" \ufa1eMRU Files in ". getcwd()] },
        \ { 'type': 'commands',  'header': [" \ufb32 Commands"]       },
        \ ]
  let g:startify_skiplist = [
        \ '/mnt/*',
        \ ]
  function! s:startify_mappings() abort
    nmap <silent><buffer> o <CR>
    nmap <silent><buffer> h :wincmd h<CR>
    nmap <silent><buffer> <Tab> :CocList project<CR>
  endfunction
  augroup StartifyCustom
    autocmd!
    autocmd User CocNvimInit if !argc() | call custom#explorer#startify() | endif
    autocmd FileType startify call s:startify_mappings()
    autocmd User Startified nmap <silent><buffer> <CR> <plug>(startify-open-buffers):call custom#explorer#toggle()<CR>
  augroup END
endif
" }}}
" {{{indent-blankline.nvim
let g:indent_blankline_char = ''  " ¦┆│⎸▏
let g:indent_blankline_use_treesitter = 1
let g:indent_blankline_filetype_exclude = ['startify', 'coc-explorer', 'codi', 'help', 'man', 'vtm', 'markdown']
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_show_current_context = 1
set colorcolumn=9999 " Fix for cursorline
" }}}
" }}}
" {{{Language features
" {{{coc.nvim
" {{{coc-init
let g:coc_data_home = fnamemodify(stdpath('data'), ':p') . 'coc'
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-dictionary',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-gitignore',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-htmlhint',
      \ 'coc-imselect',
      \ 'coc-json',
      \ 'coc-julia',
      \ 'coc-lists',
      \ 'coc-lua',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-markdownlint',
      \ 'coc-marketplace',
      \ 'coc-prettier',
      \ 'coc-project',
      \ 'coc-pyright',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-sql',
      \ 'coc-syntax',
      \ 'coc-tag',
      \ 'coc-terminal',
      \ 'coc-texlab',
      \ 'coc-toml',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-webview',
      \ 'coc-xml',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ ]
" }}}
" {{{coc-settings
augroup CocCustom
  autocmd!
  autocmd CursorHold * silent if g:coc_hover_enable == 1 && !coc#float#has_float() | call CocActionAsync('doHover') | endif
  autocmd CursorHold * silent if &filetype !=# 'markdown' | call CocActionAsync('highlight') | endif
  autocmd User CocGitStatusChange CocCommand git.refresh
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocGitStatusChange,CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END
let g:coc_hover_enable = 0
call coc#config('project', {
      \ 'dbpath': fnamemodify(g:coc_data_home, ':p') . 'project.json',
      \ })
call coc#config('snippets', {
      \ 'userSnippetsDirectory': fnamemodify(stdpath('data'), ':p') . 'snippets',
      \ })
call coc#config('xml', {
      \ 'java': {
      \   'home': has('win32') ? 'C:\Users\gaoti\scoop\apps\openjdk\current' :
        \ has('macunix') ? '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home' :
        \ '/usr/lib/jvm/default'
      \ }
      \ })
if has('win32')
  call coc#config('terminal', {
        \ 'shellPath': 'powershell',
        \ })
endif
" }}}
" {{{coc-mappings
inoremap <silent><expr> <C-j>
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetNext', [])\<cr>" :
      \ pumvisible() ? coc#_select_confirm() :
      \ "\<Down>"
inoremap <silent><expr> <C-k>
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetPrev', [])\<cr>" :
      \ "\<Up>"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" :
      \ custom#utils#check_back_space() ? "\<S-TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <CR> pumvisible() ? "\<Space>\<Backspace>\<CR>" : "\<CR>"
inoremap <silent><expr> <up> pumvisible() ? "\<Space>\<Backspace>\<up>" : "\<up>"
inoremap <silent><expr> <down> pumvisible() ? "\<Space>\<Backspace>\<down>" : "\<down>"
inoremap <silent><expr> <left> pumvisible() ? "\<Space>\<Backspace>\<left>" : "\<left>"
inoremap <silent><expr> <right> pumvisible() ? "\<Space>\<Backspace>\<right>" : "\<right>"
nnoremap <silent><expr> <A-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-d>"
nnoremap <silent><expr> <A-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-u>"
inoremap <silent><expr> <A-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<A-d>"
inoremap <silent><expr> <A-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<A-u>"
nnoremap <silent> <A-=> :<C-u>CocCommand terminal.Toggle<CR>
tnoremap <silent> <A-=> <C-\><C-n>:<C-u>CocCommand terminal.Toggle<CR>
nnoremap <silent> <A--> :<C-u>CocCommand terminal.REPL<CR>
tnoremap <silent> <A--> <C-\><C-n>:<C-u>CocCommand terminal.Toggle<CR>
nmap <silent> <leader>f<Space> :<C-u>CocList<CR>
nmap <silent> <leader>fy :<C-u>CocList yank<CR>
nmap <silent> <leader>fs :<C-u>CocList symbols<CR>
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>jD <Plug>(coc-declaration)
nmap <silent> <leader>jt <Plug>(coc-type-definition)
nmap <silent> <leader>jr <Plug>(coc-references-used)
nmap <silent> <leader>jm <Plug>(coc-implementation)
nmap <silent> <leader><space>r <Plug>(coc-rename)
nmap <silent> <leader><space>R <Plug>(coc-refactor)
nmap <silent> <leader><space>ca <Plug>(coc-codeaction)
nmap <silent> <leader><space>cl <Plug>(coc-codeaction-line)
nmap <silent> <leader><space>cc <Plug>(coc-codeaction-cursor)
vmap <silent> <leader><space>c <Plug>(coc-codeaction-selected)
nmap <silent> <leader><space>o <Plug>(coc-openlink)
nmap <silent> <leader><space>l <Plug>(coc-codelens-action)
nmap <silent> <leader><space>so :<C-u>CocCommand snippets.openSnippetFiles<cr>
nmap <silent> <leader><space>se :<C-u>CocCommand snippets.editSnippets<cr>
nmap <silent> <leader><space>mf :<C-u>CocCommand prettier.formatFile<cr>
nmap <silent> <leader><space>mp :<C-u>CocCommand markdown-preview-enhanced.openPreview<cr>
nmap <silent> <leader><space>mi :<C-u>CocCommand markdown-preview-enhanced.openImageHelper<cr>
nmap <silent> <leader><space>mI :<C-u>CocCommand markdown-preview-enhanced.showUploadedImages<cr>
nmap <silent> <leader><space>mr :<C-u>CocCommand markdown-preview-enhanced.runCodeChunk<cr>
nmap <silent> <leader><space>mR :<C-u>CocCommand markdown-preview-enhanced.runAllCodeChunks<cr>
nmap <silent> <leader><Tab> <Plug>(coc-format)
vmap <silent> <leader><Tab> <Plug>(coc-format-selected)
nmap <silent> <leader>gj <Plug>(coc-git-nextchunk)
nmap <silent> <leader>gk <Plug>(coc-git-prevchunk)
nmap <silent> <leader>gi <Plug>(coc-git-chunkinfo)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nmap <silent> <leader>gD :CocCommand git.diffCached<CR>
nmap <silent> <leader>gu :<C-u>CocCommand git.chunkUndo<CR>
nmap <silent> <leader>ga :<C-u>CocCommand git.chunkStage<CR>
nmap <silent> <leader>gF :<C-u>CocCommand git.foldUnchanged<CR>
nmap <silent> <leader>go :<C-u>CocCommand git.browserOpen<CR>
nmap <silent> <leader>gs :<C-u>CocList gstatus<cr>
nmap <silent> <leader>gla :<C-u>CocList commits<cr>
nmap <silent> <leader>glc :<C-u>CocList bcommits<cr>
nmap <silent> <leader>gll <Plug>(coc-git-commit)
nmap <silent> <leader>dj <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dk <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>df <Plug>(coc-fix-current)
nmap <silent> <leader>dd :<C-u>CocDiagnostics<cr>
nmap <silent> <leader>d<space> :<C-u>CocList diagnostics<cr>
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
let g:which_key_map['j'] = {
      \   'name': 'jump',
      \   'd': 'definition',
      \   'D': 'declaration',
      \   't': 'type definition',
      \   'r': 'reference',
      \   'm': 'implementation',
      \   }
let g:which_key_map['<Tab>'] = 'format'
let g:which_key_map["\<space>"]['r'] = 'rename'
let g:which_key_map["\<space>"]['R'] = 'refactor'
let g:which_key_map["\<space>"]['o'] = 'open link'
let g:which_key_map["\<space>"]['l'] = 'codeLens action'
let g:which_key_map["\<space>"]['c'] = {
      \ 'name': 'code action',
      \ 'a': 'full buffer',
      \ 'l': 'current line',
      \ 'c': 'current cursor',
      \ }
let g:which_key_map["\<space>"]['m'] = {
      \ 'name': 'markdown',
      \ 'f': 'format',
      \ 'p': 'preview',
      \ 'i': 'image helper',
      \ 'I': 'image uploaded',
      \ 'r': 'run code chunk',
      \ 'R': 'run all code chunks',
      \ }
let g:which_key_map["\<space>"]['s'] = {
        \ 'name': 'snippets',
        \ 'e': 'edit snippets for current file type',
        \ 'o': 'open snippet file',
      \ }
let g:which_key_map['g'] = {
      \   'name': 'git',
      \   'j': 'chunk next',
      \   'k': 'chunk prev',
      \   'D': 'diff staged',
      \   'i': 'chunk info',
      \   'u': 'chunk undo',
      \   'a': 'chunk stage',
      \   's': 'status',
      \   'l': {'name': 'logs', 'a': 'log (all)', 'c': 'log (cur buf)', 'l': 'log (cur line)'},
      \   'F': 'toggle fold unchanged',
      \   'o': 'open remote url in the browser',
      \   }
let g:which_key_map['f'] = {
      \   'name': 'fuzzy finder',
      \   "\<Space>": 'list',
      \   's': 'symbols',
      \   'y': 'yank',
      \   }
let g:which_key_map['d'] = {
      \   'name': 'diagnostics',
      \   "\<Space>": 'list (global)',
      \   'd': 'list (current)',
      \   'f': 'fix',
      \   'j': 'next',
      \   'k': 'prev',
      \   }
nnoremap <silent> ? :let g:coc_hover_enable = (g:coc_hover_enable == 1 ? 0 : 1)<CR>
" }}}
" {{{coc-explorer
nnoremap <silent> <C-b> :call custom#explorer#toggle()<CR>
augroup ExplorerCustom
  autocmd!
  autocmd FileType coc-explorer setlocal signcolumn=no
  autocmd FileType coc-explorer nnoremap <buffer><silent> q :<C-u>call custom#explorer#close_startify()<CR>
  autocmd BufEnter * call custom#explorer#close_last()
  autocmd BufEnter * if stridx(@%, 'term:') != -1 | setlocal nocursorline | endif
augroup END
" }}}
" {{{coc-project
nnoremap <silent> <leader>fp :<c-u>CocList project<cr>
let g:which_key_map['f']['p'] = 'projects'
" }}}
" {{{coc-gitignore
nnoremap <silent> <leader><space>g :<c-u>CocList gitignore<cr>
let g:which_key_map["\<space>"]['g'] = 'gitignore'
" }}}
" }}}
" {{{copilot.vim
let g:copilot_no_tab_map = 1
imap <silent><script><expr> <A-z> copilot#Accept("\<CR>")
" }}}
" {{{vista.vim
nnoremap <silent> <A-b> :<C-u>Vista!!<CR>
let g:vista_sidebar_width = 35
let g:vista_cursor_delay = 100
let g:vista_keep_fzf_colors = 1
let g:vista_fzf_opt = ['--layout=default', '--prompt=❯ ']
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
      \ 'markdown': 'toc',
      \ 'javascript': 'coc',
      \ 'javascriptreact': 'coc',
      \ 'typescript': 'coc',
      \ 'typescriptreact': 'coc',
      \ 'python': 'coc',
      \ 'rust': 'coc',
      \ }
augroup VistaCustom
  autocmd!
  autocmd FileType vista,vista_kind nmap <buffer><silent> o <CR>
augroup END
" }}}
" {{{vimspector
" https://puremourning.github.io/vimspector/configuration.html
" .vimspector.json: docs/schema/vimspector.schema.json
" .gadgets.json: docs/schema/gadgets.schema.json
let g:vimspector_install_gadgets = ['debugpy', 'CodeLLDB', 'vscode-bash-debug', 'vscode-node-debug2', 'debugger-for-chrome']
nmap <silent> <leader>bc :<C-u>call vimspector#Continue()<CR>
nmap <silent> <leader>bs :<C-u>call vimspector#Stop()<CR>
nmap <silent> <leader>br :<C-u>call vimspector#Restart()<CR>
nmap <silent> <leader>bp :<C-u>call vimspector#Pause()<CR>
nmap <silent> <leader>be <Plug>VimspectorBalloonEval
nmap <silent> <leader>bg <Plug>VimspectorRunToCursor
nmap <silent> <leader>bbb <Plug>VimspectorToggleBreakpoint
nmap <silent> <leader>bbc <Plug>VimspectorToggleConditionalBreakpoint
nmap <silent> <leader>bbf <Plug>VimspectorAddFunctionBreakpoint
nmap <silent> <leader>bbC :<C-u>call vimspector#ClearBreakpoints()<CR>
nmap <silent> <leader>b<Space><Space> <Plug>VimspectorStepOver
nmap <silent> <leader>b<Space>i <Plug>VimspectorStepInto
nmap <silent> <leader>b<Space>o <Plug>VimspectorStepOut
nmap <silent> <leader>bfk <Plug>VimspectorUpFrame
nmap <silent> <leader>bfj <Plug>VimspectorDownFrame
let g:which_key_map['b'] = {
      \ 'name': 'debug',
      \ 'c': 'continue',
      \ 's': 'stop',
      \ 'r': 'restart',
      \ 'p': 'pause',
      \ 'e': 'eval',
      \ 'g': 'run to cursor',
      \ 'b': {
        \ 'name': 'breakpoint',
        \ 'b': 'toggle',
        \ 'c': 'conditional',
        \ 'f': 'function',
        \ 'C': 'clear all',
      \ },
      \ "\<Space>": {
        \ 'name': 'step',
        \ "\<Space>": 'over',
        \ 'i': 'in',
        \ 'o': 'out',
      \ },
      \ 'f': {
        \ 'name': 'frame',
        \ 'k': 'up',
        \ 'j': 'down',
        \ },
      \ }
" }}}
" {{{zealvim.vim
let g:zv_disable_mapping = 1
let g:zv_zeal_executable = 'zeal'
let g:zv_file_types = {
      \ 'help'                : 'vim',
      \ 'javascript'          : 'javascript,nodejs',
      \ 'python'              : 'python_3',
      \ '\v^(G|g)ulpfile\.js' : 'gulp,javascript,nodejs',
      \ }
nmap <leader><space>zz <Plug>Zeavim
vmap <leader><space>z <Plug>ZVVisSelection
nmap <leader><space>z<space> <Plug>ZVKeyDocset
nmap <leader><space>za <Plug>ZVOperator
let g:which_key_map["\<space>"]['z'] = {
      \   'name': 'zeal',
      \   "\<Space>": 'docset',
      \   'z': 'current location',
      \   'a': 'text object',
      \   }
" }}}
" {{{vim-doge
let g:doge_enable_mappings = 0
let g:doge_mapping_comment_jump_forward = '<C-j>'
let g:doge_mapping_comment_jump_backward = '<C-k>'
let g:doge_doc_standard_python = 'google'
nnoremap <silent> <leader><space>d :<C-u>DogeGenerate<CR>
let g:which_key_map["\<space>"]['d'] = 'generate code doc'
" }}}
" }}}
" {{{Tree-sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "vim" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<2-LeftMouse>"
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      }
    }
  }
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" }}}
" {{{Extended functional components, but with extra dependencies
" {{{LeaderF
let g:Lf_ShortcutF = '<A-c>`````ff'
let g:Lf_ShortcutB = '<A-c>`````ff'
let g:Lf_WindowPosition = 'popup'
let g:Lf_ShowRelativePath = 0
let g:Lf_CursorBlink = 1
let g:Lf_CacheDirectory = stdpath('cache')
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.vscode']
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_ShowHidden = 1
let g:Lf_ReverseOrder = 1
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {
      \ 'File': 0,
      \ 'Buffer': 0,
      \ 'Mru': 0,
      \ 'Tag': 0,
      \ 'BufTag': 0,
      \ 'Function': 0,
      \ 'Line': 0,
      \ 'Colorscheme': 0,
      \ 'Rg': 0,
      \ 'Gtags': 0
      \}
let g:Lf_WildIgnore = {
      \ 'dir': ['.svn','.git','.hg', '.vscode'],
      \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
      \}
let g:Lf_RgConfig = [
      \ '--glob=!\.git/*',
      \ '--glob=!\.vscode/*',
      \ '--glob=!\.svn/*',
      \ '--glob=!\.hg/*',
      \ '--case-sensitive',
      \ has('win32') ? '--crlf' : '--no-crlf',
      \ '--multiline',
      \ '--hidden'
      \ ]
nnoremap <silent> <leader>ft :<C-u>LeaderfBufTagAll<CR>
nnoremap <silent> <leader>fb :<C-u>LeaderfBufferAll<CR>
nnoremap <silent> <leader>ff :<C-u>LeaderfFile<CR>
nnoremap <silent> <leader>fh :<C-u>LeaderfHelp<CR>
nnoremap <silent> <leader>fl :<C-u>LeaderfLine<CR>
nnoremap <silent> <leader>fm :<C-u>LeaderfMruCwd<CR>
nnoremap <silent> <leader>fg :<C-u>Leaderf rg<CR>
let g:which_key_map['f']['t'] = 'tags'
let g:which_key_map['f']['b'] = 'buffers'
let g:which_key_map['f']['f'] = 'files'
let g:which_key_map['f']['h'] = 'helps'
let g:which_key_map['f']['l'] = 'lines'
let g:which_key_map['f']['m'] = 'mru files'
let g:which_key_map['f']['g'] = 'grep'
" }}}
" {{{vCoolor.vim
if !has('win32')
  let g:vcoolor_disable_mappings = 1
  let g:vcoolor_lowercase = 1
  let g:vcoolor_custom_picker = 'zenity --title "custom" --color-selection --color '
  nnoremap <silent> <leader><space><space>cc :<c-u>VCoolor<cr>
  nnoremap <silent> <leader><space><space>cr :<c-u>VCoolor r<cr>
  nnoremap <silent> <leader><space><space>cH :<c-u>VCoolor h<cr>
  nnoremap <silent> <leader><space><space>cR :<c-u>VCoolor ra<cr>
  let g:which_key_map["\<space>"]["\<space>"]['c'] = {
        \   'name': 'color picker',
        \   'c': 'insert hex',
        \   'r': 'insert rgb',
        \   'H': 'insert hsl',
        \   'R': 'insert rgba'
        \   }
endif
" }}}
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
