"{{{Basic
"{{{BasicConfig
if empty(globpath(&runtimepath, '/autoload/plug.vim'))
  echoerr 'Unable to find autoload/plug.vim. Download it from https://github.com/junegunn/vim-plug'
  finish
endif
if !has('win32')
  set runtimepath-=/usr/share/vim/vimfiles
endif
if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:vim_is_in_tmux = 1
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
  let g:vim_is_in_tmux = 0
endif
if exists('g:vim_man_pager')
  let g:vim_enable_startify = 0
else
  let g:vim_enable_startify = 1
endif
execute 'source ' . fnamemodify(stdpath('config'), ':p') . 'env.vim'
"}}}
"FVim{{{
if exists('g:fvim_loaded')
  FVimCursorSmoothMove v:true
  FVimCursorSmoothBlink v:true
  FVimCustomTitleBar v:true
  FVimFontLigature v:true
  FVimFontNoBuiltinSymbols v:true
  FVimFontAutoSnap v:true
  FVimUIPopupMenu v:false
  FVimToggleFullScreen
endif
"}}}
"Neovide{{{
let g:neovide_cursor_vfx_mode = 'torpedo'
let g:neovide_fullscreen = v:true
"}}}
"}}}
"{{{Global
"{{{Function
function! s:close_on_last_tab() "{{{
  if tabpagenr('$') == 1
    execute 'windo bd'
    execute 'q'
  elseif tabpagenr('$') > 1
    execute 'windo bd'
  endif
endfunction "}}}
function! s:indent_len(str) "{{{
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction "}}}
function! s:go_indent(times, dir) "{{{
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction "}}}
function! s:get_highlight() "{{{
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc "}}}
function! s:escaped_search() range "{{{
  let l:saved_reg = @"
  execute 'normal! vgvy'
  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction "}}}
function! s:local_vimrc() "{{{ Apply `.settings.vim`
  let root_dir = FindRootDirectory()
  let settings_file = fnamemodify(root_dir, ':p') . '.settings.vim'
  if filereadable(settings_file)
    exec 'source ' . settings_file
  endif
endfunction "}}}
"}}}
"{{{Setting
set encoding=utf-8 nobomb
set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
set fileformats=unix,dos,mac
scriptencoding utf-8
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<A-z>"
nnoremap <SPACE> <Nop>
set number cursorline
set noshowmode
set incsearch
set mouse=a
filetype plugin indent on
set t_Co=256
syntax enable                           " 开启语法支持
set termguicolors                       " 开启GUI颜色支持
set smartindent                         " 智能缩进
set nohlsearch                          " 禁用高亮搜索
set undofile                            " 始终保留undo文件
set timeoutlen=500                      " 超时时间为 0.5 秒
set foldmethod=marker                   " 折叠方式为按照marker折叠
set hidden                              " buffer自动隐藏
set showtabline=2                       " 总是显示标签
set scrolloff=5                         " 保持5行
set viminfo='1000                       " 文件历史个数
set autoindent                          " 自动对齐
set wildmenu                            " 命令框Tab呼出菜单
set autoread                            " 自动加载变更文件
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab     " tab设定，:retab 使文件中的TAB匹配当前设置
set signcolumn=yes
set updatetime=100
set history=1000
set sessionoptions+=globals
execute 'set undodir=' . fnamemodify(stdpath('cache'), ':p') . 'undo'
if !has('win32')
  set dictionary+=/usr/share/dict/words
  set dictionary+=/usr/share/dict/american-english
endif
if has('nvim')
  set inccommand=split
  set wildoptions=pum
  filetype plugin indent on
endif
augroup VimSettings
  autocmd!
  autocmd FileType html,css,scss,typescript set shiftwidth=2
  autocmd VimLeave * set guicursor=a:ver25-Cursor/lCursor
  autocmd BufEnter * call s:local_vimrc()
augroup END
"}}}
"{{{Mapping
"{{{VIM-Compatible
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
"}}}
"{{{NormalMode
" Alt+X进入普通模式
nnoremap <A-x> <ESC>
if !has('nvim')
  nnoremap ^@ <ESC>
else
  nnoremap <silent> <C-l> :<C-u>wincmd p<CR>
endif
" ; 绑定到 :
nnoremap ; :
" q 绑定到:q
nmap <silent> q :<C-u>q<CR>
" <leader>q 关闭 quickfix list
nnoremap <silent> <leader>q :<C-u>cclose<CR>
" m 绑定到 q
nnoremap m q
" Ctrl+S保存文件
nnoremap <silent> <C-S> :<C-u>w<CR>
" Shift+HJKL快速移动
nnoremap K 7<up>
nnoremap J 7<down>
nnoremap H 0
nnoremap L $
" Shift加方向键加速移动
nnoremap <S-up> <Esc>7<up>
nnoremap <S-down> <Esc>7<down>
nnoremap <S-left> <Esc>0
nnoremap <S-right> <Esc>$
" x删除字符但不保存到剪切板
nnoremap x "_x
" Ctrl+X剪切当前行但不保存到剪切板
nnoremap <C-X> <ESC>"_dd
" <leader>+Y复制到系统剪切板
nnoremap <leader>y "+y
" <leader>+P从系统剪切板粘贴
nnoremap <leader>p "+p
" Alt+T新建tab
nnoremap <silent> <A-t> :<C-u>tabnew<CR>:call ExplorerStartify()<CR>
" Alt+W关闭当前标签
nnoremap <silent> <A-w> :<C-u>call <SID>close_on_last_tab()<CR>
" Alt/Ctrl+上下左右可以跳转和移动窗口
if has('win32') && !has('gui_running')
  nnoremap <C-left> <Esc>gT
  nnoremap <C-right> <Esc>gt
endif
nnoremap <A-left> <Esc>gT
nnoremap <A-right> <Esc>gt
nnoremap <silent> <A-up> :<C-u>tabm -1<CR>
nnoremap <silent> <A-down> :<C-u>tabm +1<CR>
" Alt+h j k l可以在窗口之间跳转
nnoremap <silent> <A-h> :<C-u>wincmd h<CR>
nnoremap <silent> <A-l> :<C-u>wincmd l<CR>
nnoremap <silent> <A-k> :<C-u>wincmd k<CR>
nnoremap <silent> <A-j> :<C-u>wincmd j<CR>
" Alt+V && Alt+S新建窗口
nnoremap <silent> <A-v> :<C-u>vsp<CR>
nnoremap <silent> <A-s> :<C-u>sp<CR>
" neovim下，Alt+Shift+V, Alt+Shift+S分别切换到垂直和水平分割
if has('nvim')
  nnoremap <silent> <A-V> :<C-u>wincmd t<CR>:wincmd H<CR>
  nnoremap <silent> <A-S> :<C-u>wincmd t<CR>:wincmd K<CR>
endif
" Alt+-<>调整窗口大小
nnoremap <silent> <A-=> :<C-u>wincmd +<CR>
nnoremap <silent> <A--> :<C-u>wincmd -<CR>
nnoremap <silent> <A-,> :<C-u>wincmd <<CR>
nnoremap <silent> <A-.> :<C-u>wincmd ><CR>
" z+方向键快速跳转
nnoremap z<left> zk
nnoremap z<right> zj
nnoremap z<up> [z
nnoremap z<down> ]z
" z+hjkl快速跳转
nnoremap zh zk
nnoremap zl zj
nnoremap zj ]z
nnoremap zk [z
" zo递归局部打开折叠，zc递归局部关闭折叠
nnoremap zo zO
nnoremap zc zC
" zO递归全局打开折叠，C递归全局关闭折叠
nnoremap zO zR
nnoremap zC zM
" zf创建新的折叠，zd删除当前折叠
nnoremap zf zf
nnoremap zd zd
" zn创建新的折叠，并yard当前行的内容
nmap zn $vbda<Space><CR><Space><CR><Space><ESC>v<up><up>zfa<Backspace><down><right><Backspace><down><right><Backspace><up><up><Esc>A
" zs保存折叠视图，zl加载折叠视图
nnoremap zs :<C-u>mkview<CR>
nnoremap zl :<C-u>loadview<CR>
" 获取当前光标下的高亮组
nnoremap <leader><Space>h :<C-u>call <SID>get_highlight()<CR>
" gi, gI跳转indent
nnoremap <silent> gi :<C-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gI :<C-u>call <SID>go_indent(v:count1, -1)<cr>
"}}}
"{{{InsertMode
" Alt+X进入普通模式
inoremap <A-x> <ESC><right>
if !has('nvim')
  inoremap ^@ <ESC>
endif
" Ctrl+V粘贴
inoremap <C-V> <Space><Backspace><ESC>pa
" <A-z><C-v>从系统剪切板粘贴
inoremap <A-z><C-V> <Space><Backspace><ESC>"+pa
" Ctrl+S保存文件
inoremap <silent> <C-S> <Esc>:w<CR>a
" Ctrl+O跳转
inoremap <C-o> <Esc><C-o>i
" Ctrl+Z撤销上一个动作
" Ctrl+R撤销撤销的动作
inoremap <C-R> <ESC><C-R>i
" Ctrl+X剪切当前行但不保存到剪切板
inoremap <C-X> <ESC>"_ddi
" Ctrl+hjkl移动
inoremap <C-h> <left>
inoremap <C-l> <right>
" Shift加方向键加速移动
inoremap <S-up> <up><up><up><up><up>
inoremap <S-down> <down><down><down><down><down>
inoremap <S-left> <ESC>I
inoremap <S-right> <ESC>A
" Ctrl + e/w/b
inoremap <C-e> <ESC>ea
inoremap <C-w> <ESC>lwi
inoremap <C-b> <ESC>lbi
" Alt+上下左右可以跳转和移动窗口
inoremap <silent> <A-left> <Esc>:wincmd h<CR>i
inoremap <silent> <A-right> <Esc>:wincmd l<CR>i
inoremap <silent> <A-up> <Esc>:tabm -1<CR>i
inoremap <silent> <A-down> <Esc>:tabm +1<CR>i
"}}}
"{{{VisualMode
" Alt+X进入普通模式
vnoremap <A-x> <ESC>
snoremap <A-x> <ESC>
if !has('nvim')
  vnoremap ^@ <ESC>
endif
" ; 绑定到 :
vnoremap ; :
" Ctrl+S保存文件
vnoremap <silent> <C-S> :<C-u>w<CR>v
" x删除字符但不保存到剪切板
vnoremap x "_x
" Shift+方向键快速移动
vnoremap <S-up> <up><up><up><up><up>
vnoremap <S-down> <down><down><down><down><down>
vnoremap <S-left> 0
vnoremap <S-right> $<left>
" Shift+HJKL快速移动
vnoremap K 5<up>
vnoremap J 5<down>
vnoremap H 0
vnoremap L $h
" <leader>+Y复制到系统剪切板
vnoremap <leader>y "+y
" <leader>+P从系统剪切板粘贴
vnoremap <leader>p "+p
" * 搜索选中文本
vnoremap <silent> * :<C-u>call <SID>escaped_search()<CR>/<C-R>=@/<CR><CR>N
"}}}
"{{{CommandMode
" Alt+X进入普通模式
cmap <A-x> <ESC>
if !has('nvim')
  cmap ^@ <ESC>
endif
" Ctrl+S保存
cmap <C-S> :<C-u>w<CR>
"}}}
"{{{TerminalMode
if has('nvim')
  " Alt+X进入普通模式
  tnoremap <A-x> <C-\><C-n>
  " Shift+方向键加速移动
  tnoremap <S-left> <C-a>
  tnoremap <S-right> <C-e>
endif
"}}}
"}}}
"}}}
"{{{Plugin
"{{{init
"{{{ automatically install missing plugins on startup
if g:vim_plug_auto_install == 1
  augroup PlugAutoInstall
    autocmd!
    autocmd VimEnter *
          \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
          \|   PlugInstall --sync | q
          \| endif
  augroup END
endif "}}}
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
call plug#begin(fnamemodify(stdpath('data'), ':p') . 'plugins')
"}}}
"{{{syntax
Plug 'sheerun/vim-polyglot', {'as': 'vim-syntax'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'bfrg/vim-cpp-modern', {'as': 'vim-syntax-c-cpp', 'for': ['c', 'cpp']}
Plug 'maxmellon/vim-jsx-pretty', {'as': 'vim-syntax-jsx', 'for': ['javascriptreact']}
Plug 'elzr/vim-json', {'for': 'json'}
let g:polyglot_disabled = ['c', 'cpp', 'markdown', 'javascriptreact']
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
augroup VimSyntax
  autocmd!
  autocmd BufNewFile,BufRead *.json set foldmethod=syntax
augroup END
"}}}
" User Interface
"{{{colorschemes
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
"}}}
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'albertomontesg/lightline-asyncrun'
Plug 'rmolin88/pomodoro.vim'
if g:vim_is_in_tmux == 1 && !has('win32')
  Plug 'sainnhe/tmuxline.vim', {'on': ['Tmuxline', 'TmuxlineSnapshot']}
endif
if g:vim_enable_startify == 1
  Plug 'mhinz/vim-startify'
endif
Plug 'norcalli/nvim-colorizer.lua'
Plug 'liuchengxu/vim-which-key'
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/limelight.vim', {'on': 'Limelight!!'}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'roman/golden-ratio'
Plug 'sainnhe/artify.vim'

" Productivity
if !has('win32')
  Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
  Plug 'tjdevries/coc-zsh'
  Plug 'lambdalisue/suda.vim'
  Plug 'lambdalisue/vim-manpager'
  Plug 'lilydjwg/fcitx.vim', {'on': []}
        \| au InsertEnter * call plug#load('fcitx.vim')
  Plug 'KabbAmine/vCoolor.vim'
else
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'Yggdroot/LeaderF', {'do': '.\install.bat'}
endif
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'justinmk/vim-sneak'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'rhysd/committia.vim'
Plug 'samoshkin/vim-mergetool'
Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/inline_edit.vim'
Plug 'airblade/vim-rooter'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mbbill/fencview', {'on': ['FencAutoDetect', 'FencView']}
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}
Plug 'andymass/vim-matchup'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-sleuth'
Plug 'alvan/vim-closetag'
Plug 'masukomi/vim-markdown-folding'
Plug 'yianwillis/vimcdoc'
Plug 'voldikss/vim-translator'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & npm install'}
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
Plug 'haya14busa/incsearch.vim'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'somini/vim-textobj-fold'
Plug 'mattn/vim-textobj-url'
Plug 'kana/vim-textobj-entire'
Plug 'sgur/vim-textobj-parameter'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-lastpat'
Plug 'pechorin/any-jump.vim'
Plug 'chaoren/vim-wordmotion'
"{{{
call plug#end()
"}}}
"}}}
" User Interface
"{{{lightline.vim
"{{{functions
function! CocDiagnosticError() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'error', 0) ==# 0 ? '' : "\uf00d" . info['error']
endfunction "}}}
function! CocDiagnosticWarning() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'warning', 0) ==# 0 ? '' : "\uf529" . info['warning']
endfunction "}}}
function! CocDiagnosticOK() abort "{{{
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0) ==# 0 && get(info, 'error', 0) ==# 0
    let msg = "\uf00c"
  else
    let msg = ''
  endif
  return msg
endfunction "}}}
function! CocStatus() abort "{{{
  return get(g:, 'coc_status', '')
endfunction "}}}
function! GitGlobal() abort "{{{
  let git_status = get(g:, 'coc_git_status', '')
  if git_status ==# ''
    if g:vim_lightline_artify ==# 2
      let status = ' ' . artify#convert(fnamemodify(getcwd(), ':t'), 'monospace')
    else
      let status = ' ' . fnamemodify(getcwd(), ':t')
    endif
  else
    if g:vim_lightline_artify ==# 2
      let status = artify#convert(git_status, 'monospace')
    else
      let status = git_status
    endif
  endif
  return status
endfunction "}}}
function! PomodoroStatus() abort "{{{
  if pomo#remaining_time() ==# '0'
    return "\ue001"
  else
    return "\ue003 ".pomo#remaining_time()
  endif
endfunction "}}}
function! DeviconsFiletype() "{{{
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction "}}}
function! TabNum(n) abort "{{{
  return a:n." \ue0bb"
endfunction "}}}
function! ArtifyActiveTabNum(n) abort "{{{
  return artify#convert(a:n, 'bold')." \ue0bb"
endfunction "}}}
function! ArtifyInactiveTabNum(n) abort "{{{
  return artify#convert(a:n, 'double_struck')." \ue0bb"
endfunction "}}}
function! ArtifyLightlineTabFilename(s) abort "{{{
  if g:vim_lightline_artify ==# 2
    return artify#convert(lightline#tab#filename(a:s), 'monospace')
  else
    return lightline#tab#filename(a:s)
  endif
endfunction "}}}
function! ArtifyLightlineMode() abort "{{{
  if g:vim_lightline_artify ==# 2
    return artify#convert(lightline#mode(), 'monospace')
  else
    return lightline#mode()
  endif
endfunction "}}}
function! ArtifyLinePercent() abort "{{{
  return artify#convert(string((100*line('.'))/line('$')), 'bold')
endfunction "}}}
function! ArtifyLineNum() abort "{{{
  return artify#convert(string(line('.')), 'bold')
endfunction "}}}
function! ArtifyColNum() abort "{{{
  return artify#convert(string(getcurpos()[2]), 'bold')
endfunction "}}}
"}}}
set laststatus=2  " Basic
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
      \ 'artify_activetabnum': 'ArtifyActiveTabNum',
      \ 'artify_inactivetabnum': 'ArtifyInactiveTabNum',
      \ 'artify_filename': 'ArtifyLightlineTabFilename',
      \ 'tabnum': 'TabNum',
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly'
      \ }
let g:lightline.component = {
      \ 'git_buffer' : '%{get(b:, "coc_git_status", "")}',
      \ 'git_global' : '%{GitGlobal()}',
      \ 'artify_mode': '%{ArtifyLightlineMode()}',
      \ 'artify_lineinfo': "%2{ArtifyLinePercent()}\uf295 %3{ArtifyLineNum()}:%-2{ArtifyColNum()}",
      \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
      \ 'vim_logo': "\ue7c5",
      \ 'pomodoro': '%{PomodoroStatus()}',
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'filename': '%t',
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'modified': '%M',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'percent': '%2p%%',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '%2p%% %3l:%-2v',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ',
      \ 'winnr': '%{winnr()}'
      \ }
let g:lightline.component_function = {
      \ 'devicons_filetype': 'DeviconsFiletype',
      \ 'coc_status': 'CocStatus',
      \ }
let g:lightline.component_expand = {
      \ 'linter_warnings': 'CocDiagnosticWarning',
      \ 'linter_errors': 'CocDiagnosticError',
      \ 'linter_ok': 'CocDiagnosticOK',
      \ 'asyncrun_status': 'lightline#asyncrun#status'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
"}}}
"{{{tmuxline.vim
if g:vim_is_in_tmux == 1 && !has('win32')
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '%R',
        \'c'    : [ '#{sysstat_mem} #[fg=blue]#{sysstat_ntemp} #[fg=green]\ufa51#{upload_speed}' ],
        \'win'  : [ '#I', '#W' ],
        \'cwin' : [ '#I', '#W', '#F' ],
        \'x'    : [ "#[fg=green]#{download_speed} \uf6d9 #[fg=blue]#{sysstat_itemp} #{sysstat_cpu}" ],
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
"}}}
"{{{colorscheme
" {{{
let g:gruvbox_material_palette_soft_era = {
      \ 'bg0':              ['#f9f5f5',   '229'],
      \ 'bg1':              ['#f4f0f0',   '228'],
      \ 'bg2':              ['#f4f0f0',   '228'],
      \ 'bg3':              ['#f2edec',   '223'],
      \ 'bg4':              ['#efeae9',   '223'],
      \ 'bg5':              ['#ebe6e4',   '250'],
      \ 'bg_statusline1':   ['#f4f0f0',   '223'],
      \ 'bg_statusline2':   ['#f4f0f0',   '223'],
      \ 'bg_statusline3':   ['#ebe6e4',   '250'],
      \ 'bg_diff_green':    ['#eaf3ce',   '194'],
      \ 'bg_visual_green':  ['#eaf3ce',   '194'],
      \ 'bg_diff_red':      ['#fae1d7',   '217'],
      \ 'bg_visual_red':    ['#fae1d7',   '217'],
      \ 'bg_diff_blue':     ['#e0f0f3',   '117'],
      \ 'bg_visual_blue':   ['#e0f0f3',   '117'],
      \ 'bg_visual_yellow': ['#f6ead0',   '226'],
      \ 'bg_current_word':  ['#efeae9',   '228'],
      \ 'fg0':              ['#be9898',   '237'],
      \ 'fg1':              ['#be9898',   '237'],
      \ 'red':              ['#f165bd',   '88'],
      \ 'orange':           ['#f165bd',   '130'],
      \ 'yellow':           ['#ec9157',   '136'],
      \ 'green':            ['#96ad01',   '100'],
      \ 'aqua':             ['#25b7b8',   '165'],
      \ 'blue':             ['#75a9d9',   '24'],
      \ 'purple':           ['#aea6e1',   '96'],
      \ 'bg_red':           ['#f165bd',   '88'],
      \ 'bg_green':         ['#96ad01',   '100'],
      \ 'bg_yellow':        ['#ec9157',   '130'],
      \ 'grey0':            ['#e3cbcb',   '246'],
      \ 'grey1':            ['#dfc5c5',   '245'],
      \ 'grey2':            ['#dabfbf',   '243'],
      \ 'none':             ['NONE',      'NONE']
      \ }
" }}}
let g:color_scheme_list = {}
let g:color_scheme_list['Everforest Dark'] = [
      \   'set background=dark',
      \   'let g:everforest_disable_italic_comment = 1',
      \   "let g:everforest_sign_column_background = 'none'",
      \   'let g:everforest_lightline_disable_bold = 1',
      \   'let g:everforest_better_performance = 1',
      \   'colorscheme everforest',
      \   'call SwitchLightlineColorScheme("everforest")'
      \   ]
let g:color_scheme_list['Everforest Light'] = [
      \   'set background=light',
      \   'let g:everforest_disable_italic_comment = 1',
      \   "let g:everforest_sign_column_background = 'none'",
      \   'let g:everforest_lightline_disable_bold = 1',
      \   'let g:everforest_better_performance = 1',
      \   'colorscheme everforest',
      \   'call SwitchLightlineColorScheme("everforest")'
      \   ]
let g:color_scheme_list['Gruvbox Material Dark'] = [
      \   'set background=dark',
      \   "let g:gruvbox_material_background = 'medium'",
      \   "let g:gruvbox_material_palette = 'material'",
      \   "let g:gruvbox_material_visual = 'grey background'",
      \   "let g:gruvbox_material_cursor = 'green'",
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   "let g:gruvbox_material_sign_column_background = 'none'",
      \   'let g:gruvbox_material_statusline_style = "default"',
      \   'let g:gruvbox_material_lightline_disable_bold = 1',
      \   'let g:gruvbox_material_better_performance = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox_material")'
      \   ]
let g:color_scheme_list['Gruvbox Mix Dark'] = [
      \   'set background=dark',
      \   "let g:gruvbox_material_background = 'medium'",
      \   "let g:gruvbox_material_palette = 'mix'",
      \   "let g:gruvbox_material_visual = 'grey background'",
      \   "let g:gruvbox_material_cursor = 'green'",
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   "let g:gruvbox_material_sign_column_background = 'none'",
      \   'let g:gruvbox_material_statusline_style = "original"',
      \   'let g:gruvbox_material_lightline_disable_bold = 1',
      \   'let g:gruvbox_material_better_performance = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox_material")'
      \   ]
let g:color_scheme_list['Gruvbox Material Light'] = [
      \   'set background=light',
      \   "let g:gruvbox_material_background = 'soft'",
      \   "let g:gruvbox_material_palette = 'material'",
      \   "let g:gruvbox_material_visual = 'green background'",
      \   "let g:gruvbox_material_cursor = 'auto'",
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   "let g:gruvbox_material_sign_column_background = 'none'",
      \   'let g:gruvbox_material_statusline_style = "default"',
      \   'let g:gruvbox_material_lightline_disable_bold = 1',
      \   'let g:gruvbox_material_better_performance = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox_material")'
      \   ]
let g:color_scheme_list['Edge Dark'] = [
      \   'set background=dark',
      \   "let g:edge_style = 'aura'",
      \   'let g:edge_disable_italic_comment = 1',
      \   'let g:edge_enable_italic = 1',
      \   "let g:edge_cursor = 'blue'",
      \   'let g:edge_lightline_disable_bold = 1',
      \   "let g:edge_sign_column_background = 'none'",
      \   'let g:edge_better_performance = 1',
      \   'colorscheme edge',
      \   'call SwitchLightlineColorScheme("edge")'
      \   ]
let g:color_scheme_list['Edge Light'] = [
      \   'set background=light',
      \   "let g:edge_style = 'aura'",
      \   'let g:edge_disable_italic_comment = 1',
      \   'let g:edge_enable_italic = 1',
      \   "let g:edge_cursor = 'purple'",
      \   'let g:edge_lightline_disable_bold = 1',
      \   "let g:edge_sign_column_background = 'none'",
      \   'let g:edge_better_performance = 1',
      \   'colorscheme edge',
      \   'call SwitchLightlineColorScheme("edge")'
      \   ]
let g:color_scheme_list['Sonokai Default'] = [
      \   "let g:sonokai_style = 'default'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   "let g:sonokai_cursor = 'blue'",
      \   'let g:sonokai_lightline_disable_bold = 1',
      \   "let g:sonokai_sign_column_background = 'none'",
      \   'let g:sonokai_better_performance = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:color_scheme_list['Sonokai Shusia'] = [
      \   "let g:sonokai_style = 'shusia'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   "let g:sonokai_cursor = 'blue'",
      \   'let g:sonokai_lightline_disable_bold = 1',
      \   "let g:sonokai_sign_column_background = 'none'",
      \   'let g:sonokai_better_performance = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:color_scheme_list['Sonokai Andromeda'] = [
      \   "let g:sonokai_style = 'andromeda'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   "let g:sonokai_cursor = 'blue'",
      \   'let g:sonokai_lightline_disable_bold = 1',
      \   "let g:sonokai_sign_column_background = 'none'",
      \   'let g:sonokai_better_performance = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:color_scheme_list['Sonokai Atlantis'] = [
      \   "let g:sonokai_style = 'atlantis'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   "let g:sonokai_cursor = 'blue'",
      \   'let g:sonokai_lightline_disable_bold = 1',
      \   "let g:sonokai_sign_column_background = 'none'",
      \   'let g:sonokai_better_performance = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:color_scheme_list['Sonokai Maia'] = [
      \   "let g:sonokai_style = 'maia'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   "let g:sonokai_cursor = 'blue'",
      \   'let g:sonokai_lightline_disable_bold = 1',
      \   "let g:sonokai_sign_column_background = 'none'",
      \   'let g:sonokai_better_performance = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:color_scheme_list['Soft Era'] = [
      \   'set background=light',
      \   "let g:gruvbox_material_background = 'medium'",
      \   'let g:gruvbox_material_palette = g:gruvbox_material_palette_soft_era',
      \   "let g:gruvbox_material_visual = 'grey background'",
      \   "let g:gruvbox_material_cursor = 'auto'",
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   "let g:gruvbox_material_sign_column_background = 'none'",
      \   'let g:gruvbox_material_lightline_disable_bold = 1',
      \   'let g:gruvbox_material_better_performance = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox_material")'
      \   ]
"{{{Functions
function SwitchLightlineColorScheme(lightlineName) abort
  execute join(['source', globpath(&runtimepath, join(['autoload/lightline/colorscheme/', a:lightlineName, '.vim'], ''), 0, 1)[0]], ' ')
  let g:lightline.colorscheme = a:lightlineName
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
function SwitchColorScheme(name) abort
  for l:item in g:color_scheme_list[a:name]
    execute l:item
  endfor
endfunction
function! s:colo(a, l, p)
  return keys(g:color_scheme_list)
endfunction
command! -bar -nargs=? -complete=customlist,<sid>colo Colo call SwitchColorScheme(<f-args>)
call SwitchColorScheme(g:vim_color_scheme)
"}}}
"}}}
"{{{vim-startify
if g:vim_enable_startify == 1
  let g:startify_session_dir = fnamemodify(stdpath('data'), ':p') . 'sessions'
  let g:startify_files_number = 5
  let g:startify_update_oldfiles = 1
  let g:startify_session_delete_buffers = 1 " delete all buffers when loading or closing a session, ignore unsaved buffers
  let g:startify_change_to_dir = 1 " when opening a file or bookmark, change to its directory
  let g:startify_fortune_use_unicode = 1 " beautiful symbols
  let g:startify_padding_left = 3 " the number of spaces used for left padding
  let g:startify_session_remove_lines = ['setlocal', 'winheight'] " lines matching any of the patterns in this list, will be removed from the session file
  let g:startify_session_sort = 1 " sort sessions by alphabet or modification time
  let g:startify_custom_indices = ['1', '2', '3', '4', '5', '1', '2', '3', '4', '5'] " MRU indices
  " line 579 for more details
  if has('nvim')
    let g:startify_commands = [
          \ {'1': 'CocList'},
          \ {'2': 'terminal'},
          \ ]
  endif
  let g:startify_custom_header = [
        \ ' _,  _, _ _, _ _, _ _,_ __, __,  _, __, _,_  _, __,  _, _,_ _,  _ _, _ _,_ _  ,',
        \ "(_  /_\\ | |\\ | |\\ | |_| |_  |_) /_\\ |_) |_/ / \\ |_) / ` |_| |   | |\\ | | | '\\/",
        \ ', ) | | | | \| | \| | | |   |   | | | \ | \ |~| | \ \ , | | | , | | \| | |  /\ ',
        \ " ~  ~ ~ ~ ~  ~ ~  ~ ~ ~ ~~~ ~   ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  ~  ~ ~ ~~~ ~ ~  ~ `~' ~  ~",
        \ ]
  " costom startify list
  let g:startify_lists = [
        \ { 'type': 'sessions',  'header': [" \ue62e Sessions"]       },
        \ { 'type': 'bookmarks', 'header': [" \uf5c2 Bookmarks"]      },
        \ { 'type': 'files',     'header': [" \ufa1eMRU Files"]            },
        \ { 'type': 'dir',       'header': [" \ufa1eMRU Files in ". getcwd()] },
        \ { 'type': 'commands',  'header': [" \ufb32 Commands"]       },
        \ ]
  " MRU skipped list, do not use ~
  let g:startify_skiplist = [
        \ '/mnt/*',
        \ ]
  function ExplorerStartify()
    execute 'Startify'
    if !has('win32')
      execute 'call ToggleExplorer()'
    else
      sleep 100m
      execute 'call ToggleExplorer()'
    endif
  endfunction
  function! s:startify_mappings() abort
    nmap <silent><buffer> o <CR>
    nmap <silent><buffer> h :wincmd h<CR>
    nmap <silent><buffer> <Tab> :CocList project<CR>
  endfunction
  augroup StartifyCustom
    autocmd!
    autocmd VimEnter *
          \   if !argc()
          \ |   call ExplorerStartify()
          \ | endif
    autocmd FileType startify call s:startify_mappings()
    " on Enter
    autocmd User Startified nmap <silent><buffer> <CR> <plug>(startify-open-buffers):call ToggleExplorer()<CR>
  augroup END
endif
"}}}
"{{{vim-which-key
let g:which_key_sort_horizontal = 1
let g:which_key_sep = ''
let g:which_key_display_names = {' ': '', '<CR>': '↵', '<C-H>': '', '<C-I>': 'ﲑ', '<TAB>': '⇆'}
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
call which_key#register('<Space>', 'g:which_key_map')
let g:which_key_map = {
      \   'name': 'Alpha',
      \   '<Tab>': 'format',
      \   'p': 'paste',
      \   'q': 'close quickfix',
      \   'y': 'yank',
      \   'c': { 'name': 'comment' }
      \   }
let g:which_key_map["\<space>"] = {
      \   'name': 'Beta',
      \   'h': 'highlight'
      \   }
"}}}
"{{{nvim-colorizer.lua
lua require'colorizer'.setup()
"}}}
"{{{indentLine
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_char = ''  " ¦┆│⎸▏
let g:indent_blankline_char = g:indentLine_char
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = [ 'startify', 'coc-explorer', 'codi', 'help', 'man', 'vtm', 'markdown' ]
let g:indentLine_setColors = 0  " disable overwrite with grey by default, use colorscheme instead
"}}}
"{{{limelight.vim
let g:limelight_default_coefficient = 0.7
"}}}
"{{{goyo.vim
let g:goyo_width = 95
let g:goyo_height = 85
let g:goyo_linenr = 0
"进入goyo模式后自动触发limelight,退出后则关闭
augroup GoyoCustom
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END
nnoremap <silent> <leader><space>F :<C-u>Limelight!!<CR>
nnoremap <silent> <leader><space>R :<C-u>Goyo<CR>
let g:which_key_map["\<space>"]['F'] = 'focus mode'
let g:which_key_map["\<space>"]['R'] = 'reading mode'
"}}}
"{{{golden-ratio
let g:golden_ratio_autocommand = 0
nnoremap <silent> <leader><space>g :<c-u>GoldenRatioResize<cr>
let g:which_key_map["\<space>"]['g'] = 'resize window'
"}}}
" Productivity
"{{{coc.nvim
"{{{coc-init
let g:coc_data_home = fnamemodify(stdpath('data'), ':p') . 'coc'
let g:coc_global_extensions = [
      \ 'coc-lists',
      \ 'coc-marketplace',
      \ 'coc-diagnostic',
      \ 'coc-git',
      \ 'coc-explorer',
      \ 'coc-project',
      \ 'coc-terminal',
      \ 'coc-gitignore',
      \ 'coc-highlight',
      \ 'coc-yank',
      \ 'coc-snippets',
      \ 'coc-syntax',
      \ 'coc-tag',
      \ 'coc-emoji',
      \ 'coc-dictionary',
      \ 'coc-clangd',
      \ 'coc-html',
      \ 'coc-htmlhint',
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-tsserver',
      \ 'coc-rust-analyzer',
      \ 'coc-julia',
      \ 'coc-sh',
      \ 'coc-pyright',
      \ 'coc-markdownlint',
      \ 'coc-json',
      \ 'coc-yaml',
      \ 'coc-xml',
      \ 'coc-toml',
      \ 'coc-vimlsp',
      \ 'coc-prettier'
      \ ]
"}}}
"{{{coc-settings
augroup CocCustom
  autocmd!
  autocmd CursorHold * silent if g:coc_hover_enable == 1 && !coc#float#has_float() | call CocActionAsync('doHover') | endif
  autocmd CursorHold * silent if &filetype !=# 'markdown' | call CocActionAsync('highlight') | endif
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocGitStatusChange call lightline#update()
  autocmd CursorHold * CocCommand git.refresh
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END
let g:coc_hover_enable = 0
set hidden
set completeopt=noinsert,noselect,menuone
call coc#config('project', {
      \ 'dbpath': fnamemodify(g:coc_data_home, ':p') . 'project.json',
      \ })
call coc#config('snippets', {
      \ 'userSnippetsDirectory': fnamemodify(stdpath('data'), ':p') . 'snippets',
      \ })
call coc#config('xml', {
      \ 'java': {
      \   'home': has('win32') ? 'C:\Users\gaoti\scoop\apps\openjdk\current' : '/usr/lib/jvm/default'
      \ }
      \ })
if has('win32')
  call coc#config('terminal', {
        \ 'shellPath': 'powershell',
        \ })
endif
"}}}
"{{{coc-mappings
inoremap <silent><expr> <C-j>
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetNext', [])\<cr>" :
      \ pumvisible() ? coc#_select_confirm() :
      \ "\<Down>"
inoremap <silent><expr> <C-k>
      \ coc#jumpable() ? "\<C-R>=coc#rpc#request('snippetPrev', [])\<cr>" :
      \ "\<Up>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<S-TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <CR> pumvisible() ? "\<Space>\<Backspace>\<CR>" : "\<CR>"
inoremap <silent><expr> <up> pumvisible() ? "\<Space>\<Backspace>\<up>" : "\<up>"
inoremap <silent><expr> <down> pumvisible() ? "\<Space>\<Backspace>\<down>" : "\<down>"
inoremap <silent><expr> <left> pumvisible() ? "\<Space>\<Backspace>\<left>" : "\<left>"
inoremap <silent><expr> <right> pumvisible() ? "\<Space>\<Backspace>\<right>" : "\<right>"
nnoremap <silent><expr> <C-pagedown> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-pagedown>"
nnoremap <silent><expr> <C-pageup> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-pageup>"
inoremap <silent><expr> <C-pagedown> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<C-pagedown>"
inoremap <silent><expr> <C-pageup> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<C-pageup>"
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
nmap <silent> <leader>jr <Plug>(coc-references)
nmap <silent> <leader>jm <Plug>(coc-implementation)
nmap <silent> <leader><Space>r :<C-u>call CocActionAsync('rename')<CR>
nmap <silent> <leader><Space>a <Plug>(coc-codeaction-line)
vmap <silent> <leader><Space>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>v <Plug>(coc-range-select)
vmap <silent> <leader>v <Plug>(coc-range-select)
nmap <silent> <leader><Tab> <Plug>(coc-format)
vmap <silent> <leader><Tab> <Plug>(coc-format-selected)
nmap <silent> <leader>gj <Plug>(coc-git-nextchunk)
nmap <silent> <leader>gk <Plug>(coc-git-prevchunk)
nmap <silent> <leader>gi <Plug>(coc-git-chunkinfo)
nmap <silent> <leader>gD :CocCommand git.diffCached<CR>
nmap <silent> <leader>gu :<C-u>CocCommand git.chunkUndo<CR>
nmap <silent> <leader>ga :<C-u>CocCommand git.chunkStage<CR>
nmap <silent> <leader>gF :<C-u>CocCommand git.foldUnchanged<CR>
nmap <silent> <leader>go :<C-u>CocCommand git.browserOpen<CR>
nmap <silent> <leader>gs :<C-u>CocList gstatus<cr>
nmap <silent> <leader>gla :<C-u>CocList commits<cr>
nmap <silent> <leader>glc :<C-u>CocList bcommits<cr>
nmap <silent> <leader>gll <Plug>(coc-git-commit)
nmap <silent> <leader><space>so :<C-u>CocCommand snippets.openSnippetFiles<cr>
nmap <silent> <leader><space>se :<C-u>CocCommand snippets.editSnippets<cr>
nmap <silent> <leader>dj <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dk <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>df <Plug>(coc-fix-current)
nmap <silent> <leader>dd :<C-u>CocDiagnostics<cr>
nmap <silent> <leader>d<space> :<C-u>CocList diagnostics<cr>
let g:which_key_map["\<space>"]['s'] = {
      \   'name': 'snippets',
      \   'e': 'edit snippets for current file type',
      \   'o': 'open snippet file'
      \   }
let g:which_key_map['j'] = {
      \   'name': 'jump',
      \   'd': 'definition',
      \   'D': 'declaration',
      \   't': 'type definition',
      \   'r': 'reference',
      \   'm': 'implementation',
      \   }
let g:which_key_map["\<space>"]['r'] = 'rename'
let g:which_key_map["\<space>"]['a'] = 'code action'
let g:which_key_map['v'] = 'range select'
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
"}}}
"{{{coc-project
nnoremap <silent> <leader>fM :<c-u>CocList project<cr>
let g:which_key_map['f']['M'] = 'mru projects'
"}}}
"{{{coc-gitignore
nnoremap <silent> <leader><space>I :<c-u>CocList gitignore<cr>
let g:which_key_map["\<space>"]['I'] = 'gitignore'
"}}}
"}}}
"{{{explorer
function! ToggleExplorer() abort "{{{
  if !has('win32')
    execute 'CocCommand explorer --toggle --width=35 ' . getcwd()
  else
    execute 'NvimTreeToggle'
  endif
endfunction "}}}
function! CloseStartifyExplorer() abort "{{{
  if !has('win32')
    let filetype = 'coc-explorer'
  else
    let filetype = 'NvimTree'
  endif
  if winnr('$') == 1 && &filetype ==# filetype
    if tabpagenr() == 1
      set guicursor=a:ver25-Cursor/lCursor
    endif
    quit
  endif
endfunction "}}}
function! CloseExplorerStartify() abort "{{{
  quit
  if winnr('$') == 1 && &filetype ==# 'startify'
    if tabpagenr() == 1
      set guicursor=a:ver25-Cursor/lCursor
    endif
    quit
  endif
endfunction "}}}
nnoremap <silent> <C-b> :call ToggleExplorer()<CR>
if !has('win32')
  augroup ExplorerCustom
    autocmd!
    autocmd FileType coc-explorer setlocal signcolumn=no
    autocmd FileType coc-explorer nnoremap <buffer><silent> <Tab> :<C-u>q<CR>:sleep 100m<CR>:Vista!!<CR>
    autocmd FileType coc-explorer nnoremap <buffer><silent> q :<C-u>call CloseExplorerStartify()<CR>
    autocmd BufEnter * call CloseStartifyExplorer()
  augroup END
else
  augroup ExplorerCustom
    autocmd!
    autocmd BufEnter * call CloseStartifyExplorer()
  augroup END
endif
if has('win32')
  let g:nvim_tree_width = 35
  let g:nvim_tree_highlight_opened_files = 1
  let g:nvim_tree_lsp_diagnostics = 1
  let g:nvim_tree_hide_dotfiles = 1
  lua <<EOF
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    vim.g.nvim_tree_bindings = {
      ["q"]              = ":<C-u>call CloseExplorerStartify()<CR>",
      ["<Tab>"]          = ":<C-u>q<CR>:sleep 100m<CR>:Vista!!<CR>",
      ["o"]              = tree_cb("edit"),
      ["<2-LeftMouse>"]  = tree_cb("edit"),
      ["<CR>"]           = tree_cb("cd"),
      ["<2-RightMouse>"] = tree_cb("cd"),
      ["t"]              = tree_cb("tabnew"),
      ["h"]              = tree_cb("parent_node"),
      ["<C-p>"]          = tree_cb("preview"),
      ["."]              = tree_cb("toggle_dotfiles"),
      ["n"]              = tree_cb("create"),
      ["d"]              = tree_cb("remove"),
      ["r"]              = tree_cb("rename"),
      ["x"]              = tree_cb("cut"),
      ["c"]              = tree_cb("copy"),
      ["p"]              = tree_cb("paste"),
      ["gk"]             = tree_cb("prev_git_item"),
      ["gj"]             = tree_cb("next_git_item"),
      ["<BS>"]           = tree_cb("dir_up"),
    }
EOF
endif
"}}}
"{{{vimspector
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
"}}}
"{{{LeaderF
let g:Lf_ShortcutF = '<A-z>`````ff'
let g:Lf_ShortcutB = '<A-z>`````ff'
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
"}}}
"{{{vim-sneak
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
"}}}
"{{{mundo
let g:mundo_right = 1
nnoremap <silent> <leader><space>u :<c-u>MundoToggle<cr>
let g:which_key_map["\<space>"]['u'] = 'undo'
"}}}
"{{{vim-fugitive
"{{{twiggy
command Gbranch Twiggy
nnoremap <silent> <leader>gB :<C-u>Twiggy<CR>
let g:which_key_map['g']['B'] = 'branch'
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_num_columns = 35
let g:twiggy_close_on_fugitive_command = 1
let g:twiggy_remote_branch_sort = 'date'
let g:twiggy_show_full_ui = 0
"}}}
"{{{committia.vim
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
  " Additional settings
  setlocal spell

  " If no commit message, start with insert mode
  if a:info.vcs ==# 'git' && getline(1) ==# ''
    startinsert
  endif

  " Scroll the diff window from insert mode
  imap <buffer><PageDown> <Plug>(committia-scroll-diff-down-half)
  imap <buffer><PageUp> <Plug>(committia-scroll-diff-up-half)
  imap <buffer><S-PageDown> <Plug>(committia-scroll-diff-down-page)
  imap <buffer><S-PageUp> <Plug>(committia-scroll-diff-up-page)
endfunction
"}}}
"{{{mergetool
let g:mergetool_layout = 'br,m'  " `l`, `b`, `r`, `m`
let g:mergetool_prefer_revision = 'local'  " `local`, `base`, `remote`
nmap <leader>gm <plug>(MergetoolToggle)
let g:which_key_map['g']['m'] = 'merge'
"}}}
noremap <silent> <leader>gd :Gdiffsplit<cr>
noremap <silent> <leader>gw :Gwrite<cr>
let g:which_key_map['g']['d'] = 'diff unstaged'
let g:which_key_map['g']['w'] = 'write and stage'
"}}}
"{{{vista.vim
nnoremap <silent> <A-b> :<C-u>Vista!!<CR>
let g:vista_sidebar_position = 'vertical topleft'
let g:vista_sidebar_width = 35
let g:vista_cursor_delay = 100
let g:vista_keep_fzf_colors = 1
let g:vista_fzf_opt = ['--layout=default', '--prompt=➤ ']
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
  autocmd FileType vista,vista_kind nnoremap <buffer><silent> <Tab> :<C-u>q<CR>:sleep 150m<CR>:call ToggleExplorer()<CR>
  autocmd FileType vista,vista_kind nmap <buffer><silent> o <CR>
augroup END
"}}}
"{{{nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
"}}}
"{{{asynctasks
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
"}}}
"{{{vim-visual-multi
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Switch Mode']                 = 'v'
let g:VM_maps['Add Cursor At Pos']           = '`'
let g:VM_maps['Visual Cursors']              = '`'
"}}}
"{{{suda.vim
command! -nargs=1 E  edit  suda://<args>
command W w suda://%
"}}}
"{{{inline_edit.vim
nnoremap <silent> <leader><space>e :<C-u>InlineEdit<CR>
vnoremap <silent> <leader><space>e :InlineEdit<CR>
let g:which_key_map["\<space>"]['e'] = 'inline edit'
"}}}
"{{{comfortable-motion.vim
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
nnoremap <silent> <pagedown> :<C-u>call comfortable_motion#flick(130)<CR>
nnoremap <silent> <pageup> :<C-u>call comfortable_motion#flick(-130)<CR>
"}}}
"{{{auto-pairs
let g:AutoPairsShortcutToggle = '<A-z>p'
let g:AutoPairsShortcutFastWrap = '<A-z>`sadsfvf'
let g:AutoPairsShortcutJump = '<A-n>'
let g:AutoPairsWildClosedPair = ''
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0
let g:AutoPairsMapCh = 0
inoremap <A-z>' '
inoremap <A-z>" "
inoremap <A-z>` `
inoremap <A-z>( (
inoremap <A-z>[ [
inoremap <A-z>{ {
inoremap <A-z>) )
inoremap <A-z>] ]
inoremap <A-z>} }
inoremap <A-Backspace> <Space><Esc><left>"_xa<Backspace>
"}}}
"{{{pomodoro.vim
let g:Pomodoro_Status = 0
function! Toggle_Pomodoro()
  if g:Pomodoro_Status == 0
    let g:Pomodoro_Status = 1
    execute 'PomodoroStart'
  elseif g:Pomodoro_Status == 1
    let g:Pomodoro_Status = 0
    execute 'PomodoroStop'
  endif
endfunction
let g:pomodoro_time_work = 25
let g:pomodoro_time_slack = 5
nnoremap <silent> <leader><space>P :<c-u>call Toggle_Pomodoro()<cr>
let g:which_key_map["\<space>"]['P'] = 'pomodoro toggle'
"}}}
"{{{vim-matchup
let g:matchup_matchparen_deferred = 1  " highlight surrounding
let g:matchup_matchparen_hi_surround_always = 1  " highlight surrounding
let g:matchup_delim_noskips = 2  " don't recognize anything in comments
"}}}
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
"{{{vim-closetag
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<A-z>>'
" whitelist
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx'
"}}}
"{{{vCoolor.vim
if !has('win32')
  let g:vcoolor_disable_mappings = 1
  let g:vcoolor_lowercase = 1
  let g:vcoolor_custom_picker = 'zenity --title "custom" --color-selection --color '
  nnoremap <silent> <leader><space>cc :<c-u>VCoolor<cr>
  nnoremap <silent> <leader><space>cr :<c-u>VCoolor r<cr>
  nnoremap <silent> <leader><space>cH :<c-u>VCoolor h<cr>
  nnoremap <silent> <leader><space>cR :<c-u>VCoolor ra<cr>
  let g:which_key_map["\<space>"]['c'] = {
        \   'name': 'color picker',
        \   'c': 'insert hex',
        \   'r': 'insert rgb',
        \   'H': 'insert hsl',
        \   'R': 'insert rgba'
        \   }
endif
"}}}
"{{{vim-devicons
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[''] = "\uf15b"
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}
"{{{vim-translator
let g:translator_target_lang = 'zh'
let g:translator_source_lang = 'auto'
let g:translator_default_engines = ['bing', 'youdao']
nmap <leader><Space>t <Plug>TranslateW
vmap <leader><Space>t <Plug>TranslateWV
let g:which_key_map["\<space>"]['t'] = 'translate'
"}}}
"{{{markdown-preview.nvim
let g:mkdp_browser = 'firefox-developer-edition'
let g:mkdp_echo_preview_url = 1
nmap <silent> <leader><space>p <Plug>MarkdownPreviewToggle
let g:which_key_map["\<space>"]['p'] = 'preview markdown'
"}}}
"{{{vim-peekaboo
let g:peekaboo_delay = 500
"}}}
"{{{vim-easy-align
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)
let g:which_key_map['a'] = 'align'
"}}}
"{{{incsearch.vim
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
"}}}
"{{{vim-textobj-user
call textobj#user#plugin('line', {
      \   '-': {
      \     'select-a-function': 'CurrentLineA',
      \     'select-a': 'al',
      \     'select-i-function': 'CurrentLineI',
      \     'select-i': 'il',
      \   },
      \ })
function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  let tail_pos[2] = tail_pos[2] + 1
  return ['v', head_pos, tail_pos]
endfunction
function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
        \ non_blank_char_exists_p
        \ ? ['v', head_pos, tail_pos]
        \ : 0
endfunction
"}}}
"{{{any-jump.vim
let g:any_jump_disable_default_keybindings = 1
nnoremap gd :AnyJump<CR>
xnoremap gd :AnyJumpVisual<CR>
"}}}
"{{{vim-wordmotion
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
"}}}
" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
