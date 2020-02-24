"{{{Basic
"{{{BasicConfig
if has('nvim')
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
endif
if !filereadable(expand('~/.vim/autoload/plug.vim'))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:vimIsInTmux = 1
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
else
  let g:vimIsInTmux = 0
endif
if exists('g:vimManPager')
  let g:vimEnableStartify = 0
else
  let g:vimEnableStartify = 1
endif
execute 'source '.expand('~/.config/nvim/env.vim')
"}}}
if !has('win32')
  let g:startify_bookmarks = [
        \ {'R': '~/repo/'},
        \ {'r': '~/repo/notes'},
        \ {'r': '~/repo/dotfiles'},
        \ {'r': '~/repo/scripts'},
        \ {'P': '~/playground/'},
        \ {'c': '~/.config/nvim/init.vim'},
        \ {'c': '~/.zshrc'},
        \ {'c': '~/.tmux.conf'}
        \ ]
else
  let g:startify_bookmarks = [
        \ {'R': '~/repo/'},
        \ {'P': '~/playground/'},
        \ {'c': '~/AppData/Local/nvim/init.vim'},
        \ {'c': '~/Documents/WindowsPowerShell/Profile.ps1'}
        \ ]
endif
"}}}
"{{{Global
"{{{Function
"{{{CloseOnLastTab
function! CloseOnLastTab()
  if tabpagenr('$') == 1
    execute 'windo bd'
    execute 'q'
  elseif tabpagenr('$') > 1
    execute 'windo bd'
  endif
endfunction
"}}}
"{{{HumanSize
fun! HumanSize(bytes) abort
  let l:bytes = a:bytes
  let l:sizes = ['B', 'KiB', 'MiB', 'GiB']
  let l:i = 0
  while l:bytes >= 1024
    let l:bytes = l:bytes / 1024.0
    let l:i += 1
  endwhile
  return printf('%.1f%s', l:bytes, l:sizes[l:i])
endfun
"}}}
"{{{ForceCloseRecursively
function! ForceCloseRecursively()
  let Loop_Var = 0
  while Loop_Var < 100
    execute 'q!'
    Loop_Var = s:Loop_Var + 1
  endwhile
endfunction
"}}}
"{{{s:go_indent
" gi, gI跳转indent
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction
function! s:go_indent(times, dir)
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
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gI :<c-u>call <SID>go_indent(v:count1, -1)<cr>
"}}}
"{{{SynStack
function! SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"}}}
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
set mouse=a
filetype plugin indent on
set t_Co=256
syntax enable                           " 开启语法支持
set termguicolors                       " 开启GUI颜色支持
set smartindent                         " 智能缩进
set hlsearch                            " 高亮搜索
set undofile                            " 始终保留undo文件
set undodir=$HOME/.cache/vim/undo       " 设置undo文件的目录
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

set updatetime=100
if has('nvim')
  set inccommand=split
  set wildoptions=pum
  filetype plugin indent on
  " set pumblend=15
endif
augroup vimSettings
  autocmd!
  autocmd FileType html,css,scss,typescript set shiftwidth=2
augroup END
" "{{{
" if exists('g:loaded_sensible') || &compatible
"         finish
" else
"         let g:loaded_sensible = 'yes'
" endif
"
" " Use :help 'option' to see the documentation for the given option.
"
" set backspace=indent,eol,start
"
" set nrformats-=octal
"
" set incsearch
" set laststatus=2
" set ruler
"
" if &listchars ==# 'eol:$'
"         set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" endif
"
" if v:version > 703 || v:version == 703 && has('patch541')
"         set formatoptions+=j " Delete comment character when joining commented lines
" endif
"
" if has('path_extra')
"         setglobal tags-=./tags tags-=./tags; tags^=./tags;
" endif
"
" if &history < 1000
"         set history=1000
" endif
" if &tabpagemax < 50
"         set tabpagemax=50
" endif
" if !empty(&viminfo)
"         set viminfo^=!
" endif
" set sessionoptions-=options
"
" " Allow color schemes to do bright colors without forcing bold.
" if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
"         set t_Co=16
" endif
"
" " Load matchit.vim, but only if the user hasn't installed a newer version.
" if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &runtimepath) ==# ''
"         runtime! macros/matchit.vim
" endif
" "}}}
"}}}
"{{{Mapping
"{{{VIM-Compatible
" sed -n l
" https://stackoverflow.com/questions/5379837/is-it-possible-to-mapping-alt-hjkl-in-insert-mode
" https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
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
nnoremap <silent> q :q<CR>
" Q 绑定到:q!
nnoremap <silent> Q :q!<CR>
" <leader>q 关闭 quickfix list
nnoremap <silent> <leader>q :cclose<CR>
" Ctrl+S保存文件
nnoremap <C-S> :<C-u>w<CR>
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
nnoremap <silent> <A-w> :<C-u>call CloseOnLastTab()<CR>
" Alt+上下左右可以跳转和移动窗口
if !has('win32')
  nnoremap <A-left> <Esc>gT
  nnoremap <A-right> <Esc>gt
  nnoremap <silent> <A-up> :<C-u>tabm -1<CR>
  nnoremap <silent> <A-down> :<C-u>tabm +1<CR>
else
  nnoremap <C-left> <Esc>gT
  nnoremap <C-right> <Esc>gt
  nnoremap <silent> <C-up> :<C-u>tabm -1<CR>
  nnoremap <silent> <C-down> :<C-u>tabm +1<CR>
endif
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
inoremap <C-S> <Esc>:w<CR>a
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
if !has('win32')
  inoremap <silent> <A-left> <Esc>:wincmd h<CR>i
  inoremap <silent> <A-right> <Esc>:wincmd l<CR>i
  inoremap <silent> <A-up> <Esc>:tabm -1<CR>i
  inoremap <silent> <A-down> <Esc>:tabm +1<CR>i
else
  inoremap <silent> <C-left> <Esc>:wincmd h<CR>i
  inoremap <silent> <C-right> <Esc>:wincmd l<CR>i
  inoremap <silent> <C-up> <Esc>:tabm -1<CR>i
  inoremap <silent> <C-down> <Esc>:tabm +1<CR>i
endif
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
vnoremap <C-S> :<C-u>w<CR>v
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
vnoremap L $
" <leader>+Y复制到系统剪切板
vnoremap <leader>y "+y
" <leader>+P从系统剪切板粘贴
vnoremap <leader>p "+p
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
"{{{Command
" Q强制退出
command Q q!
" {{{PasteBin
function PasteBin() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| proxychains -q pastebinit | xclip -selection clipboard && xclip -o -selection clipboard')
endfunction
com -range=% -nargs=0 PasteBin :<line1>,<line2>call PasteBin()
" }}}
"}}}
"}}}
"{{{Plugin
"{{{vim-plug-usage
" 安装插件：
" :PlugInstall
" 更新插件：
" :PlugUpdate
" 更新vim-plug自身：
" :PlugUpgrade
" 清理插件：
" :PlugClean[!]
" 查看插件状态：
" :PlugStatus
" 查看插件更新后的更改：
" :PlugDiff
" 为当前插件生成快照：
" :PlugSnapshot[!] [output path]
" 立即加载插件：
" :call plug#load(name_list)
"
" 在vim-plug窗口的键位绑定：
" `D` - `PlugDiff`
" `S` - `PlugStatus`
" `R` - Retry failed update or installation tasks
" `U` - Update plugins in the selected range
" `q` - Close the window
" `:PlugStatus`
" - `L` - Load plugin
" `:PlugDiff`
" - `X` - Revert the update
" `o` - Preview window
" `H` - Help Docs
" `<Tab>` - Open GitHub URL in browser
" J \ K - scroll the preview window
" CTRL-N / CTRL-P - move between the commits
" CTRL-J / CTRL-K - move between the commits and synchronize the preview window
"
" on command load example:
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
"
" on filetype load example:
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
"
" on both conditions example:
" Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }
"
" Load manually:
" Plug 'SirVer/ultisnips', { 'on': [] }
" Plug 'Valloric/YouCompleteMe', { 'on': [] }
" augroup load_us_ycm
"   autocmd!
"   autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
"                      \| autocmd! load_us_ycm
" augroup END
"
" more info     :h plug-options
"}}}
"{{{init
function Help_vim_plug() abort
  echo ''
  echo 'D     show diff'
  echo 'S     plugin status'
  echo 'R     retry'
  echo 'U     update plugins in the selected range'
  echo 'q     close window'
  echo ':PlugStatus L load plugin'
  echo ':PlugDiff X revert the update'
  echo '<tab> open github url'
  echo 'p     open preview window'
  echo 'h     show help docs'
  echo 'J/K   scroll preview window'
  echo 'C-J/C-K move between commits'
endfunction

augroup vimPlugMappings
  autocmd!
  autocmd FileType vim-plug nnoremap <buffer> ? :call Help_vim_plug()<CR>
  autocmd FileType vim-plug nmap <buffer> p <plug>(plug-preview)
  autocmd FileType vim-plug nnoremap <buffer> <silent> h :call <sid>plug_doc()<cr>
  autocmd FileType vim-plug nnoremap <buffer> <silent> <Tab> :call <sid>plug_gx()<cr>
augroup END

" automatically install missing plugins on startup
if g:vimAutoInstall == 1
  augroup vim_plug_auto_install
    autocmd!
    autocmd VimEnter *
          \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
          \|   PlugInstall --sync | q
          \| endif
  augroup END
endif

function! s:plug_doc()
  let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
  if has_key(g:plugs, name)
    for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
      execute 'tabe' doc
    endfor
  endif
endfunction

function! s:plug_gx()
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
endfunction
augroup PlugGx
  autocmd!
augroup END

function! s:scroll_preview(down)
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-e>" : "\<c-y>"
    wincmd p
  endif
endfunction
function! s:setup_extra_keys()
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o
endfunction
augroup PlugDiffExtra
  autocmd!
  autocmd FileType vim-plug call s:setup_extra_keys()
augroup END

command PU PlugUpdate | PlugUpgrade | CocUpdate

call plug#begin('~/.local/share/nvim/plugins')
if !has('nvim') && has('python3')
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'tpope/vim-repeat'
Plug 'ryanoasis/vim-devicons'
"}}}
"{{{syntax
Plug 'sheerun/vim-polyglot', { 'as': 'vim-syntax' }
Plug 'bfrg/vim-cpp-modern', { 'as': 'vim-syntax-c-cpp', 'for': [ 'c', 'cpp' ] }
Plug 'maxmellon/vim-jsx-pretty', { 'as': 'vim-syntax-jsx', 'for': [ 'javascriptreact' ] }
let g:polyglot_disabled = [ 'c', 'cpp', 'markdown', 'javascriptreact' ]
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
"}}}
" User Interface
"{{{themes
Plug 'gruvbox-material/vim', { 'as': 'gruvbox-material' }
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/vim-color-forest-night'
"}}}
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'macthecadillac/lightline-gitdiff'
Plug 'maximbaz/lightline-ale'
Plug 'albertomontesg/lightline-asyncrun'
Plug 'rmolin88/pomodoro.vim'
if g:vimIsInTmux == 1
  Plug 'sainnhe/tmuxline.vim', { 'on': [ 'Tmuxline', 'TmuxlineSnapshot' ] }
endif
if g:vimEnableStartify == 1
  Plug 'mhinz/vim-startify'
endif
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'liuchengxu/vim-which-key'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/limelight.vim', { 'on': 'Limelight!!' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'roman/golden-ratio'
Plug 'sainnhe/artify.vim'

" Productivity
Plug 'Shougo/neoinclude.vim' | Plug 'jsfaint/coc-neoinclude'
Plug 'wellle/tmux-complete.vim', { 'for': 'tmux' }
Plug 'tjdevries/coc-zsh'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dense-analysis/ale'
if !has('win32')
  Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
else
  Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
endif
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'rhysd/committia.vim'
Plug 'cohama/agit.vim'
Plug 'samoshkin/vim-mergetool'
Plug 'APZelos/blamer.nvim'
Plug 'majutsushi/tagbar', { 'on': [] }
if executable('proxychains')
  Plug 'vim-php/tagbar-phpctags.vim', { 'on': [], 'do': 'proxychains -q make' }
else
  Plug 'vim-php/tagbar-phpctags.vim', { 'on': [], 'do': 'make' }
endif
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/vim-terminal-help'
Plug 'mg979/vim-visual-multi'
Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/inline_edit.vim'
Plug 'airblade/vim-rooter'
Plug 'voldikss/vim-translate-me'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mbbill/fencview', { 'on': [ 'FencAutoDetect', 'FencView' ] }
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'andymass/vim-matchup'
Plug 'lambdalisue/vim-manpager'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-sleuth'
if executable('fcitx')
  Plug 'lilydjwg/fcitx.vim', { 'on': [] }
        \| au InsertEnter * call plug#load('fcitx.vim')
endif
Plug 'alvan/vim-closetag'
Plug 'elzr/vim-json', { 'for': 'json' }
      \| au BufNewFile,BufRead *.json call Func_vim_json()
Plug 'masukomi/vim-markdown-folding'
Plug 'KabbAmine/vCoolor.vim'
Plug 'yianwillis/vimcdoc'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install' }
"{{{
call plug#end()
"}}}
"}}}
" User Interface
"{{{lightline.vim
"{{{lightline.vim-usage
" :h 'statusline'
" :h g:lightline.component
"}}}
"{{{functions
function! PomodoroStatus() abort"{{{
  if pomo#remaining_time() ==# '0'
    return "\ue001"
  else
    return "\ue003 ".pomo#remaining_time()
  endif
endfunction"}}}
function! CocCurrentFunction()"{{{
  return get(b:, 'coc_current_function', '')
endfunction"}}}
function! Devicons_Filetype()"{{{
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction"}}}
function! Devicons_Fileformat()"{{{
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction"}}}
function! Artify_active_tab_num(n) abort"{{{
  return Artify(a:n, 'bold')." \ue0bb"
endfunction"}}}
function! Tab_num(n) abort"{{{
  return a:n." \ue0bb"
endfunction"}}}
function! Gitbranch() abort"{{{
  if gitbranch#name() !=# ''
    return gitbranch#name()." \ue725"
  else
    return "\ue61b"
  endif
endfunction"}}}
function! Artify_inactive_tab_num(n) abort"{{{
  return Artify(a:n, 'double_struck')." \ue0bb"
endfunction"}}}
function! Artify_lightline_tab_filename(s) abort"{{{
  return Artify(lightline#tab#filename(a:s), 'monospace')
endfunction"}}}
function! Artify_lightline_mode() abort"{{{
  return Artify(lightline#mode(), 'monospace')
endfunction"}}}
function! Artify_line_percent() abort"{{{
  return Artify(string((100*line('.'))/line('$')), 'bold')
endfunction"}}}
function! Artify_line_num() abort"{{{
  return Artify(string(line('.')), 'bold')
endfunction"}}}
function! Artify_col_num() abort"{{{
  return Artify(string(getcurpos()[2]), 'bold')
endfunction"}}}
function! Artify_gitbranch() abort"{{{
  if gitbranch#name() !=# ''
    return Artify(gitbranch#name(), 'monospace')." \ue725"
  else
    return "\ue61b"
  endif
endfunction"}}}
"}}}
set laststatus=2  " Basic
set noshowmode  " Disable show mode info
augroup lightlineCustom
  autocmd!
  autocmd BufWritePost * call lightline_gitdiff#query_git() | call lightline#update()
augroup END
let g:lightline = {}
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf529"
let g:lightline#ale#indicator_errors = "\uf00d"
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline_gitdiff#indicator_added = '+'
let g:lightline_gitdiff#indicator_deleted = '-'
let g:lightline_gitdiff#indicator_modified = '*'
let g:lightline_gitdiff#min_winwidth = '70'
let g:lightline#asyncrun#indicator_none = ''
let g:lightline#asyncrun#indicator_run = 'Running...'
if g:lightlineArtify == 1
  let g:lightline.active = {
        \ 'left': [ [ 'artify_mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'artify_lineinfo' ],
        \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'artify_lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'artify_gitbranch' ],
        \ [ 'gitstatus' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'artify_activetabnum', 'artify_filename', 'modified' ],
        \ 'inactive': [ 'artify_inactivetabnum', 'filename', 'modified' ] }
else
  let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'gitbranch' ],
        \ [ 'gitstatus' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'tabnum', 'filename', 'modified' ],
        \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
endif
let g:lightline.tab_component = {
      \ }
let g:lightline.tab_component_function = {
      \ 'artify_activetabnum': 'Artify_active_tab_num',
      \ 'artify_inactivetabnum': 'Artify_inactive_tab_num',
      \ 'artify_filename': 'Artify_lightline_tab_filename',
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'Tab_num'
      \ }
let g:lightline.component = {
      \ 'artify_gitbranch' : '%{Artify_gitbranch()}',
      \ 'artify_mode': '%{Artify_lightline_mode()}',
      \ 'artify_lineinfo': "%2{Artify_line_percent()}\uf295 %3{Artify_line_num()}:%-2{Artify_col_num()}",
      \ 'gitstatus' : '%{lightline_gitdiff#get_status()}',
      \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
      \ 'vim_logo': "\ue7c5",
      \ 'pomodoro': '%{PomodoroStatus()}',
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'filename': '%t',
      \ 'filesize': "%{HumanSize(line2byte('$') + len(getline('$')))}",
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
      \ 'gitbranch': 'Gitbranch',
      \ 'devicons_filetype': 'Devicons_Filetype',
      \ 'devicons_fileformat': 'Devicons_Fileformat',
      \ 'coc_status': 'coc#status',
      \ 'coc_currentfunction': 'CocCurrentFunction'
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ 'asyncrun_status': 'lightline#asyncrun#status'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
let g:lightline.component_visible_condition = {
      \ 'gitstatus': 'lightline_gitdiff#get_status() !=# ""'
      \ }
"}}}
"{{{tmuxline.vim
if g:vimIsInTmux == 1
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '%R',
        \'c'    : [ '#{sysstat_mem} #[fg=blue]\ufa51#{upload_speed}' ],
        \'win'  : [ '#I', '#W' ],
        \'cwin' : [ '#I', '#W', '#F' ],
        \'x'    : [ "#[fg=blue]#{download_speed} \uf6d9 #{sysstat_cpu}" ],
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
let g:colorSchemeList = {}
let g:colorSchemeList['Forest Night'] = [
      \   'set background=dark',
      \   'let g:forest_night_enable_italic = 1',
      \   'let g:forest_night_disable_italic_comment = 1',
      \   'colorscheme forest-night',
      \   'call SwitchLightlineColorScheme("vim-color-forest-night", "forest_night")'
      \   ]
let g:colorSchemeList['Gruvbox Material Dark'] = [
      \   'set background=dark',
      \   "let g:gruvbox_material_background = 'medium'",
      \   "let g:gruvbox_material_visual = 'grey background'",
      \   'let g:gruvbox_material_enable_italic = 1',
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox-material", "gruvbox_material")'
      \   ]
let g:colorSchemeList['Gruvbox Material Light'] = [
      \   'set background=light',
      \   "let g:gruvbox_material_background = 'soft'",
      \   "let g:gruvbox_material_visual = 'green background'",
      \   'let g:gruvbox_material_enable_italic = 1',
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox-material", "gruvbox_material")'
      \   ]
let g:colorSchemeList['Edge Dark'] = [
      \   'set background=dark',
      \   'let g:edge_disable_italic_comment = 1',
      \   'let g:edge_enable_italic = 1',
      \   'colorscheme edge',
      \   'call SwitchLightlineColorScheme("edge", "edge")'
      \   ]
let g:colorSchemeList['Edge Light'] = [
      \   'set background=light',
      \   'let g:edge_disable_italic_comment = 1',
      \   'let g:edge_enable_italic = 1',
      \   'colorscheme edge',
      \   'call SwitchLightlineColorScheme("edge", "edge")'
      \   ]
let g:colorSchemeList['Sonokai Shusia'] = [
      \   "let g:sonokai_style = 'shusia'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai", "sonokai")'
      \   ]
let g:colorSchemeList['Sonokai Andromeda'] = [
      \   "let g:sonokai_style = 'andromeda'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai", "sonokai")'
      \   ]
let g:colorSchemeList['Sonokai Atlantis'] = [
      \   "let g:sonokai_style = 'atlantis'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai", "sonokai")'
      \   ]
let g:colorSchemeList['Sonokai Maia'] = [
      \   "let g:sonokai_style = 'maia'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai", "sonokai")'
      \   ]
"{{{Functions
function SwitchLightlineColorScheme(plugName, lightlineName) abort
  let l:exe = ['source ', g:plugs[a:plugName]['dir'], 'autoload/lightline/colorscheme/', a:lightlineName, '.vim']
  execute join(l:exe, '')
  let g:lightline.colorscheme = a:lightlineName
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
function SwitchColorScheme(name) abort
  for l:item in g:colorSchemeList[a:name]
    execute l:item
  endfor
endfunction
function! s:Colo(a, l, p)
  return keys(g:colorSchemeList)
endfunction
command! -bar -nargs=? -complete=customlist,<sid>Colo Colo call SwitchColorScheme(<f-args>)
call SwitchColorScheme(g:vimColorScheme)
"}}}
"}}}
"{{{vim-startify
if g:vimEnableStartify == 1
  let g:startify_session_dir = '~/.vim/sessions'
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
    execute 'call ToggleCocExplorer()'
  endfunction
  function! s:startify_mappings() abort
    nmap <silent><buffer> o <CR>
    nmap <silent><buffer> h :wincmd h<CR>
    nmap <silent><buffer> <Tab> :CocList project<CR>
  endfunction
  augroup startifyCustom
    autocmd!
    autocmd VimEnter *
          \   if !argc()
          \ |   call ExplorerStartify()
          \ | endif
    autocmd FileType startify call s:startify_mappings()
    " on Enter
    autocmd User Startified nmap <silent><buffer> <CR> <plug>(startify-open-buffers):call ToggleCocExplorer()<CR>
  augroup END
endif
"}}}
"{{{vim-which-key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
call which_key#register('<Space>', 'g:which_key_map')
let g:which_key_map = {
      \   'name': 'main',
      \   '%': 'select current surrounding',
      \   '<Tab>': 'format',
      \   'p': 'paste',
      \   'q': 'close quickfix',
      \   'y': 'yank',
      \   't': 'translate',
      \   'c': { 'name': 'comment' }
      \   }
let g:which_key_map["\<space>"] = {
      \   'name': 'menu'
      \   }
let g:which_key_map["\<space>"]['h'] = {
      \   'name': 'help',
      \   'v': 'visual multi',
      \   's': 'sneak',
      \   'f': 'neoformat',
      \   'p': 'autopairs',
      \   'c': 'nerd commenter',
      \   't': 'close tag',
      \   'S': 'signify',
      \   'r': 'surround',
      \   'm': 'matchup',
      \   'i': 'markdown inline edit'
      \   }
nnoremap <silent> <leader><space>hv :<c-u>call Help_vim_visual_multi()<cr>
nnoremap <silent> <leader><space>hs :<c-u>call Help_vim_sneak()<cr>
nnoremap <silent> <leader><space>hf :<c-u>call Help_neoformat()<cr>
nnoremap <silent> <leader><space>hp :<c-u>call Help_auto_pairs()<cr>
nnoremap <silent> <leader><space>hc :<c-u>call Help_nerdcommenter()<cr>
nnoremap <silent> <leader><space>ht :<c-u>call Help_vim_closetag()<cr>
nnoremap <silent> <leader><space>hr :<c-u>call Help_vim_surround()<cr>
nnoremap <silent> <leader><space>hm :<c-u>call Help_vim_matchup()<cr>
nnoremap <silent> <leader><space>hi :<c-u>call Help_inline_edit()<cr>
"}}}
"{{{vim-hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']  " ['virtual', 'sign_column', 'background', 'foreground', 'foregroundfull']
let g:Hexokinase_ftAutoload = ['html', 'css', 'javascript', 'vim', 'colortemplate', 'json', 'yaml', 'toml']  " ['*']
let g:Hexokinase_refreshEvents = ['BufWritePost']
let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba']  " ['full_hex', 'triple_hex', 'rgb', 'rgba', 'colour_names']
nnoremap <silent> <leader><space>H :<c-u>HexokinaseToggle<cr>
let g:which_key_map["\<space>"]['H'] = 'live color'
"}}}
"{{{indentLine
"{{{indentLine-usage
" :LeadingSpaceToggle  切换显示Leading Space
" :IndentLinesToggle  切换显示indentLine
"}}}
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_char = ''  " ¦┆│⎸▏
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = [ 'startify', 'coc-explorer', 'codi', 'help', 'man', 'vtm', 'markdown' ]
let g:indentLine_setColors = 0  " disable overwrite with grey by default, use colorscheme instead
"}}}
"{{{limelight.vim
let g:limelight_default_coefficient = 0.7
"}}}
"{{{goyo.vim
"{{{goyo.vim-usage
" <leader>mr  toggle reading mode
"}}}
let g:goyo_width = 95
let g:goyo_height = 85
let g:goyo_linenr = 0
"进入goyo模式后自动触发limelight,退出后则关闭
augroup goyoCustom
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END
nnoremap <silent> <leader><space>f :<C-u>Limelight!!<CR>
nnoremap <silent> <leader><space>r :<C-u>Goyo<CR>
let g:which_key_map["\<space>"]['f'] = 'focus mode'
let g:which_key_map["\<space>"]['r'] = 'reading mode'
"}}}
"{{{golden-ratio
" 默认关闭
let g:golden_ratio_autocommand = 0
nnoremap <silent> <leader><space>g :<c-u>GoldenRatioResize<cr>
let g:which_key_map["\<space>"]['g'] = 'resize window'
"}}}
" Productivity
"{{{coc.nvim
"{{{coc-functions
function! CocHighlight() abort"{{{
  if &filetype !=# 'markdown'
    call CocActionAsync('highlight')
  endif
endfunction"}}}
function! CocFloatingLockToggle() abort"{{{
  if g:CocFloatingLock == 0
    let g:CocFloatingLock = 1
  elseif g:CocFloatingLock == 1
    let g:CocFloatingLock = 0
  endif
endfunction"}}}
function! CocHover() abort"{{{
  if !coc#util#has_float() && g:CocHoverEnable == 1
    call CocActionAsync('doHover')
    call CocActionAsync('showSignatureHelp')
  endif
endfunction"}}}
function! CocToggleFold() abort"{{{
  if &foldmethod ==# 'marker'
    execute 'CocCommand git.foldUnchanged'
  else
    set foldmethod=marker
  endif
endfunction"}}}
"}}}
"{{{coc-init
let g:coc_global_extensions = [
      \   'coc-lists',
      \   'coc-marketplace',
      \   'coc-git',
      \   'coc-explorer',
      \   'coc-project',
      \   'coc-gitignore',
      \   'coc-bookmark',
      \   'coc-todolist',
      \   'coc-highlight',
      \   'coc-yank',
      \   'coc-snippets',
      \   'coc-syntax',
      \   'coc-tag',
      \   'coc-emoji',
      \   'coc-dictionary',
      \   'coc-html',
      \   'coc-css',
      \   'coc-emmet',
      \   'coc-tsserver',
      \   'coc-tslint-plugin',
      \   'coc-python',
      \   'coc-rls',
      \   'coc-powershell',
      \   'coc-json',
      \   'coc-yaml',
      \   'coc-vimlsp'
      \   ]
"}}}
"{{{coc-settings
augroup cocCustom
  autocmd!
  autocmd CursorHold * silent call CocHover()
  autocmd CursorHold * silent call CocHighlight()
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd InsertEnter * call coc#util#float_hide()
augroup END
hi link BookMarkHI GitGutterAdd
let g:CocHoverEnable = 0
let g:tmuxcomplete#trigger = ''
set hidden
set completeopt=noinsert,noselect,menuone
set dictionary+=/usr/share/dict/words
set dictionary+=/usr/share/dict/american-english
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
imap <expr> <C-z> pumvisible() ? "\<C-e>" : "\<Esc>\u\i"
imap <expr> <C-c> pumvisible() ? "\<Space>\<Backspace>" : "\<C-c>"
imap <expr> <CR> pumvisible() ? "\<Space>\<Backspace>\<CR>" : "\<CR>"
inoremap <expr> <up> pumvisible() ? "\<Space>\<Backspace>\<up>" : "\<up>"
inoremap <expr> <down> pumvisible() ? "\<Space>\<Backspace>\<down>" : "\<down>"
inoremap <expr> <left> pumvisible() ? "\<Space>\<Backspace>\<left>" : "\<left>"
inoremap <expr> <right> pumvisible() ? "\<Space>\<Backspace>\<right>" : "\<right>"
nmap <leader>l<Space> :<C-u>CocList<CR>
nmap <leader>lJ <Plug>(coc-diagnostic-next)
nmap <leader>lK <Plug>(coc-diagnostic-prev)
nmap <leader>lI <Plug>(coc-diagnostic-info)
nmap <leader>ld <Plug>(coc-definition)
nmap <leader>lD <Plug>(coc-declaration)
nmap <leader>lt <Plug>(coc-type-definition)
nmap <leader>lr <Plug>(coc-references)
nmap <leader>lm <Plug>(coc-implementation)
nmap <leader>lR <Plug>(coc-rename)
nmap <leader>lf <Plug>(coc-format)
vmap <leader>lf <Plug>(coc-format-selected)
nmap <leader>lF <Plug>(coc-fix-current)
nmap <leader>la <Plug>(coc-codeaction)
vmap <leader>la <Plug>(coc-codeaction-selected)
nmap <leader>lA <Plug>(coc-codelens-action)
nmap <leader>le <Plug>(coc-refactor)
nmap <leader>lv <Plug>(coc-range-select)
vmap <leader>lv <Plug>(coc-range-select)
nmap <leader>gj <Plug>(coc-git-nextchunk)
nmap <leader>gk <Plug>(coc-git-prevchunk)
nmap <leader>gi <Plug>(coc-git-chunkinfo)
nmap <leader>gM <Plug>(coc-git-commit)
nmap <silent> <leader>gD :CocCommand git.diffCached<CR>
nmap <silent> <leader>gu :<C-u>CocCommand git.chunkUndo<CR>
nmap <silent> <leader>ga :<C-u>CocCommand git.chunkStage<CR>
nmap <silent> <leader>gF :<C-u>call CocToggleFold()<CR>
nmap <silent> <leader>go :<C-u>CocCommand git.browserOpen<CR>
nmap <silent> <leader>gs :<C-u>CocList gstatus<cr>
nmap <silent> <leader>glC :<C-u>CocList bcommits<cr>
nmap <silent> <leader>glA :<C-u>CocList commits<cr>
nmap <silent> <leader><space>so :<C-u>CocCommand snippets.openSnippetFiles<cr>
nmap <silent> <leader><space>se :<C-u>CocCommand snippets.editSnippets<cr>
let g:which_key_map["\<space>"]['s'] = {
      \   'name': 'snippets',
      \   'e': 'edit snippets for current file type',
      \   'o': 'open snippet file'
      \   }
let g:which_key_map['l'] = {
      \   'name': 'language server',
      \   "\<Space>": 'list',
      \   'j': 'diagnostic next(ALE)',
      \   'k': 'diagnostic prev(ALE)',
      \   'i': 'diagnostic info(ALE)',
      \   'J': 'diagnostic next(LSP)',
      \   'K': 'diagnostic prev(LSP)',
      \   'I': 'diagnostic info(LSP)',
      \   'd': 'jump to definition',
      \   'D': 'jump to declaration',
      \   't': 'jump to type definition',
      \   'r': 'jump to reference',
      \   'm': 'jump to implementation',
      \   'R': 'rename symbol',
      \   'f': 'format',
      \   'F': 'fix code',
      \   'a': 'code action',
      \   'A': 'codelens action',
      \   'e': 'open refactor window',
      \   'v': 'range select',
      \   }
let g:which_key_map['g'] = {
      \   'name': 'git',
      \   'j': 'chunk next',
      \   'k': 'chunk prev',
      \   'D': 'diff staged',
      \   'i': 'chunk info',
      \   'u': 'chunk undo',
      \   'a': 'chunk stage',
      \   's': 'status',
      \   'l': {'name': 'logs', 'C': 'log(cur buf) fuzzy finder', 'A': 'log(all): fuzzy finder'},
      \   'M': 'commits of current chunk',
      \   'F': 'toggle fold unchanged',
      \   'o': 'open remote url in the browser',
      \   }
nnoremap <silent> ? :let g:CocHoverEnable = g:CocHoverEnable == 1 ? 0 : 1<CR>
"}}}
"{{{coc-explorer
function ToggleCocExplorer()
  execute 'CocCommand explorer --toggle --width=35 --sources=buffer+,file+ ' . getcwd()
endfunction
nnoremap <silent> <C-b> :call ToggleCocExplorer()<CR>
augroup explorerCustom
  autocmd!
  autocmd FileType coc-explorer setlocal signcolumn=no
  autocmd BufEnter * if (winnr("$") == 1 && &filetype ==# 'coc-explorer') | q | endif
augroup END
"}}}
"{{{coc-project
nnoremap <silent> <leader><space><Tab> :<c-u>CocList project<cr>
let g:which_key_map["\<space>"]['<Tab>'] = 'project'
"}}}
"{{{coc-project
nnoremap <silent> <leader><space>I :<c-u>CocList gitignore<cr>
let g:which_key_map["\<space>"]['I'] = 'gitignore'
"}}}
"{{{coc-bookmark
nmap <leader>mm <Plug>(coc-bookmark-toggle)
nmap <leader>ma <Plug>(coc-bookmark-annotate)
nmap <leader>mn <Plug>(coc-bookmark-next)
nmap <leader>mp <Plug>(coc-bookmark-prev)
nnoremap <silent> <leader>m<Space> :CocList bookmark<CR>
let g:which_key_map['m'] = {
      \   'name': 'bookmark',
      \   'm': 'toggle',
      \   'a': 'annotate',
      \   'n': 'next',
      \   'p': 'prev',
      \   "\<Space>": 'list',
      \   }
"}}}
"{{{coc-todolist
nnoremap <silent> <leader><space>tn :<c-u>CocCommand todolist.create<cr>
nnoremap <silent> <leader><space>tm :<c-u>CocList todolist<cr>
nnoremap <silent> <leader><space>tc :<c-u>CocCommand todolist.clearRemind<cr>
let g:which_key_map["\<space>"]['t'] = {
      \   'name': 'todo',
      \   'n': 'new item',
      \   'm': 'management',
      \   'c': 'clear remind'
      \   }
"}}}
"}}}
"{{{ale
"{{{ale-usage
let g:ALE_MODE = 1  " 0则只在保存文件时检查，1则只在normal模式下检查，2则异步检查
" 普通模式下<leader>lk和<leader>lj分别跳转到上一个、下一个错误
" :ALEDetail  查看详细错误信息
"}}}
" ls ~/.local/share/nvim/plugins/ale/ale_linters/
let g:ale_linters = {
      \       'asm': ['gcc'],
      \       'c': ['cppcheck', 'flawfinder'],
      \       'cpp': ['cppcheck', 'flawfinder'],
      \       'css': ['stylelint'],
      \       'html': ['tidy'],
      \       'json': [],
      \       'markdown': [''],
      \       'python': ['pylint', 'flake8', 'mypy', 'pydocstyle'],
      \       'rust': ['cargo'],
      \       'sh': ['shellcheck'],
      \       'text': ['languagetool'],
      \       'vim': ['vint'],
      \}
"查看上一个错误
nnoremap <silent> <leader>lk :ALEPrevious<CR>
"查看下一个错误
nnoremap <silent> <leader>lj :ALENext<CR>
"查看详情
nnoremap <silent> <leader>li :ALEDetail<CR>
"自定义error和warning图标
let g:ale_sign_error = "\uf65b"
let g:ale_sign_warning = "\uf421"
"防止java在中文系统上警告和提示乱码
let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en'
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" 光标移动到错误的地方时立即显示错误
let g:ale_echo_delay = 0
" virtual text
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 10
let g:ale_virtualtext_prefix = '▸'
" ale-mode
if g:ALE_MODE == 0
  let g:ale_lint_on_text_changed = 'never'
elseif g:ALE_MODE == 1
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1
elseif g:ALE_MODE == 2
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_lint_delay=100
endif
"}}}
"{{{LeaderF
let g:Lf_ShortcutF = '<A-z>`````ff'
let g:Lf_ShortcutB = '<A-z>`````ff'
let g:Lf_WindowHeight = 0.4
let g:Lf_ShowRelativePath = 0
let g:Lf_CursorBlink = 1
let g:Lf_CacheDirectory = expand('~/.cache/vim/leaderf')
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.vscode']
let g:Lf_ShowHidden = 1
let g:Lf_ReverseOrder = 1
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewHorizontalPosition = 'center'
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
nnoremap <silent> <leader>ff :<C-u>Leaderf file<CR>
nnoremap <silent> <leader>ft :<C-u>LeaderfBufTag<CR>
nnoremap <silent> <leader>fT :<C-u>LeaderfBufTagAll<CR>
nnoremap <silent> <leader>fb :<C-u>LeaderfBuffer<CR>
nnoremap <silent> <leader>fB :<C-u>LeaderfBufferAll<CR>
nnoremap <silent> <leader>ff :<C-u>LeaderfFile<CR>
nnoremap <silent> <leader>fh :<C-u>LeaderfHelp<CR>
nnoremap <silent> <leader>fl :<C-u>LeaderfLine<CR>
nnoremap <silent> <leader>fL :<C-u>LeaderfLineAll<CR>
nnoremap <silent> <leader>fm :<C-u>LeaderfMruCwd<CR>
nnoremap <silent> <leader>fM :<C-u>LeaderfMru<CR>
nnoremap <silent> <leader>fg :<C-u>Leaderf rg --hidden<Space>
nnoremap <silent> <leader>fG :<C-u>Leaderf rg<CR>
let g:which_key_map['f'] = {
      \   'name': 'leaderf',
      \   't': 'tag',
      \   'T': 'tag all',
      \   'b': 'buffer',
      \   'B': 'buffer all',
      \   'f': 'file',
      \   'h': 'help',
      \   'l': 'line',
      \   'L': 'line all',
      \   'm': 'mru cwd',
      \   'M': 'mru all',
      \   'g': 'grep',
      \   'G': 'fuzzy grep'
      \   }
"}}}
"{{{vim-sneak
"{{{vim-sneak-help
function! Help_vim_sneak()
  echo 'Normal Mode & Visual Mode:'
  echo 's[char][char]                 forward search and highlight'
  echo 'S[char][char]                 backward search and highlight'
  echo 's                             forward repeat'
  echo 'S                             backward repeat'
  echo '[count]s[char][char]          vertical search, limit search result in [count] columns'
  echo 'f/F                           one character search'
endfunction
"}}}
let g:sneak#s_next = 1

" 2-character Sneak (default)
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

" 1-character enhanced 'f'
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"}}}
"{{{undotree
let g:undotree_WindowLayout = 3
let g:undotree_SplitWidth = 35
let g:undotree_DiffpanelHeight = 10
nnoremap <silent> <leader><space>u :<c-u>UndotreeToggle<cr>
let g:which_key_map["\<space>"]['u'] = 'undotree'
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
let g:twiggy_git_log_command = 'Agit'
"}}}
"{{{agit
function! Help_agit() abort
  echo '<A-j>         scroll down status window'
  echo '<A-k>         scroll up status window'
  echo '<C-j>         scroll down diff window'
  echo '<C-k>         scroll up diff window'
  echo 'q             quit'
  echo '?             show this help'
endfunction
function! s:vim_agit_mappings() abort
  nmap <silent><buffer> <A-j>         <Plug>(agit-scrolldown-stat)
  nmap <silent><buffer> <A-k>         <Plug>(agit-scrollup-stat)
  nmap <silent><buffer> <C-j>         <Plug>(agit-scrolldown-diff)
  nmap <silent><buffer> <C-k>         <Plug>(agit-scrollup-diff)
  nmap <silent><buffer> q             <PLug>(agit-exit)
  nmap <silent><buffer> ?             :<C-u>call Help_agit()<CR>
endfunction
augroup agitCustom
  autocmd!
  autocmd FileType agit call s:vim_agit_mappings()
  autocmd FileType agit_stat nmap <silent><buffer> q <PLug>(agit-exit)
  autocmd FileType agit_diff nmap <silent><buffer> q <PLug>(agit-exit)
augroup END
let g:agit_no_default_mappings = 1
nnoremap <silent> <leader>gla :<C-u>Agit<CR>
nnoremap <silent> <leader>glc :<C-u>AgitFile<CR>
let g:which_key_map['g']['l']['a'] = 'log(all) browser'
let g:which_key_map['g']['l']['c'] = 'log(cur buf) browser'
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
let g:mergetool_layout = 'mr'  " `l`, `b`, `r`, `m`
let g:mergetool_prefer_revision = 'local'  " `local`, `base`, `remote`
nmap <leader>gmt <plug>(MergetoolToggle)
nnoremap <silent> <leader>gml :<C-u>call MergetoolLayoutCustom()<CR>
let g:which_key_map['g']['m'] = {
      \   'name': 'merge tool',
      \   't': 'toggle',
      \   'l': 'layout'
      \   }
let g:mergetool_layout_custom = 0
function! MergetoolLayoutCustom()
  if g:mergetool_layout_custom == 0
    let g:mergetool_layout_custom = 1
    execute 'MergetoolToggleLayout lbr,m'
  else
    let g:mergetool_layout_custom = 0
    execute 'MergetoolToggleLayout mr'
  endif
endfunction
"}}}
"{{{blamer
let g:blamer_enabled = 0
let g:blamer_delay = 0
let g:blamer_show_in_visual_modes = 1
let g:blamer_prefix = "\ue729 "
let g:blamer_template = '<author>, <author-time> • <summary>'
nmap <silent> <leader>gb :BlamerToggle<CR>
let g:which_key_map['g']['b'] = 'blame'
"}}}
noremap <silent> <leader>gd :Gdiffsplit<cr>
noremap <silent> <leader>gw :Gwrite<cr>
let g:which_key_map['g']['d'] = 'diff unstaged'
let g:which_key_map['g']['w'] = 'write and stage'
"}}}
"{{{tagbar
"{{{Languages
"{{{Ansible
let g:tagbar_type_ansible = {
      \ 'ctagstype' : 'ansible',
      \ 'kinds' : [
      \ 't:tasks'
      \ ],
      \ 'sort' : 0
      \ }
"}}}
"{{{ArmAsm
let g:tagbar_type_armasm = {
      \ 'ctagsbin'  : 'ctags',
      \ 'ctagsargs' : '-f- --format=2 --excmd=pattern --fields=nksSa --extra= --sort=no --language-force=asm',
      \ 'kinds' : [
      \ 'm:macros:0:1',
      \ 't:types:0:1',
      \ 'd:defines:0:1',
      \ 'l:labels:0:1'
      \ ]
      \}
"}}}
"{{{AsciiDoc
let g:tagbar_type_asciidoc = {
      \ 'ctagstype' : 'asciidoc',
      \ 'kinds' : [
      \ 'h:table of contents',
      \ 'a:anchors:1',
      \ 't:titles:1',
      \ 'n:includes:1',
      \ 'i:images:1',
      \ 'I:inline images:1'
      \ ],
      \ 'sort' : 0
      \ }
"}}}
"{{{Bib
let g:tagbar_type_bib = {
      \ 'ctagstype' : 'bib',
      \ 'kinds'     : [
      \ 'a:Articles',
      \ 'b:Books',
      \ 'L:Booklets',
      \ 'c:Conferences',
      \ 'B:Inbook',
      \ 'C:Incollection',
      \ 'P:Inproceedings',
      \ 'm:Manuals',
      \ 'T:Masterstheses',
      \ 'M:Misc',
      \ 't:Phdtheses',
      \ 'p:Proceedings',
      \ 'r:Techreports',
      \ 'u:Unpublished',
      \ ]
      \ }
"}}}
"{{{CoffeeScript
let g:tagbar_type_coffee = {
      \ 'ctagstype' : 'coffee',
      \ 'kinds'     : [
      \ 'c:classes',
      \ 'm:methods',
      \ 'f:functions',
      \ 'v:variables',
      \ 'f:fields',
      \ ]
      \ }
"}}}
"{{{CSS
let g:tagbar_type_css = {
      \ 'ctagstype' : 'Css',
      \ 'kinds'     : [
      \ 'c:classes',
      \ 's:selectors',
      \ 'i:identities'
      \ ]
      \ }
"}}}
"{{{Elixir
let g:tagbar_type_elixir = {
      \ 'ctagstype' : 'elixir',
      \ 'kinds' : [
      \ 'p:protocols',
      \ 'm:modules',
      \ 'e:exceptions',
      \ 'y:types',
      \ 'd:delegates',
      \ 'f:functions',
      \ 'c:callbacks',
      \ 'a:macros',
      \ 't:tests',
      \ 'i:implementations',
      \ 'o:operators',
      \ 'r:records'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 'p' : 'protocol',
      \ 'm' : 'module'
      \ },
      \ 'scope2kind' : {
      \ 'protocol' : 'p',
      \ 'module' : 'm'
      \ },
      \ 'sort' : 0
      \ }
"}}}
"{{{Fountain
let g:tagbar_type_fountain = {
      \ 'ctagstype': 'fountain',
      \ 'kinds': [
      \ 'h:headings',
      \ 's:sections',
      \ ],
      \ 'sort': 0,
      \}
"}}}
"{{{Go
let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }
"}}}
"{{{Groovy
let g:tagbar_type_groovy = {
      \ 'ctagstype' : 'groovy',
      \ 'kinds'     : [
      \ 'p:package:1',
      \ 'c:classes',
      \ 'i:interfaces',
      \ 't:traits',
      \ 'e:enums',
      \ 'm:methods',
      \ 'f:fields:1'
      \ ]
      \ }
"}}}
"{{{Haskell
let g:tagbar_type_haskell = {
      \ 'ctagsbin'  : 'hasktags',
      \ 'ctagsargs' : '-x -c -o-',
      \ 'kinds'     : [
      \  'm:modules:0:1',
      \  'd:data: 0:1',
      \  'd_gadt: data gadt:0:1',
      \  't:type names:0:1',
      \  'nt:new types:0:1',
      \  'c:classes:0:1',
      \  'cons:constructors:1:1',
      \  'c_gadt:constructor gadt:1:1',
      \  'c_a:constructor accessors:1:1',
      \  'ft:function types:1:1',
      \  'fi:function implementations:0:1',
      \  'o:others:0:1'
      \ ],
      \ 'sro'        : '.',
      \ 'kind2scope' : {
      \ 'm' : 'module',
      \ 'c' : 'class',
      \ 'd' : 'data',
      \ 't' : 'type'
      \ },
      \ 'scope2kind' : {
      \ 'module' : 'm',
      \ 'class'  : 'c',
      \ 'data'   : 'd',
      \ 'type'   : 't'
      \ }
      \ }
"}}}
"{{{IDL
let g:tagbar_type_idlang = {
      \ 'ctagstype' : 'IDL',
      \ 'kinds' : [
      \ 'p:Procedures',
      \ 'f:Functions',
      \ 'c:Common Blocks'
      \ ]
      \ }
"}}}
"{{{Julia
let g:tagbar_type_julia = {
      \ 'ctagstype' : 'julia',
      \ 'kinds'     : [
      \ 't:struct', 'f:function', 'm:macro', 'c:const']
      \ }
"}}}
"{{{Makefile
let g:tagbar_type_make = {
      \ 'kinds':[
      \ 'm:macros',
      \ 't:targets'
      \ ]
      \}
"}}}
"{{{Markdown
let g:tagbar_type_markdown = {
      \ 'ctagstype': 'markdown',
      \ 'ctagsbin' : 'markdown2ctags',
      \ 'ctagsargs' : '-f - --sort=yes',
      \ 'kinds' : [
      \ 's:sections',
      \ 'i:images'
      \ ],
      \ 'sro' : '|',
      \ 'kind2scope' : {
      \ 's' : 'section',
      \ },
      \ 'sort': 0,
      \ }
"}}}
"{{{MediaWiki
let g:tagbar_type_mediawiki = {
      \ 'ctagstype' : 'mediawiki',
      \ 'kinds' : [
      \'h:chapters',
      \'s:sections',
      \'u:subsections',
      \'b:subsubsections',
      \]
      \}
"}}}
"{{{NASL
let g:tagbar_type_nasl = {
      \ 'ctagstype' : 'nasl',
      \ 'kinds'     : [
      \ 'f:function',
      \ 'u:public function',
      \ 'r:private function',
      \ 'v:variables',
      \ 'n:namespace',
      \ 'g:globals',
      \ ]
      \ }
"}}}
"{{{ObjectiveC
let g:tagbar_type_objc = {
      \ 'ctagstype' : 'ObjectiveC',
      \ 'kinds'     : [
      \ 'i:interface',
      \ 'I:implementation',
      \ 'p:Protocol',
      \ 'm:Object_method',
      \ 'c:Class_method',
      \ 'v:Global_variable',
      \ 'F:Object field',
      \ 'f:function',
      \ 'p:property',
      \ 't:type_alias',
      \ 's:type_structure',
      \ 'e:enumeration',
      \ 'M:preprocessor_macro',
      \ ],
      \ 'sro'        : ' ',
      \ 'kind2scope' : {
      \ 'i' : 'interface',
      \ 'I' : 'implementation',
      \ 'p' : 'Protocol',
      \ 's' : 'type_structure',
      \ 'e' : 'enumeration'
      \ },
      \ 'scope2kind' : {
      \ 'interface'      : 'i',
      \ 'implementation' : 'I',
      \ 'Protocol'       : 'p',
      \ 'type_structure' : 's',
      \ 'enumeration'    : 'e'
      \ }
      \ }
"}}}
"{{{Perl
let g:tagbar_type_perl = {
      \ 'ctagstype' : 'perl',
      \ 'kinds'     : [
      \ 'p:package:0:0',
      \ 'w:roles:0:0',
      \ 'e:extends:0:0',
      \ 'u:uses:0:0',
      \ 'r:requires:0:0',
      \ 'o:ours:0:0',
      \ 'a:properties:0:0',
      \ 'b:aliases:0:0',
      \ 'h:helpers:0:0',
      \ 's:subroutines:0:0',
      \ 'd:POD:1:0'
      \ ]
      \ }
"}}}
"{{{PHP
let g:tagbar_phpctags_bin='~/.local/share/nvim/plugins/tagbar-phpctags.vim/bin/phpctags'
let g:tagbar_phpctags_memory_limit = '512M'
"}}}
"{{{Puppet
let g:tagbar_type_puppet = {
      \ 'ctagstype': 'puppet',
      \ 'kinds': [
      \'c:class',
      \'s:site',
      \'n:node',
      \'d:definition'
      \]
      \}
"}}}
"{{{R
let g:tagbar_type_r = {
      \ 'ctagstype' : 'r',
      \ 'kinds'     : [
      \ 'f:Functions',
      \ 'g:GlobalVariables',
      \ 'v:FunctionVariables',
      \ ]
      \ }
"}}}
"{{{reStructuredText
let g:tagbar_type_rst = {
      \ 'ctagstype': 'rst',
      \ 'ctagsbin' : 'rst2ctags',
      \ 'ctagsargs' : '-f - --sort=yes',
      \ 'kinds' : [
      \ 's:sections',
      \ 'i:images'
      \ ],
      \ 'sro' : '|',
      \ 'kind2scope' : {
      \ 's' : 'section',
      \ },
      \ 'sort': 0,
      \ }
"}}}
"{{{Ruby
let g:tagbar_type_ruby = {
      \ 'kinds' : [
      \ 'm:modules',
      \ 'c:classes',
      \ 'd:describes',
      \ 'C:contexts',
      \ 'f:methods',
      \ 'F:singleton methods'
      \ ]
      \ }
"}}}
"{{{Rust
let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
      \ 'ctagsbin' : '/path/to/your/universal/ctags',
      \ 'ctagstype' : 'rust',
      \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
      \ ],
      \ 'sro': '::',
      \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
      \ },
      \ }
"}}}
"{{{Scala
let g:tagbar_type_scala = {
      \ 'ctagstype' : 'scala',
      \ 'sro'       : '.',
      \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
      \ ]
      \ }
"}}}
"{{{systemverilog
let g:tagbar_type_systemverilog = {
      \ 'ctagstype': 'systemverilog',
      \ 'kinds' : [
      \'A:assertions',
      \'C:classes',
      \'E:enumerators',
      \'I:interfaces',
      \'K:packages',
      \'M:modports',
      \'P:programs',
      \'Q:prototypes',
      \'R:properties',
      \'S:structs and unions',
      \'T:type declarations',
      \'V:covergroups',
      \'b:blocks',
      \'c:constants',
      \'e:events',
      \'f:functions',
      \'m:modules',
      \'n:net data types',
      \'p:ports',
      \'r:register data types',
      \'t:tasks',
      \],
      \ 'sro': '.',
      \ 'kind2scope' : {
      \ 'K' : 'package',
      \ 'C' : 'class',
      \ 'm' : 'module',
      \ 'P' : 'program',
      \ 'I' : 'interface',
      \ 'M' : 'modport',
      \ 'f' : 'function',
      \ 't' : 'task',
      \},
      \ 'scope2kind' : {
      \ 'package'   : 'K',
      \ 'class'     : 'C',
      \ 'module'    : 'm',
      \ 'program'   : 'P',
      \ 'interface' : 'I',
      \ 'modport'   : 'M',
      \ 'function'  : 'f',
      \ 'task'      : 't',
      \ },
      \}
"}}}
"{{{TypeScript
let g:tagbar_type_typescript = {
      \ 'ctagstype': 'typescript',
      \ 'kinds': [
      \ 'c:classes',
      \ 'n:modules',
      \ 'f:functions',
      \ 'v:variables',
      \ 'v:varlambdas',
      \ 'm:members',
      \ 'i:interfaces',
      \ 'e:enums',
      \ ]
      \ }
"}}}
"{{{VHDL
let g:tagbar_type_vhdl = {
      \ 'ctagstype': 'vhdl',
      \ 'kinds' : [
      \'d:prototypes',
      \'b:package bodies',
      \'e:entities',
      \'a:architectures',
      \'t:types',
      \'p:processes',
      \'f:functions',
      \'r:procedures',
      \'c:constants',
      \'T:subtypes',
      \'r:records',
      \'C:components',
      \'P:packages',
      \'l:locals'
      \]
      \}
"}}}
"{{{WSDL
let g:tagbar_type_xml = {
      \ 'ctagstype' : 'WSDL',
      \ 'kinds'     : [
      \ 'n:namespaces',
      \ 'm:messages',
      \ 'p:portType',
      \ 'o:operations',
      \ 'b:bindings',
      \ 's:service'
      \ ]
      \ }
"}}}
"{{{Xquery
let g:tagbar_type_xquery = {
      \ 'ctagstype' : 'xquery',
      \ 'kinds'     : [
      \ 'f:function',
      \ 'v:variable',
      \ 'm:module',
      \ ]
      \ }
"}}}
"{{{XSD
let g:tagbar_type_xsd = {
      \ 'ctagstype' : 'XSD',
      \ 'kinds'     : [
      \ 'e:elements',
      \ 'c:complexTypes',
      \ 's:simpleTypes'
      \ ]
      \ }
"}}}
"{{{XSLT
let g:tagbar_type_xslt = {
      \ 'ctagstype' : 'xslt',
      \ 'kinds' : [
      \ 'v:variables',
      \ 't:templates'
      \ ]
      \}
"}}}
"}}}
nnoremap <silent><A-b> :<C-u>call ToggleTagbar()<CR>
let g:TagBarLoad = 0
function! ToggleTagbar()
  if g:TagBarLoad == 0
    let g:TagBarLoad = 1
    call TagbarInit()
    execute 'TagbarToggle'
  elseif g:TagBarLoad == 1
    execute 'TagbarToggle'
  endif
endfunction
function! TagbarInit()
  let g:tagbar_sort = 0
  let g:tagbar_width = 35
  let g:tagbar_autoclose = 1
  let g:tagbar_foldlevel = 2
  let g:tagbar_iconchars = ['▶', '◿']
  let g:tagbar_type_css = {
        \ 'ctagstype' : 'Css',
        \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
        \ ]
        \ }
  call plug#load('tagbar', 'tagbar-phpctags.vim')
endfunction
function! s:tagbar_mappings() abort
  nnoremap <silent><buffer> f :<C-u>TagbarToggle<CR>:LeaderfBufTagAll<CR>
endfunction
augroup tagbarCustom
  autocmd!
  autocmd FileType tagbar call s:tagbar_mappings()
augroup END
"}}}
"{{{neoformat
"{{{neoformat-usage
function! Help_neoformat()
  echo '<leader><Tab>         普通模式和可视模式排版'
  echo ''
  echo 'Normal Mode Syntax'
  echo ':<C-u>Neoformat python'
  echo ':<C-u>Neoformat yapf'
  echo ''
  echo 'Visual Mode Syntax'
  echo ':Neoformat! python'
  echo ':Neoformat! yapf'
endfunction
"}}}
"{{{Neoformat_Default_Filetype_Formatter
function! Neoformat_Default_Filetype_Formatter()
  if &filetype ==# 'c'
    execute 'Neoformat astyle'
  elseif &filetype ==# 'cpp'
    execute 'Neoformat astyle'
  else
    execute 'Neoformat'
  endif
endfunction
"}}}
" :h neoformat-supported-filetypes
" format on save
" augroup fmt
" autocmd!
" autocmd BufWritePre * undojoin | Neoformat
" augroup END
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
nnoremap <silent> <leader><Tab> :<C-u>call Neoformat_Default_Filetype_Formatter()<CR>
vnoremap <silent> <leader><Tab> :Neoformat! &ft<CR>
"}}}
"{{{nerdcommenter
"{{{nerdcommenter-usage
" <leader>c?  显示帮助
function! Help_nerdcommenter()
  echo "[count]<Leader>cc                             NERDComComment, Comment out the current [count] line or text selected in visual mode\n"
  echo "[count]<Leader>cu                             NERDComUncommentLine, Uncomments the selected line(s)\n"
  echo "[count]<Leader>cn                             NERDComNestedComment, Same as <Leader>cc but forces nesting\n"
  echo "[count]<Leader>c<space>                       NERDComToggleComment, Toggles the comment state of the selected line(s). If the topmost selected, line is commented, all selected lines are uncommented and vice versa.\n"
  echo "[count]<Leader>cm                             NERDComMinimalComment, Comments the given lines using only one set of multipart delimiters\n"
  echo "[count]<Leader>ci                             NERDComInvertComment, Toggles the comment state of the selected line(s) individually\n"
  echo "[count]<Leader>cs                             NERDComSexyComment, Comments out the selected lines sexily'\n"
  echo "[count]<Leader>cy                             NERDComYankComment, Same as <Leader>cc except that the commented line(s) are yanked first\n"
  echo "<Leader>c$                                    NERDComEOLComment, Comments the current line from the cursor to the end of line\n"
  echo "<Leader>cA                                    NERDComAppendComment, Adds comment delimiters to the end of line and goes into insert mode between them\n"
  echo "<Leader>ca                                    NERDComAltDelim, Switches to the alternative set of delimiters\n"
  echo '[count]<Leader>cl && [count]<Leader>cb        NERDComAlignedComment, Same as NERDComComment except that the delimiters are aligned down the left side (<Leader>cl) or both sides (<Leader>cb)'
endfunction
nnoremap <silent> <leader>c? :<C-u>call Help_nerdcommenter()<CR>
"}}}
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
noremap <silent> <leader>rf :AsyncTask file-run<cr>
noremap <silent> <leader>bf :AsyncTask file-build<cr>
noremap <silent> <leader>rp :AsyncTask project-run<cr>
noremap <silent> <leader>bp :AsyncTask project-build<cr>
noremap <silent> <leader>g^ :AsyncRun git config --global http.proxy "socks5://127.0.0.1:1080" && git config --global https.proxy "socks5://127.0.0.1:1080"<cr>
noremap <silent> <leader>g$ :AsyncRun git config --global --unset http.proxy && git config --global --unset https.proxy<cr>
noremap <silent> <leader>gp :AsyncRun git push origin HEAD<cr>
noremap <silent> <leader>gf :AsyncRun git fetch origin<cr>
noremap <silent> <leader>gc :Git commit<cr>
noremap <silent> <leader><space>E :AsyncTaskEdit<cr>
let g:which_key_map['r'] = {'name': 'run', 'f': 'file', 'p': 'project'}
let g:which_key_map['b'] = {'name': 'build', 'f': 'file', 'p': 'project'}
let g:which_key_map["\<space>"]['E'] = 'task config'
let g:which_key_map['g']['^'] = 'set proxy'
let g:which_key_map['g']['$'] = 'unset proxy'
let g:which_key_map['g']['c'] = 'commit'
let g:which_key_map['g']['p'] = 'push'
let g:which_key_map['g']['f'] = 'fetch'
"}}}
"{{{vim-terminal-help
let g:terminal_default_mapping = 0
let g:terminal_key = '<A-=>'
let g:terminal_cwd = 2
let g:terminal_height = 13
let g:terminal_kill = 'term'
let g:terminal_list = 0
"{{{
let s:cmd = 'nnoremap <silent>'.(g:terminal_key). ' '
exec s:cmd . ':call TerminalToggle()<cr>'

if has('nvim') == 0
  let s:cmd = 'tnoremap <silent>'.(g:terminal_key). ' '
  exec s:cmd . '<c-_>:call TerminalToggle()<cr>'
else
  let s:cmd = 'tnoremap <silent>'.(g:terminal_key). ' '
  exec s:cmd . '<c-\><c-n>:call TerminalToggle()<cr>'
endif
"}}}
"}}}
"{{{vim-visual-multi
"{{{vim-visual-multi-usage
function! Help_vim_visual_multi()
  echo 'Normal & Visual'
  echo '`             添加光标'
  echo '<Esc>         退出'
endfunction
"}}}
" https://github.com/mg979/vim-visual-multi/wiki
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Switch Mode']                 = 'v'
let g:VM_maps['Add Cursor At Pos']           = '`'
let g:VM_maps['Visual Cursors']              = '`'
"}}}
"{{{suda.vim
"{{{suda.vim-usage
" :E filename  sudo edit
" :W       sudo edit
"}}}
command! -nargs=1 E  edit  suda://<args>
command W w suda://%
"}}}
"{{{vim-surround
"{{{vim-surround-usage
function! Help_vim_surround()
  echo 'ds([          delete surround'
  echo 'cs([          change surround () to []'
  echo 'ysw[          add surround [] from current position to the end of this word'
  echo 'ysiw[         add surround [] from the begin of this word to the end'
  echo 'yss[          add surround [] from the begin of this line to the end'
endfunction
"}}}
"}}}
"{{{inline_edit.vim
"{{{inline-edit-usage
function! Help_inline_edit()
  echo ''
  echo 'visual 或 normal 模式下按 E'
  echo ''
endfunction
"}}}
nnoremap E :<C-u>InlineEdit<CR>
vnoremap E :InlineEdit<CR>
"}}}
"{{{vim-translate-me
let g:vtm_default_mapping = 0
let g:vtm_default_engines = ['youdao', 'bing']
nmap <silent> <Leader>t <Plug>TranslateW
vmap <silent> <Leader>t <Plug>TranslateWV
hi def link vtmQuery            Constant
hi def link vtmParaphrase       StorageClass
hi def link vtmPhonetic         Type
hi def link vtmExplain          String
hi def link vtmPopupNormal      NormalFloat
hi def link vtmDelimiter        Comment
"}}}
"{{{comfortable-motion.vim
"{{{comfortable-motion.vim-usage
" <pageup> <pagedown>平滑滚动
" nvim中，<A-J>和<A-K>平滑滚动
"}}}
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
nnoremap <silent> <pagedown> :<C-u>call comfortable_motion#flick(130)<CR>
nnoremap <silent> <pageup> :<C-u>call comfortable_motion#flick(-130)<CR>
nnoremap <silent> <C-d> :<C-u>call comfortable_motion#flick(120)<CR>
nnoremap <silent> <C-u> :<C-u>call comfortable_motion#flick(-120)<CR>
"}}}
"{{{auto-pairs
"{{{auto-pairs-usage
function! Help_auto_pairs()
  echo '插入模式下：'
  echo '<A-z>p            toggle auto-pairs'
  echo '<A-n>             jump to next closed pair'
  echo '<A-Backspace>     delete without pairs'
  echo '<A-z>[key]        insert without pairs'
endfunction
"}}}
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
" imap <A-Backspace> <A-z>p<Backspace><A-z>p
augroup autoPairsCustom
  autocmd!
  " au Filetype html let b:AutoPairs = {"<": ">"}
augroup END
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
"{{{vim-matchup-usage
function! Help_vim_matchup()
  echo 'surrounding match highlight bold, word match highlight underline'
  echo ''
  echo 'Match Word Jump:'
  echo '%     jump to next word match current cursor position'
  echo 'g%    jump to previous word match current cursor position'
  echo '[%    jump to first word match current cursor position'
  echo ']%    jump to last word match current cursor position'
  echo '[%    if at the beginning of current outer, jump to previous outer'
  echo ']%    if at the end of current outer, jump to next outer'
  echo ''
  echo 'Match Surrounding Jump:'
  echo 'z%    jump inside the nearest surrounding'
  echo '[%    jump to the beginning of current surrounding'
  echo ']%    jump to the end of current surrounding'
  echo '[%    if at the beginning of current surrounding, jump to previous outer surrounding'
  echo ']%    if at the end of current surrounding, jump to next outer surrounding'
  echo '<leader>% or double-click     select current surrounding'
  echo ''
  echo 'Exception:'
  echo '%     if not recognize, seek forwards to one and then jump to its match (surrounding or word)'
  echo 'g%    if at an open word, cycle around to the corresponding open word'
  echo 'g%    if the cursor is not on a word, seek forwards to one and then jump to its match'
  echo ''
  echo 'support [count][motion] and [action][motion] syntax'
endfunction
"}}}
let g:matchup_matchparen_deferred = 1  " highlight surrounding
let g:matchup_matchparen_hi_surround_always = 1  " highlight surrounding
let g:matchup_delim_noskips = 2  " don't recognize anything in comments
nmap <leader>% ]%V[%
nmap <2-LeftMouse> ]%V[%
"}}}
" {{{vim-manpager
if exists('g:vimManPager')
  " {{{vim-manpager-usage
  function! Help_vim_manpager()
    echo 'shell里"man foo"启动'
    echo '<CR>              打开当前word的manual page'
    echo '<C-o>             跳转到之前的位置'
    echo '<Tab>             跳转到下一个历史'
    echo '<S-Tab>           跳转到上一个历史'
    echo '<C-j>             跳转到下一个keyword'
    echo '<C-k>             跳转到上一个keyword'
    echo 'E                 set modifiable'
    echo '<A-w>             quit'
    echo '?                 Help'
  endfunction
  " }}}
  function! s:vim_manpager_mappings() abort
    nnoremap <silent><buffer> ? :<C-u>call Help_vim_manpager()<CR>
    nmap <silent><buffer> <C-j> ]t
    nmap <silent><buffer> <C-k> [t
    nmap <silent><buffer> <A-w> :<C-u>call ForceCloseRecursively()<CR>
    nnoremap <silent><buffer> K zz:<C-u>call smooth_scroll#up(&scroll, 10, 1)<CR>
    nnoremap <silent><buffer> E :<C-u>set modifiable<CR>
  endfunction
  augroup manPagerCustom
    autocmd!
    autocmd FileType man call s:vim_manpager_mappings()
  augroup END
endif
" }}}
"{{{vim-closetag
"{{{vim-closetag-usage
function! Help_vim_closetag()
  echo '>             press return at current tag'
  echo '<A-z>>        add > at current position without closing the current tag'
  echo ''
endfunction
"}}}
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<A-z>>'
" whitelist
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.jsx,*.tsx'
"}}}
"{{{vim-json
function! Func_vim_json()
  let g:vim_json_syntax_conceal = 0
  set foldmethod=syntax
endfunction
"}}}
"{{{vCoolor.vim
function Help_vCoolor()
  echo ':Rgb2Hex "255, 0, 255"                        " Gives "#FF00FF"'
  echo ':Rgb2RgbPerc "255, 0, 255"            " Gives "100%, 0%, 100%"'
  echo ':Rgb2Hsl "255, 0, 255"                        " Gives "300, 100%, 50%"'
  echo ''
  echo ':RgbPerc2Hex "100%, 0%, 100%" " Gives "#FF00FF"'
  echo ':RgbPerc2Rgb "100%, 0%, 100%" " Gives "255, 0, 255"'
  echo ''
  echo ':Hex2Lit "#FF00FF"                            " Gives "magenta"'
  echo ':Hex2Rgb "#FF00FF"                            " Gives "255, 0, 255"'
  echo ':Hex2RgbPerc "#FF00FF"                        " Gives "100%, 0%, 100%"'
  echo ':Hex2Hsl "#FF00FF"                            " Gives "300, 100%, 50%"'
  echo ''
  echo ':Hsl2Rgb "300, 100%, 50%"             " Gives "255, 0, 255"'
  echo ':Hsl2Hex "300, 100%, 50%"             " Gives "#FF00FF"'
endfunction
let g:vcoolor_disable_mappings = 1
let g:vcoolor_lowercase = 1
let g:vcoolor_custom_picker = 'zenity --title "custom" --color-selection --color '
nnoremap <silent> <leader><space>cc :<c-u>VCoolor<cr>
nnoremap <silent> <leader><space>cr :<c-u>VCoolor r<cr>
nnoremap <silent> <leader><space>cH :<c-u>VCoolor h<cr>
nnoremap <silent> <leader><space>cR :<c-u>VCoolor ra<cr>
nnoremap <silent> <leader><space>ch :<c-u>call Help_vCoolor()<cr>
let g:which_key_map["\<space>"]['c'] = {
      \   'name': 'color picker',
      \   'c': 'insert hex',
      \   'r': 'insert rgb',
      \   'H': 'insert hsl',
      \   'R': 'insert rgba',
      \   'h': 'help'
      \   }
"}}}
"{{{vim-devicons
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[''] = "\uf15b"
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}
"{{{markdown-preview.nvim
if !has('win32')
  let g:mkdp_browser = 'firefox-developer-edition'
else
  let g:mkdp_browser = 'firefox'
endif
let g:mkdp_echo_preview_url = 1
nmap <silent> <leader><space>p <Plug>MarkdownPreviewToggle
let g:which_key_map["\<space>"]['p'] = 'preview markdown'
"}}}
