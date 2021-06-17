" =============================================================================
" URL: https://github.com/sainnhe/dotfiles
" Filename: .config/nvim/features/index.vim
" Author: Sainnhe Park
" Email: sainnhe@gmail.com
" License: Anti-996 License
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
if g:vim_plug_auto_install == 1
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
command PU PlugUpdate | PlugUpgrade | CocUpdate
" }}}
call plug#begin(fnamemodify(stdpath('data'), ':p') . 'plugins')
" }}}

" Plugin lists
" {{{ Syntax
Plug 'sheerun/vim-polyglot', {'as': 'vim-syntax'}
Plug 'bfrg/vim-cpp-modern', {'as': 'vim-syntax-c-cpp', 'for': ['c', 'cpp']}
Plug 'maxmellon/vim-jsx-pretty', {'as': 'vim-syntax-jsx', 'for': ['javascriptreact']}
Plug 'elzr/vim-json', {'for': 'json'}
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
" Additional UI components
Plug 'liuchengxu/vim-which-key'
Plug 'haya14busa/incsearch.vim'
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'norcalli/nvim-colorizer.lua'
" Text objects
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'somini/vim-textobj-fold'
Plug 'mattn/vim-textobj-url'
Plug 'kana/vim-textobj-entire'
Plug 'sgur/vim-textobj-parameter'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-lastpat'
" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'rhysd/committia.vim'
Plug 'samoshkin/vim-mergetool'
" Movement
Plug 'yuttie/comfortable-motion.vim'
Plug 'justinmk/vim-sneak'
Plug 'pechorin/any-jump.vim'
Plug 'chaoren/vim-wordmotion'
" Pairs
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
Plug 'alvan/vim-closetag'
" Other basic features
Plug 'yianwillis/vimcdoc'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'
Plug 'jamessan/vim-gnupg'
Plug 'rickhowe/diffchar.vim'
" Extended functional components
Plug 'mg979/vim-visual-multi'
Plug 'scrooloose/nerdcommenter'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-translator'
Plug 'tpope/vim-surround'
Plug 'junegunn/limelight.vim', {'on': 'Limelight!!'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'rmolin88/pomodoro.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'AndrewRadev/inline_edit.vim'
Plug 'masukomi/vim-markdown-folding'
Plug 'AndrewRadev/linediff.vim', {'on': ['Linediff', 'LinediffAdd']}
Plug 'will133/vim-dirdiff', {'on': 'DirDiff'}
Plug 'mbbill/fencview', {'on': ['FencAutoDetect', 'FencView']}
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}
" Unix-like OS specific
if !has('win32')
  Plug 'lambdalisue/suda.vim'
  Plug 'lambdalisue/vim-manpager'
endif

" Productivity
if g:vim_mode ==# 'light'
  Plug 'hrsh7th/nvim-compe'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
elseif g:vim_mode ==# 'full'
  " Language features
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'liuchengxu/vista.vim'
  Plug 'puremourning/vimspector'
  Plug 'KabbAmine/zeavim.vim'
  " Tree-sitter
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'RRethy/nvim-treesitter-textsubjects'
  " Extended functional components, but with extra dependencies
  Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & npm ci'}
  if !has('win32')
    Plug 'tjdevries/coc-zsh'
    Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
    Plug 'KabbAmine/vCoolor.vim'
    Plug 'lilydjwg/fcitx.vim', {'on': []}
          \| au InsertEnter * call plug#load('fcitx.vim')
    Plug 'kkoomen/vim-doge', {'do': 'npm ci && npm run build:binary:unix -- vim-doge'}
  else
    Plug 'Yggdroot/LeaderF', {'do': '.\install.bat'}
    Plug 'kkoomen/vim-doge', {'do': 'npm ci && npm run build:binary:windows -- vim-doge'}
  endif
  " Status line
  Plug 'itchyny/lightline.vim'
  Plug 'albertomontesg/lightline-asyncrun'
  Plug 'ryanoasis/vim-devicons'
  Plug 'sainnhe/artify.vim'
  if g:vim_is_in_tmux == 1 && !has('win32')
    Plug 'sainnhe/tmuxline.vim', {'on': ['Tmuxline', 'TmuxlineSnapshot']}
  endif
  " Additional UI components
  if g:vim_enable_startify == 1
    Plug 'mhinz/vim-startify'
  endif
endif
"{{{
call plug#end()
"}}}

if g:vim_mode ==# 'full'
  execute 'source ' . fnamemodify(fnamemodify(stdpath('config'), ':p') . 'features', ':p') . 'full.vim'
endif
execute 'source ' . fnamemodify(fnamemodify(stdpath('config'), ':p') . 'features', ':p') . 'light.vim'

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
