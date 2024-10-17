" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/features/index.vim
" Author: Sainnhe Park
" Email: i@sainnhe.dev
" License: Anti-996 && MIT
" =============================================================================

if g:vim_mode ==# 'minimal'
  finish
endif

" Initialize plugin manager{{{
" Automatically install vim-plug{{{
if !custom#plug#check()
  call custom#plug#install()
endif "}}}
 " Automatically install missing plugins on startup{{{
if g:vim_plug_auto_install
  augroup PlugAutoInstall
    autocmd!
    autocmd VimEnter *
          \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
          \|   PlugInstall --sync | q
          \| endif
  augroup END
endif "}}}
" Register mappings and commands{{{
function! s:plug_doc() "{{{
  let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
  if has_key(g:plugs, name)
    for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
      execute 'tabe' doc
    endfor
  endif
endfunction "}}}
function! s:plug_gx() "{{{
  let line = getline('.')
  let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
  let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
        \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let uri  = get(get(g:plugs, name, {}), 'uri', '')
  if uri !~# 'github.com'
    return
  endif
  let repo = matchstr(uri, '[^:/]*/'.name)
  let url  = empty(sha) ? 'https://github.com/'.repo
        \ : printf('https://github.com/%s/commit/%s', repo, sha)
  call netrw#BrowseX(url, 0)
endfunction "}}}
function! s:scroll_preview(down) "{{{
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-e>" : "\<c-y>"
    wincmd p
  endif
endfunction "}}}
function! s:setup_extra_keys() "{{{
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o
endfunction "}}}
augroup VimPlug
  autocmd!
  autocmd FileType vim-plug nmap <buffer> ? <plug>(plug-preview)
  autocmd FileType vim-plug nnoremap <buffer> <silent> h :call <sid>plug_doc()<cr>
  autocmd FileType vim-plug nnoremap <buffer> <silent> <Tab> :call <sid>plug_gx()<cr>
  autocmd FileType vim-plug call s:setup_extra_keys()
augroup END
" }}}
call plug#begin(fnamemodify(custom#utils#stdpath('data'), ':p') . 'plugins')
" }}}

" Plugin lists
" {{{ Syntax
Plug 'sheerun/vim-polyglot', { 'as': 'vim-syntax' }
Plug 'bfrg/vim-cpp-modern', { 'as': 'vim-syntax-c-cpp', 'for': ['c', 'cpp'] }
Plug 'maxmellon/vim-jsx-pretty', { 'as': 'vim-syntax-jsx', 'for': ['javascriptreact'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'kaarmu/typst.vim'
let g:polyglot_disabled = ['sensible', 'c', 'cpp', 'markdown', 'javascriptreact', 'java']
let g:vim_json_syntax_conceal = 0
let g:markdown_fenced_languages = [
      \   'html',
      \   'css',
      \   'scss',
      \   'sass=scss',
      \   'js=javascript',
      \   'jsx=javascriptreact',
      \   'ts=typescript',
      \   'tsx=typescript.tsx',
      \   'c',
      \   'cpp',
      \   'cs',
      \   'java',
      \   'py=python',
      \   'python',
      \   'go',
      \   'rust',
      \   'rs=rust',
      \   'php',
      \   'sh',
      \   'shell=sh',
      \   'bash=sh',
      \   'vim',
      \   'sql',
      \   'json',
      \   'yaml',
      \   'toml'
      \   ]
" }}}
" Color schemes
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
" UI components
Plug 'liuchengxu/vim-which-key'
let g:which_key_map = {
      \ 'name': 'Alpha',
      \ "\<space>": {
        \ 'name': 'Beta',
        \ }
      \ }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'Yggdroot/indentLine', { 'on': [] }
" Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'glts/vim-textobj-comment'
Plug 'somini/vim-textobj-fold'
Plug 'sainnhe/vim-textobj-url'
Plug 'sgur/vim-textobj-parameter'
" Operators
Plug 'kana/vim-operator-user', { 'on': ['<Plug>(operator-replace)', '<Plug>(operator-surround-append)', '<Plug>(operator-surround-delete)', '<Plug>(operator-surround-replace)'] }
Plug 'kana/vim-operator-replace', { 'on': '<Plug>(operator-replace)' }
Plug 'rhysd/vim-operator-surround', { 'on': ['<Plug>(operator-surround-append)', '<Plug>(operator-surround-delete)', '<Plug>(operator-surround-replace)'] }
" Git Integration
Plug 'tpope/vim-fugitive', { 'on': ['Git', 'Gdiffsplit', 'Gwrite'] }
Plug 'sodapopcan/vim-twiggy', { 'on': 'Twiggy' }
Plug 'samoshkin/vim-mergetool', { 'on': ['MergetoolStart', '<plug>(MergetoolToggle)'] }
Plug 'rhysd/committia.vim'
" Movement
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-smartword'
Plug 'yuttie/comfortable-motion.vim'
Plug 'justinmk/vim-sneak'
" Search
Plug 'romainl/vim-cool'
Plug 'haya14busa/vim-asterisk'
" Pairs
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
" Other basic features
Plug 'yianwillis/vimcdoc'
Plug 'drmikehenry/vim-fixkey'
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/vim-peekaboo'
Plug 'airblade/vim-rooter'
Plug 'jamessan/vim-gnupg'
Plug '520Matches/fcitx5.vim'
Plug 'mbbill/fencview', { 'on': ['FencAutoDetect', 'FencManualEncoding', 'FencView'] }
" Functional components
Plug 'tpope/vim-repeat'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim', { 'on': ['AsyncTask', 'AsyncTaskEdit'] }
Plug 'mg979/vim-visual-multi', { 'on': ['<Plug>(VM-Add-Cursor-At-Pos)', '<Plug>(VM-Visual-Cursors)'] }
Plug 'scrooloose/nerdcommenter', { 'on': ['<Plug>NERDCommenterComment', '<Plug>NERDCommenterUncomment', '<Plug>NERDCommenterToggle'] }
Plug 'vim-test/vim-test', { 'on': ['TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit'] }
Plug 'tpope/vim-dadbod', { 'on': ['DB', 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer'] }
Plug 'kristijanhusak/vim-dadbod-ui', { 'on': ['DB', 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer'] }
Plug 'voldikss/vim-translator', { 'on': ['<Plug>TranslateW', '<Plug>TranslateWV'] }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'AndrewRadev/inline_edit.vim', { 'on': 'InlineEdit' }
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'sainnhe/vim-paste-rs', { 'on': ['<Plug>(paste-rs)', 'PasteRsAddBuffer', 'PasteRsAddSelection', 'PasteRsDelete'] }
Plug 'kristijanhusak/vim-carbon-now-sh', { 'on': 'CarbonNowSh' }
Plug 'MattesGroeger/vim-bookmarks'
Plug 'lambdalisue/vim-pager', { 'on': 'PAGER' }
Plug 'lambdalisue/vim-manpager', { 'on': 'ASMANPAGER' }
Plug 'powerman/vim-plugin-AnsiEsc', {'on': ['PAGER', 'ASMANPAGER', 'AnsiEsc']}
Plug 'rhysd/devdocs.vim', { 'on': ['<Plug>(devdocs-under-cursor)', '<Plug>(devdocs-under-cursor-all)', 'DevDocs', 'DevDocsAll'] }
if !has('win32')
  Plug 'sunaku/vim-dasht'
endif
if has('nvim')
  Plug 'jbyuki/nabla.nvim'
endif
" Games
Plug 'johngrib/vim-game-code-break', { 'on': 'VimGameCodeBreak' }
Plug 'johngrib/vim-game-snake', { 'on': 'VimGameSnake' }
Plug 'mattn/vim-starwars', { 'on': 'StarWars' }
" Unix-like OS specific
if !has('win32')
  Plug 'lambdalisue/suda.vim'
endif

" Productivity
if g:vim_mode ==# 'light'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'lifepillar/vim-mucomplete'
elseif g:vim_mode ==# 'full'
  " Language features
  Plug 'github/copilot.vim'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'sainnhe/coc-java', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
  Plug 'yaegassy/coc-ruff', { 'do': 'yarn install --frozen-lockfile' }
  Plug 'dense-analysis/ale'
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
  Plug 'pechorin/any-jump.vim', { 'on': ['AnyJump', 'AnyJumpVisual'] }
  " Tree-sitter
  if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'RRethy/nvim-treesitter-textsubjects'
  endif
  " Functional components, but with extra dependencies
  Plug 'itchyny/lightline.vim'
  Plug 'albertomontesg/lightline-asyncrun'
  Plug 'sainnhe/lightline-ale'
  Plug 'ryanoasis/vim-devicons'
  Plug 'sainnhe/artify.vim'
  if g:vim_is_in_tmux && !has('win32')
    Plug 'sainnhe/tmuxline.vim', { 'on': ['Tmuxline', 'TmuxlineSnapshot'] }
  endif
  " UI components
  if !exists('g:vim_pager')
    Plug 'mhinz/vim-startify'
  endif
endif
"{{{
call plug#end()
"}}}

if $CONTAINER ==# '1'
  finish
endif

if g:vim_mode ==# 'full'
  execute 'source ' . fnamemodify(fnamemodify(custom#utils#stdpath('config'), ':p') . 'features', ':p') . 'full.vim'
endif
execute 'source ' . fnamemodify(fnamemodify(custom#utils#stdpath('config'), ':p') . 'features', ':p') . 'light.vim'
execute 'source ' . fnamemodify(fnamemodify(custom#utils#stdpath('config'), ':p') . 'features', ':p') . 'builtins.vim'

command Update call custom#utils#update()

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
