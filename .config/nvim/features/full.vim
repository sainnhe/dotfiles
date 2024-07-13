" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/features/full.vim
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
  let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'linter_unavailable', 'linter_checking'],
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
        \            [ 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'linter_unavailable', 'linter_checking'],
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
" let g:lightline.component_expand = {
"       \ 'linter_warnings': 'custom#lightline#coc_diagnostic_warning',
"       \ 'linter_errors': 'custom#lightline#coc_diagnostic_error',
"       \ 'linter_ok': 'custom#lightline#coc_diagnostic_ok',
"       \ 'asyncrun_status': 'lightline#asyncrun#status'
"       \ }
" let g:lightline.component_type = {
"       \ 'linter_warnings': 'warning',
"       \ 'linter_errors': 'error'
"       \ }
" }}}
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_infos': 'lightline#ale#infos',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ 'linter_unavailable': 'lightline#ale#unavailable',
      \ 'asyncrun_status': 'lightline#asyncrun#status'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error',
      \ }
let g:lightline#ale#indicator_checking = 'Linting...'
let g:lightline#ale#indicator_infos = " "
let g:lightline#ale#indicator_warnings = " "
let g:lightline#ale#indicator_errors = " "
let g:lightline#ale#indicator_ok = ""
let g:lightline#ale#indicator_unavailable = ""
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
  let g:startify_session_dir = fnamemodify(custom#utils#stdpath('data'), ':p') . 'sessions'
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
" {{{copilot.vim
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
imap <silent> <A-n> <Plug>(copilot-next)
imap <silent> <A-p> <Plug>(copilot-previous)
let g:copilot_no_tab_map = v:true
" }}}
" {{{coc.nvim
" {{{coc-init
let g:coc_data_home = fnamemodify(custom#utils#stdpath('data'), ':p') . 'coc'
let g:coc_filetype_map = {
      \ 'tex': 'latex',
      \ 'plaintex': 'latex',
      \ 'text': 'plaintext',
      \ 'help': 'plaintext',
      \ 'gitcommit': 'plaintext',
      \ }
let g:coc_global_extensions = [
      \ 'coc-angular',
      \ 'coc-calc',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-css',
      \ 'coc-deno',
      \ 'coc-dictionary',
      \ 'coc-docker',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-gitignore',
      \ 'coc-go',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-htmlhint',
      \ 'coc-imselect',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-lua',
      \ 'coc-markdown-preview-enhanced',
      \ 'coc-markdownlint',
      \ 'coc-marketplace',
      \ 'coc-project',
      \ 'coc-pyright',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-sql',
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
let s:java_home = !empty($JAVA_HOME) ? $JAVA_HOME :
      \ has('win32') ? expand('~/scoop/apps/openjdk/current') :
      \ has('osxdarwin') ? '/Library/Java/JavaVirtualMachines/default/Contents/Home' :
      \ isdirectory('/usr/lib/jvm/default') ? '/usr/lib/jvm/default' :
      \ isdirectory('/usr/lib/jvm/jre') ? '/usr/lib/jvm/java' :
      \ isdirectory('/usr/lib/jvm/default-jvm') ? '/usr/lib/jvm/default-jvm' : '/usr'
let g:root_patterns = [
      \ '.git',
      \ '.hg',
      \ '.svn',
      \ 'Makefile',
      \ 'CMakeLists.txt',
      \ 'requirements.txt',
      \ 'Cargo.toml',
      \ 'go.mod',
      \ 'tsconfig.json',
      \ 'pom.xml',
      \ 'venv',
      \ ]
call coc#config('java', {
      \ 'jdt': {
        \ 'ls': {
          \ 'java': {
            \ 'home': s:java_home
            \ }
          \ }
        \ },
      \ 'configuration': {
        \ 'runtimes': [{
          \ 'name': 'JavaSE-21',
          \ 'default': v:true,
          \ 'path': s:java_home
        \ }]
      \ },
      \ 'format': {
        \ 'settings': {
          \ 'url': fnamemodify(fnamemodify(custom#utils#stdpath('config'), ':p') . 'resources', ':p') . 'eclipse-java-google-style.xml',
          \ 'profile': 'GoogleStyle'
          \ }
        \ }
      \ })
call coc#config('xml', {
      \ 'java': {
        \ 'home': s:java_home
        \ }
      \ })
call coc#config('semanticTokens', {
      \ 'filetypes': has('nvim') ? [''] : ['*']
      \ })
call coc#config('project', {
      \ 'dbpath': fnamemodify(g:coc_data_home, ':p') . 'project.json',
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
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
inoremap <silent><expr> <C-j>
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetNext', [])\<cr>" :
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ "\<Down>"
inoremap <silent><expr> <C-k>
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetPrev', [])\<cr>" :
      \ "\<Up>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) :
      \ custom#utils#check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) :
      \ custom#utils#check_back_space() ? "\<S-TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? "\<Space>\<Backspace>\<CR>" : "\<CR>"
inoremap <silent><expr> <up> coc#pum#visible() ? "\<Space>\<Backspace>\<up>" : "\<up>"
inoremap <silent><expr> <down> coc#pum#visible() ? "\<Space>\<Backspace>\<down>" : "\<down>"
inoremap <silent><expr> <left> coc#pum#visible() ? "\<Space>\<Backspace>\<left>" : "\<left>"
inoremap <silent><expr> <right> coc#pum#visible() ? "\<Space>\<Backspace>\<right>" : "\<right>"
nnoremap <silent><expr> <A-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-d>"
nnoremap <silent><expr> <A-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-u>"
inoremap <silent><expr> <A-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<A-d>"
inoremap <silent><expr> <A-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<A-u>"
nnoremap <silent><nowait> <A-b> :<C-u>call custom#dashboard#toggle_outline()<CR>
nnoremap <silent> <A-=> :<C-u>CocCommand terminal.Toggle<CR>
tnoremap <silent> <A-=> <C-\><C-n>:<C-u>CocCommand terminal.Toggle<CR>
nnoremap <silent> <A--> :<C-u>CocCommand terminal.REPL<CR>
tnoremap <silent> <A--> <C-\><C-n>:<C-u>CocCommand terminal.Toggle<CR>
nmap <silent> <leader>f<Space> :<C-u>CocList<CR>
nmap <silent> <leader>fy :<C-u>CocList yank<CR>
nmap <silent> <leader>fs :<C-u>CocList symbols<CR>
nmap <silent> <leader>fh :<C-u>CocList helptags<CR>
nmap <silent> <leader>fl :<C-u>CocList --interactive --ignore-case lines<CR>
nmap <silent> <leader>ff :<C-u>CocList files<CR>
nmap <silent> <leader>fb :<C-u>CocList buffers<CR>
nmap <silent> <leader>fm :<C-u>CocList mru<CR>
nmap <silent> <leader>fg :<C-u>CocList grep<CR>
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>jD <Plug>(coc-declaration)
nmap <silent> <leader>jt <Plug>(coc-type-definition)
nmap <silent> <leader>jr <Plug>(coc-references-used)
nmap <silent> <leader>jR <Plug>(coc-references)
nmap <silent> <leader>jm <Plug>(coc-implementation)
nmap <silent> <leader>ar <Plug>(coc-rename)
nmap <silent> <leader>aR <Plug>(coc-refactor)
nmap <silent> <leader>acb <Plug>(coc-codeaction)
nmap <silent> <leader>acl <Plug>(coc-codeaction-line)
nmap <silent> <leader>acc <Plug>(coc-codeaction-cursor)
vmap <silent> <leader>ac <Plug>(coc-codeaction-selected)
nmap <silent> <leader>aCp :<C-u>CocCommand editor.action.pickColor<CR>
nmap <silent> <leader>aCP :<C-u>CocCommand editor.action.colorPresentation<CR>
nmap <silent> <leader>js :<C-u>CocCommand document.jumpToNextSymbol<CR>
nmap <silent> <leader>jS :<C-u>CocCommand document.jumpToPrevSymbol<CR>
nmap <silent> <leader>ao <Plug>(coc-openlink)
nmap <silent> <leader>ahc :<C-u>call CocAction('showOutgoingCalls')<CR>
nmap <silent> <leader>aHc :<C-u>call CocAction('showIncomingCalls')<CR>
nmap <silent> <leader>aht :<C-u>call CocAction('showOutgoingCalls')<CR>
nmap <silent> <leader>aHt :<C-u>call CocAction('showIncomingCalls')<CR>
nmap <silent> zM :<C-u>call custom#utils#coc_fold()<CR>
nmap <silent> <leader>al <Plug>(coc-codelens-action)
nmap <silent> <leader>amp :<C-u>CocCommand markdown-preview-enhanced.openPreview<cr>
nmap <silent> <leader>ami :<C-u>CocCommand markdown-preview-enhanced.openImageHelper<cr>
nmap <silent> <leader>amI :<C-u>CocCommand markdown-preview-enhanced.showUploadedImages<cr>
nmap <silent> <leader>amr :<C-u>CocCommand markdown-preview-enhanced.runCodeChunk<cr>
nmap <silent> <leader>amR :<C-u>CocCommand markdown-preview-enhanced.runAllCodeChunks<cr>
nmap <silent> <leader><Tab> <Plug>(coc-format)
vmap <silent> <leader><Tab> <Plug>(coc-format-selected)
nmap <silent> <leader>jg <Plug>(coc-git-nextchunk)
nmap <silent> <leader>jG <Plug>(coc-git-prevchunk)
nmap <silent> <leader>gi <Plug>(coc-git-chunkinfo)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nmap <silent> <leader>gD :CocCommand git.diffCached<CR>
nmap <silent> <leader>gu :<C-u>CocCommand git.chunkUndo<CR>
nmap <silent> <leader>ga :<C-u>CocCommand git.chunkStage<CR>
nmap <silent> <leader>gf :<C-u>CocCommand git.foldUnchanged<CR>
nmap <silent> <leader>go :<C-u>CocCommand git.browserOpen<CR>
nmap <silent> <leader>gs :<C-u>CocList gstatus<cr>
nmap <silent> <leader>gla :<C-u>CocList commits<cr>
nmap <silent> <leader>glc :<C-u>CocList bcommits<cr>
nmap <silent> <leader>gll <Plug>(coc-git-commit)
nmap <silent> <leader>afc <Plug>(coc-fix-current)
nmap <silent> <leader>afa :<C-u>call CocActionAsync('fixAll')<CR>
nmap <silent> <leader>ai :<C-u>call CocActionAsync('organizeImport')<CR>
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
" Show hover when provider exists, fallback to vim's builtin behavior.
nnoremap <silent> ? :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('definitionHover')
  else
    call feedkeys('?', 'in')
  endif
endfunction
" Define which key mappings
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
let g:which_key_map['j']['g'] = 'next git chunk'
let g:which_key_map['j']['G'] = 'prev git chunk'
let g:which_key_map['<Tab>'] = 'format'
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
let g:which_key_map['g'] = {
      \   'name': 'git',
      \   'D': 'diff staged',
      \   'i': 'chunk info',
      \   'u': 'chunk undo',
      \   'a': 'chunk stage',
      \   's': 'status',
      \   'l': {'name': 'logs', 'a': 'log (all)', 'c': 'log (cur buf)', 'l': 'log (cur line)'},
      \   'f': 'toggle fold unchanged',
      \   'o': 'open remote url in the browser',
      \   }
let g:which_key_map['f'] = {
      \   'name': 'fuzzy finder',
      \   "\<Space>": 'list',
      \   'l': 'lines',
      \   'f': 'files',
      \   'b': 'buffers',
      \   'm': 'mru files',
      \   'g': 'grep',
      \   's': 'symbols',
      \   'y': 'yank',
      \   'h': 'help',
      \   }
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
" }}}
" {{{ale
let g:ale_close_preview_on_insert = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_disable_lsp = 1
let g:ale_echo_cursor = 0
let g:ale_virtualtext_cursor = 0
let g:ale_echo_msg_error_str = 'ERR'
let g:ale_echo_msg_info_str = 'INFO'
let g:ale_echo_msg_warning_str = 'WARN'
let g:ale_echo_msg_log_str = 'LOG'
let g:ale_hover_cursor = 0
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_sign_error = "󰅜"
let g:ale_sign_info = "󰋼"
let g:ale_sign_warning = ""
nmap <silent> <leader>jl <Plug>(ale_next_wrap)<Plug>(ale_detail)
nmap <silent> <leader>jL <Plug>(ale_previous_wrap)<Plug>(ale_detail)
nmap <silent> <leader>je <Plug>(ale_next_wrap_error)<Plug>(ale_detail)
nmap <silent> <leader>jE <Plug>(ale_previous_wrap_error)<Plug>(ale_detail)
let g:which_key_map['j']['l'] = 'next linting'
let g:which_key_map['j']['L'] = 'prev linting'
let g:which_key_map['j']['e'] = 'next error'
let g:which_key_map['j']['E'] = 'prev error'
" For example, 'javascriptreact': 'javascript' will make javascriptreact to run
" javascript linters
let g:ale_linter_aliases = {
      \ 'Dockerfile': 'dockerfile',
      \ 'csh': 'sh',
      \ 'html': ['html', 'javascript', 'css'],
      \ 'javascriptreact': ['javascript', 'jsx'],
      \ 'plaintex': 'tex',
      \ 'ps1': 'powershell',
      \ 'rmarkdown': 'r',
      \ 'rmd': 'r',
      \ 'systemverilog': 'verilog',
      \ 'typescriptreact': ['typescript', 'tsx'],
      \ 'vader': ['vim', 'vader'],
      \ 'verilog_systemverilog': ['verilog_systemverilog', 'verilog'],
      \ 'vimwiki': 'markdown',
      \ 'vue': ['vue', 'javascript'],
      \ 'xsd': ['xsd', 'xml'],
      \ 'xslt': ['xslt', 'xml'],
      \ 'zsh': 'sh',
      \ }
" Disable default linters and use configured only.
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'java': ['pmd'],
      \ 'sh': ['shellcheck'],
      \ 'go': ['golangci-lint'],
      \ }
let g:ale_java_pmd_options =
      \ 'pmd'
      \ . ' -R category/java/bestpractices.xml'
      \ . ' -R category/java/documentation.xml'
      \ . ' -R category/java/errorprone.xml'
      \ . ' -R category/java/multithreading.xml'
      \ . ' -R category/java/performance.xml'
      \ . ' -R category/java/security.xml'
      "\ . ' -R category/java/codestyle.xml'
      "\ . ' -R category/java/design.xml'
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
" {{{Tree-sitter
if has('nvim')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc", "beancount" },
  highlight = {
    enable = true,
    disable = { "vim", "help", "markdown" },
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
  },
  textsubjects = {
    enable = true,
    keymaps = {
        ['.'] = 'textsubjects-smart',
    }
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  }
}
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
endif
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
