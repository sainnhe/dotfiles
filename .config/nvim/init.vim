"{{{Basic
"{{{BasicConfig
if has('nvim')
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
endif
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
"}}}
"{{{Manual
" sudo pacman -S python-neovim
" 安装软件包:
" lua boost xclip words the_silver_searcher fzf ctags global toilet toilet-fonts nodejs yarn php
" astyle tidy eslint stylelint prettier shfmt js-beautify cppcheck nodejs-jsonlint shellcheck python-vint stylelint-config-standard(npm)
" yapf python-pyflakes python-pycodestyle python-pydocstyle python-pylint
" :call Install_COC_Sources()  "  function里包含了json的额外设置
"{{{InstallLSP
" https://microsoft.github.io/language-server-protocol/implementors/servers/
" sudo pacman -Syu clang  # clangd
" yay -S ccls  # ccls
" sudo pacman -S python-language-server  # pyls
" sudo pacman -S bash-language-server  # bash-language-server start
" sudo npm install -g vscode-css-languageserver-bin  # css-languageserver --stdio
" sudo npm install -g vscode-html-languageserver-bin  # html-languageserver --stdio
"}}}
"}}}
"{{{Todo
" https://github.com/search?p=21&q=vim&ref=opensearch&s=stars&type=Repositories
"}}}
let g:VIM_AutoInstall = 1
let g:VIM_LSP_Client = 'lcn'  " lcn vim-lsp
let g:VIM_Snippets = 'ultisnips'  " ultisnips neosnippet
let g:VIM_Completion_Framework = 'coc'  " deoplete ncm2 asyncomplete coc neocomplete
let g:VIM_Fuzzy_Finder = 'denite'  " denite fzf leaderf
let g:VIM_Linter = 'ale' | let g:EnableCocLint = 0  " ale neomake
let g:VIM_Explore = 'defx'  " defx nerdtree
" :UpdateRemotePlugins
if exists('*VIM_Global_Settings')
    call VIM_Global_Settings()
endif
"}}}
"{{{VimConfig
"{{{Functions
"{{{CloseOnLastTab
function! CloseOnLastTab()
    let g:Loop_Var = 0
    if tabpagenr('$') == 1
        while (winnr('$') > 0) && g:Loop_Var < 10
            execute 'q'
            g:Loop_Var = g:Loop_Var + 1
        endwhile
    elseif tabpagenr('$') > 1
        execute 'tabclose'
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
"{{{RomaNumber
fun! RomaNumber(number) abort
    let l:number = a:number
    if l:number ==# '1'
        let l:nicenumber = 'Ⅰ'
    elseif l:number ==# '2'
        let l:nicenumber = 'Ⅱ'
    elseif l:number ==# '3'
        let l:nicenumber = 'Ⅲ'
    elseif l:number ==# '4'
        let l:nicenumber = 'Ⅳ'
    elseif l:number ==# '5'
        let l:nicenumber = 'Ⅴ'
    elseif l:number ==# '6'
        let l:nicenumber = 'Ⅵ'
    elseif l:number ==# '7'
        let l:nicenumber = 'Ⅶ'
    elseif l:number ==# '8'
        let l:nicenumber = 'Ⅷ'
    elseif l:number ==# '9'
        let l:nicenumber = 'Ⅸ'
    elseif l:number ==# '10'
        let l:nicenumber = 'Ⅹ'
    else
        let l:nicenumber = a:number
    endif
    return l:nicenumber
endfun
"}}}
"{{{NegativeCircledNumber
fun! NegativeCircledNumber(number) abort
    let l:number = a:number
    if l:number ==# '1'
        let l:nicenumber = '❶'
    elseif l:number ==# '2'
        let l:nicenumber = '❷'
    elseif l:number ==# '3'
        let l:nicenumber = '❸'
    elseif l:number ==# '4'
        let l:nicenumber = '❹'
    elseif l:number ==# '5'
        let l:nicenumber = '❺'
    elseif l:number ==# '6'
        let l:nicenumber = '❻'
    elseif l:number ==# '7'
        let l:nicenumber = '❼'
    elseif l:number ==# '8'
        let l:nicenumber = '❽'
    elseif l:number ==# '9'
        let l:nicenumber = '❾'
    elseif l:number ==# '10'
        let l:nicenumber = '❿'
    else
        let l:nicenumber = a:number
    endif
    return l:nicenumber
endfun
"}}}
"}}}
"{{{Settings
set encoding=utf-8
scriptencoding utf-8
let mapleader=' '
nnoremap <SPACE> <Nop>                  " leader map required
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab     " :retab 使文件中的TAB匹配当前设置
let g:sessions_dir = '~/.vim/sessions/'
set termguicolors                       " 开启GUI颜色支持
set smartindent                         " 智能缩进
set hlsearch                            " 高亮搜索
set undofile                            " 始终保留undo文件
set undodir=$HOME/.vim/undo             " 设置undo文件的目录
set timeoutlen=5000                     " 超时时间为5秒
set clipboard=unnamedplus               " 开启系统剪切板，需要安装xclip
set foldmethod=marker                   " 折叠方式为按照marker折叠
set hidden                              " buffer自动隐藏
set showtabline=2                       " 总是显示标签
set scrolloff=5                         " 保持5行
set viminfo='1000                       " 文件历史个数
set autoindent                          " 自动对齐
if has('nvim')
    set inccommand=split
endif
filetype on
" "{{{
" if (has('termguicolors'))
"         set termguicolors
" endif
"
" if exists('g:loaded_sensible') || &compatible
"         finish
" else
"         let g:loaded_sensible = 'yes'
" endif
"
" if has('autocmd')
"         filetype plugin indent on
" endif
" if has('syntax') && !exists('g:syntax_on')
"         syntax enable
" endif
"
" " Use :help 'option' to see the documentation for the given option.
"
" set backspace=indent,eol,start
" set complete-=i
" set smarttab
"
" set nrformats-=octal
"
" set incsearch
" set laststatus=2
" set ruler
" set wildmenu
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
" set autoread
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
"{{{Mappings
"{{{VIM-Compatible
if !has('nvim')
    execute "set <M-w>=\ew"
    execute "set <M-v>=\ev"
    execute "set <M-h>=\eh"
    execute "set <M-,>=\e,"
    execute "set <M-.>=\e."
    execute "set <M-->=\e-"
    execute "set <M-=>=\e="
    execute "set <M-b>=\eb"
    execute "set <M-z>=\ez"
    execute "set <M-g>=\eg"
    execute "set <M-n>=\en"
    execute "set <M-p>=\ep"
endif
"}}}
"{{{NormalMode
" Ctrl+Space进入普通模式
nnoremap <C-SPACE> <ESC>
if !has('nvim')
    nnoremap ^@ <ESC>
endif
" ; 绑定到 :
nnoremap ; :
" Ctrl+S保存文件
nnoremap <C-S> <Esc>:w<CR>
" Shift加方向键加速移动
nnoremap <S-up> <Esc>5<up>zz
nnoremap <S-down> <Esc>5<down>zz
nnoremap <S-left> <Esc>0
nnoremap <S-right> <Esc>$
" x删除字符但不保存到剪切板
nnoremap x "_x
" Alt+Backspace从当前位置删除到行开头
nnoremap <A-BS> <Esc><left>v0"_d
" Ctrl+T新建tab
if g:VIM_Explore ==# 'defx'
    nnoremap <silent> <C-T> <Esc>:tabnew<CR>:call DefxStartify()<CR>
elseif g:VIM_Explore ==# 'nerdtree'
    nnoremap <silent> <C-T> <Esc>:tabnew<CR>:call NerdtreeStartify()<CR>
endif
" Ctrl+W关闭当前标签
nnoremap <silent> <C-W> <Esc>:call CloseOnLastTab()<CR>
" Ctrl+左右切换tab
nnoremap <C-left> <Esc>gT
nnoremap <C-right> <Esc>gt
" Ctrl+上下切换到第一个、最后一个tab
nnoremap <silent> <C-up> <Esc>:tabfirst<CR>
nnoremap <silent> <C-down> <Esc>:tablast<CR>
" Alt+上下左右可以在窗口之间跳转
nnoremap <silent> <A-left> <Esc>:wincmd h<CR>
nnoremap <silent> <A-right> <Esc>:wincmd l<CR>
nnoremap <silent> <A-up> <Esc>:wincmd k<CR>
nnoremap <silent> <A-down> <Esc>:wincmd j<CR>
" Alt+W关闭窗口
nnoremap <silent> <A-w> <Esc>:q<CR>
" Alt+V && Alt+H新建窗口
nnoremap <silent> <A-v> <Esc>:vsp<CR>
nnoremap <silent> <A-h> <Esc>:sp<CR>
" Alt+-<>调整窗口大小
nnoremap <silent> <A-=> <Esc>:wincmd +<CR>
nnoremap <silent> <A--> <Esc>:wincmd -<CR>
nnoremap <silent> <A-,> <Esc>:wincmd <<CR>
nnoremap <silent> <A-.> <Esc>:wincmd ><CR>
" z+方向键快速跳转
nnoremap z<left> zk
nnoremap z<right> zj
nnoremap z<up> [z
nnoremap z<down> ]z
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
nnoremap zs :mkview<CR>
nnoremap zl :loadview<CR>
"}}}
"{{{InsertMode
" Ctrl+Space进入普通模式
inoremap <C-SPACE> <ESC><right>
if !has('nvim')
    inoremap ^@ <ESC>
endif
" Ctrl+V粘贴
inoremap <C-V> <ESC>pa
" Ctrl+S保存文件
inoremap <C-S> <ESC>:w<CR>a
" Ctrl+Z撤销上一个动作
inoremap <C-Z> <ESC>ua
" Ctrl+R撤销撤销的动作
inoremap <C-R> <ESC><C-R>a
" Ctrl+X剪切当前行
inoremap <C-X> <ESC>ddi
" Alt+Backspace从当前位置删除到行开头
inoremap <A-BS> <Esc>v0"_dI
" Shift加方向键加速移动
inoremap <S-up> <up><up><up><up><up>
inoremap <S-down> <down><down><down><down><down>
inoremap <S-left> <ESC>I
inoremap <S-right> <ESC>A
" Alt+上下左右可以在窗口之间跳转
inoremap <silent> <A-left> <Esc>:wincmd h<CR>i
inoremap <silent> <A-right> <Esc>:wincmd l<CR>i
inoremap <silent> <A-up> <Esc>:wincmd k<CR>i
inoremap <silent> <A-down> <Esc>:wincmd j<CR>i
"}}}
"{{{VisualMode
" Ctrl+Space进入普通模式
vnoremap <C-SPACE> <ESC>
if !has('nvim')
    vnoremap ^@ <ESC>
endif
" ; 绑定到 :
vnoremap ; :
" Ctrl+S保存文件
vnoremap <C-S> <ESC>:w<CR>v
" x删除字符但不保存到剪切板
vnoremap x "_x
" Shift+方向键快速移动
vnoremap <S-up> <up><up><up><up><up>
vnoremap <S-down> <down><down><down><down><down>
vnoremap <S-left> 0
vnoremap <S-right> $<left>
"}}}
"{{{CommandMode
" Ctrl+Space进入普通模式
cmap <C-SPACE> <ESC>
if !has('nvim')
    cmap ^@ <ESC>
endif
" Ctrl+S保存
cmap <C-S> <ESC>:w<CR>
"}}}
"{{{TerminalMode
if has('nvim')
    " Ctrl+Space返回普通模式
    tnoremap <C-Space> <C-\><C-n>
    " Shift+方向键加速移动
    tnoremap <S-down> <C-E>
    tnoremap <S-up> <C-A>
    tnoremap <S-left> <C-left>
    tnoremap <S-right> <C-right>
endif
"}}}
"}}}
"{{{Commands
" Q强制退出
command Q q!
"}}}
"{{{TempConfig

"}}}
"}}}
"{{{Plugins
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
"{{{
" let g:plug_url_format = 'https://git::@github.com/%s.git'
" press 'o' to open preview window
augroup vim_plug_mapping
    autocmd! FileType vim-plug nmap <buffer> o <plug>(plug-preview)<c-w>P
augroup END

" automatically install missing plugins on startup
if g:VIM_AutoInstall == 1
    augroup vim_plug_auto_install
        autocmd!
        autocmd VimEnter *
                    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                    \|   PlugInstall --sync | q
                    \| endif
    augroup END
endif

" Press 'H' to open help docs
function! s:plug_doc()
    let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
    if has_key(g:plugs, name)
        for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
            execute 'tabe' doc
        endfor
    endif
endfunction
augroup PlugHelp
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> <silent> H :call <sid>plug_doc()<cr>
augroup END

" press 'gx' to open github url in browser
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
    autocmd FileType vim-plug nnoremap <buffer> <silent> <Tab> :call <sid>plug_gx()<cr>
augroup END

" J / K to scroll the preview window
" CTRL-N / CTRL-P to move between the commits
" CTRL-J / CTRL-K to move between the commits and synchronize the preview window
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

call plug#begin('~/.vim/plugins')
if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
"}}}
" User Interface
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'CharlesGueunet/quickmenu.vim'
Plug 'mhinz/vim-signify'
Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides', { 'on': [] }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight!!' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'roman/golden-ratio'
"{{{themes
Plug 'ajmwagar/vim-deus' | Plug 'nrhodes91/deus_one.vim'
Plug 'jnurmine/Zenburn' | Plug 'acepukas/vim-zenburn'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'nightsense/snow'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'jacoborus/tender.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'Badacadabra/vim-archery'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'yuttie/hydrangea-vim'
Plug 'yuttie/inkstained-vim'
Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'cormacrelf/vim-colors-github'
Plug 'nightsense/stellarized'
Plug 'tomasr/molokai'
Plug 'ayu-theme/ayu-vim'
Plug 'whatyouhide/vim-gotham'
Plug 'blueshirts/darcula'
Plug 'kaicataldo/material.vim'
Plug 'fcpg/vim-fahrenheit'
Plug 'fcpg/vim-farout'
Plug 'fcpg/vim-orbital'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nightsense/forgotten'
Plug 'nightsense/nemo'
Plug 'Marfisc/vorange'
Plug 'hzchirs/vim-material'
"}}}

" Productivity
if g:VIM_LSP_Client ==# 'lcn'
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'proxychains bash install.sh' }
elseif g:VIM_LSP_Client ==# 'vim-lsp'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
endif
if g:VIM_Snippets ==# 'ultisnips' && g:VIM_Completion_Framework !=# 'coc'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
elseif g:VIM_Snippets ==# 'neosnippet' && g:VIM_Completion_Framework !=# 'coc'
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'honza/vim-snippets'
endif
if g:VIM_Completion_Framework ==# 'deoplete'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neco-syntax'
    Plug 'Shougo/neoinclude.vim'
    Plug 'Shougo/context_filetype.vim'
    Plug 'tbodt/deoplete-tabnine', { 'do': 'proxychains bash ./install.sh' }
    Plug 'Shougo/neco-vim', { 'for': 'vim' }
    Plug 'Shougo/deoplete-clangx', { 'for': [ 'c', 'cpp' ] }
    Plug 'zchee/deoplete-clang', { 'for': [ 'c', 'cpp' ] }
    Plug 'zchee/deoplete-jedi', { 'for': 'python' }
elseif g:VIM_Completion_Framework ==# 'ncm2'
    Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-tagprefix'
    Plug 'filipekiss/ncm2-look.vim'
    Plug 'ncm2/ncm2-github'
    Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
    Plug 'ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'
    Plug 'ncm2/ncm2-pyclang', { 'for': ['c', 'cpp'] }
    " Plug 'ncm2/ncm2-cssomni', { 'for': 'css' }
    Plug 'ncm2/ncm2-html-subscope', { 'for': 'html' }
    Plug 'ncm2/ncm2-jedi'
    Plug 'ncm2/ncm2-markdown-subscope', { 'for': 'markdown' }
    Plug 'ncm2/ncm2-vim', { 'for': 'vim' } | Plug 'Shougo/neco-vim', { 'for': 'vim' }
    if g:VIM_LSP_Client ==# 'vim-lsp'
        Plug 'ncm2/ncm2-vim-lsp'
    endif
    if g:VIM_Snippets ==# 'ultisnips'
        Plug 'ncm2/ncm2-ultisnips'
    elseif g:VIM_Snippets ==# 'neosnippet'
    endif
elseif g:VIM_Completion_Framework ==# 'asyncomplete'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-buffer.vim'
    Plug 'prabirshrestha/asyncomplete-file.vim'
    Plug 'Shougo/neco-syntax' | Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
    Plug 'Shougo/neoinclude.vim' | Plug 'kyouryuukunn/asyncomplete-neoinclude.vim'
    Plug 'Shougo/neco-vim', { 'for': 'vim' } | Plug 'prabirshrestha/asyncomplete-necovim.vim', { 'for': 'vim' }
    if g:VIM_LSP_Client ==# 'vim-lsp'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
    endif
    if g:VIM_Snippets ==# 'ultisnips'
        Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
    elseif g:VIM_Snippets ==# 'neosnippet'
        Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
    endif
elseif g:VIM_Completion_Framework ==# 'coc'
    if g:VIM_Snippets ==# 'ultisnips'
        Plug 'SirVer/ultisnips', { 'on': [] }
        Plug 'honza/vim-snippets', { 'on': [] }
    elseif g:VIM_Snippets ==# 'neosnippet'
        Plug 'Shougo/neosnippet.vim', { 'on': [] }
        Plug 'Shougo/neosnippet-snippets', { 'on': [] }
        Plug 'honza/vim-snippets', { 'on': [] }
    endif
    Plug 'neoclide/coc.nvim', {'do': 'proxychains yarn install', 'on': []}
    Plug 'Shougo/neco-vim', { 'on': [] } | Plug 'neoclide/coc-neco', { 'on': [] }
    Plug 'iamcco/coc-action-source.nvim', { 'on': [] }
elseif g:VIM_Completion_Framework ==# 'neocomplete'
    Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/neoinclude.vim'
    Plug 'Shougo/neco-vim'
    Plug 'Shougo/neco-syntax'
    Plug 'ujihisa/neco-look'
endif
Plug 'wsdjeg/FlyGrep.vim', { 'on': 'FlyGrep' }
if g:VIM_Fuzzy_Finder ==# 'denite'
    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins'}
    Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
    Plug 'nixprime/cpsm', { 'do': 'bash ./install.sh' }
    Plug 'iamcco/denite-source.vim'
    Plug 'neoclide/denite-extra'
    Plug 'Shougo/neomru.vim'
    Plug 'chemzqm/denite-git'
    Plug 'ozelentok/denite-gtags'
    Plug 'notomo/denite-keymap'
    Plug 'tjmmm/denite-man'
    if g:VIM_Linter ==# 'ale'
        Plug 'iyuuya/denite-ale'
    elseif g:VIM_Linter ==# 'neomake'
        Plug 'mhartington/denite-neomake'
    endif
elseif g:VIM_Fuzzy_Finder ==# 'fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'fszymanski/fzf-quickfix'
elseif g:VIM_Fuzzy_Finder ==# 'leaderf'
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    Plug 'Yggdroot/LeaderF-marks'
endif
if g:VIM_Linter ==# 'ale'
    Plug 'w0rp/ale'
    Plug 'maximbaz/lightline-ale'
elseif g:VIM_Linter ==# 'neomake'
    Plug 'neomake/neomake'
    " Plug 'sinetoami/lightline-neomake'
    Plug 'mkalinski/vim-lightline_neomake'
    if g:VIM_LSP_Client ==# 'lcn'
        Plug 'Palpatineli/lightline-lsc-nvim'
    endif
endif
if g:VIM_Explore ==# 'defx'
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'kristijanhusak/defx-git'
    Plug 'kristijanhusak/defx-icons'
    Plug 'jlanzarotta/bufexplorer'
elseif g:VIM_Explore ==# 'nerdtree'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
endif
Plug 'majutsushi/tagbar', { 'on': [] }
Plug 'lvht/tagbar-markdown', { 'on': [] }
Plug 'Chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'lambdalisue/suda.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'lilydjwg/fcitx.vim'
Plug 'ianva/vim-youdao-translater'
Plug 'yuttie/comfortable-motion.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'metakirby5/codi.vim'
Plug 'nhooyr/neoman.vim', { 'on': [ 'Nman', 'Snman', 'Vnman', 'Tnman' ] }
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
            \| au BufNewFile,BufRead *.html,*.css call Func_emmet_vim()
Plug 'gko/vim-coloresque', { 'for': ['html', 'css'] }
Plug 'alvan/vim-closetag', { 'for': 'html' }
            \| au BufNewFile,BufRead *.html,*.css call Func_vim_closetag()
Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
            \| au BufNewFile,BufRead *.html call Func_MatchTagAlways()
Plug 'ehamberg/vim-cute-python', { 'for': 'python' }
"{{{
call plug#end()
"{{{ncm2-archived
" Plug 'ncm2/ncm2-gtags'
" Plug 'ncm2/ncm2-tmux'
" Plug 'ncm2/ncm2-match-highlight'
" Plug 'ncm2/ncm2-highprio-pop'
"}}}
"}}}
"}}}
"{{{Config
" quickmenu
let g:quickmenu_options = 'HL'  " enable cursorline (L) and cmdline help (H)
" startify
let g:startify_bookmarks = [
            \ {'N': '/mnt/ExternalDisk/OneDrive/Notes'},
            \ {'n': '/mnt/ExternalDisk/OneDrive/Notes/CSS/w3schools.md'},
            \ {'n': '/mnt/ExternalDisk/OneDrive/Notes/Python/w3schools.md'},
            \ {'S': '~/Scripts/'},
            \ {'P': '~/Documents/PlayGround/'},
            \ {'c': '~/.config/nvim/init.vim'},
            \ {'c': '~/.zshrc'},
            \ ]
let g:startify_commands = [
            \ {'1': 'terminal'},
            \ ]

call quickmenu#current(0)
call quickmenu#reset()
nnoremap <silent> <leader><Space> :call quickmenu#toggle(0)<cr>
vnoremap <silent> <leader><Space> :call quickmenu#toggle(0)<cr>
call g:quickmenu#append('# Menu', '')
if g:VIM_Completion_Framework ==# 'coc'
    call g:quickmenu#append('COC Menu', 'call quickmenu#toggle(6)', '', '', 0, '`')
endif
call g:quickmenu#append('Make Session', 'mks! ~/.vim/sessions/session.vim', '', '', 0, 's')
call g:quickmenu#append('Switch ColorScheme', 'call quickmenu#toggle(99)', '', '', 0, 'c')
call g:quickmenu#append('Codi', 'Codi!!', '', '', 0, 'C')
call g:quickmenu#append('Format', 'call quickmenu#toggle(7)', '', '', 0, 'f')
call g:quickmenu#append('IndentGuides', 'call ToggleIndentGuides()', '', '', 0, 'i')
call g:quickmenu#append('Focus Mode', 'Limelight!!', 'toggle focus mode', '', 0, 'F')
call g:quickmenu#append('Read Mode', 'Goyo', 'toggle read mode', '', 0, 'R')
call g:quickmenu#append('Help', 'call quickmenu#toggle(10)', '', '', 0, 'h')
call quickmenu#current(10)
call quickmenu#reset()
call g:quickmenu#append('# Help', '')
call g:quickmenu#append('Auto Pairs', 'call Help_auto_pairs()', '', '', 0, 'p')
call g:quickmenu#append('Nerd Commenter', 'call Help_nerdcommenter()', '', '', 0, 'c')
call g:quickmenu#append('Bookmarks', 'call Help_vim_bookmarks()', '', '', 0, 'b')
call g:quickmenu#append('Close Tag', 'call Help_vim_closetag()', '', '', 0, 't')
call g:quickmenu#append('Multiple Cursors', 'call Help_vim_multiple_cursors()', '', '', 0, 'm')
call g:quickmenu#append('Signify', 'call Help_vim_signify()', '', '', 0, 's')
call g:quickmenu#append('VIM Surround', 'call Help_vim_surround()', '', '', 0, 'r')
call g:quickmenu#append('MatchTagAlways', 'call Help_MatchTagAlways()', '', '', 0, 'M')
call g:quickmenu#append('neoman', 'call Help_neoman()', '', '', 0, 'h')
"}}}
" User Interface
"{{{lightline.vim
"{{{lightline.vim-usage
" :h 'statusline'
" :h g:lightline.component
"}}}
"{{{functions
function! NiceTabNum(n) abort
    " \ 'globalinfo': 'T%{NiceNumber(tabpagenr())} B%{bufnr("%")} W%{tabpagewinnr(tabpagenr())}',
    return RomaNumber(a:n)
    " return RomaNumber(tabpagenr('$'))
endfunction
" COC StatusLine Function
function! CocStatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, "\uf00d" . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, "\uf529" . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction
"}}}
set laststatus=2  " Basic
set noshowmode  " Disable show mode info
let g:lightline = {}
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let g:lightline#neomake#prefix_infos = 'ℹ'
let g:lightline#neomake#prefix_warnings = "\uf529"
let g:lightline#neomake#prefix_errors = "\uf00d"
let g:lightline#neomake#prefix_ok = "\uf00c"
let g:lightline_neomake#format = '%s: %d'
let g:lightline_neomake#sep = "\ue0b9"
let g:lightline#lsc#indicator_checking = "\uf110"
let g:lightline#lsc#indicator_notstarted = "\ufbab"
let g:lightline#lsc#indicator_errors = "\uf00d"
let g:lightline#lsc#indicator_ok = "\uf00c"
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf529"
let g:lightline#ale#indicator_errors = "\uf00d"
let g:lightline#ale#indicator_ok = "\uf00c"
if g:VIM_Linter ==# 'ale'
    let g:lightline.active = {
                \ 'left': [ [ 'mode', 'paste' ],
                \           [ 'readonly', 'filename', 'modified', 'fileformat', 'filetype', 'filesize' ]],
                \ 'right': [ [ 'lineinfo' ],
                \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
elseif g:VIM_Linter ==# 'neomake'
    let g:lightline.active = {
                \ 'left': [ [ 'mode', 'paste' ],
                \           [ 'readonly', 'filename', 'modified', 'fileformat', 'filetype', 'filesize' ]],
                \ 'right': [ [ 'lineinfo' ],
                \            [ 'neomake' ]] }
    " \            [ 'neomake_warnings', 'neomake_errors', 'neomake_infos', 'neomake_ok' ],
endif
if g:EnableCocLint == 1 && g:VIM_Linter ==# 'neomake'
    let g:lightline.active = {
                \ 'left': [ [ 'mode', 'paste' ],
                \           [ 'readonly', 'filename', 'modified', 'fileformat', 'filetype', 'filesize' ]],
                \ 'right': [ [ 'lineinfo' ],
                \            [ 'cocstatus' ]] }
elseif g:VIM_LSP_Client ==# 'lcn' && g:VIM_Linter ==# 'neomake'
    let g:lightline.active = {
                \ 'left': [ [ 'mode', 'paste' ],
                \           [ 'readonly', 'filename', 'modified', 'fileformat', 'filetype', 'filesize' ]],
                \ 'right': [ [ 'lineinfo' ],
                \            [ 'lsc_ok', 'lsc_errors', 'lsc_checking', 'lsc_warnings' ]] }
endif
let g:lightline.inactive = {
            \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'filetype', 'filesize' ]],
            \ 'right': [ [ 'lineinfo', 'percent' ] ] }
let g:lightline.tabline = {
            \ 'left': [ [ 'vim_logo', 'tabs' ] ],
            \ 'right': [ [ 'bufinfo' ] ] }
let g:lightline.tab = {
            \ 'active': [ 'nicetabnum', 'filename', 'modified' ],
            \ 'inactive': [ 'nicetabnum', 'filename', 'modified' ] }
let g:lightline.tab_component = {
            \}
let g:lightline.tab_component_function = {
            \ 'nicetabnum': 'NiceTabNum',
            \ 'filename': 'lightline#tab#filename',
            \ 'modified': 'lightline#tab#modified',
            \ 'readonly': 'lightline#tab#readonly',
            \ 'tabnum': 'lightline#tab#tabnum' }
let g:lightline.component = {
            \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
            \ 'cocstatus': '%{CocStatusDiagnostic()}',
            \ 'vim_logo': "\ue7c5",
            \ 'nicewinnumber': '%{NegativeCircledNumber(tabpagewinnr(tabpagenr()))}',
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
            \ 'winnr': '%{winnr()}' }
let g:lightline.component_function = {
            \}
let g:lightline.component_expand = {
            \ 'neomake_infos': 'lightline#neomake#infos',
            \ 'neomake_warnings': 'lightline#neomake#warnings',
            \ 'neomake_errors': 'lightline#neomke#errors',
            \ 'neomake_ok': 'lightline#neomake#ok',
            \ 'lsc_checking': 'lightline#lsc#checking',
            \ 'lsc_warnings': 'lightline#lsc#warnings',
            \ 'lsc_errors': 'lightline#lsc#errors',
            \ 'lsc_ok': 'lightline#lsc#ok',
            \ 'neomake': 'lightline_neomake#component',
            \ 'linter_checking': 'lightline#ale#checking',
            \ 'linter_warnings': 'lightline#ale#warnings',
            \ 'linter_errors': 'lightline#ale#errors',
            \ 'linter_ok': 'lightline#ale#ok',
            \ }
let g:lightline.component_type = {
            \ 'neomake_warnings': 'warning',
            \ 'neomake_errors': 'error',
            \ 'neomake_ok': 'middle',
            \ 'lsc_checking': 'middle',
            \ 'lsc_warnings': 'warning',
            \ 'lsc_errors': 'error',
            \ 'lsc_ok': 'middle',
            \ 'neomake': 'error',
            \ 'linter_checking': 'middle',
            \ 'linter_warnings': 'warning',
            \ 'linter_errors': 'error',
            \ 'linter_ok': 'middle',
            \ }
"}}}
"{{{colorscheme
let g:VIM_Color_Scheme = 'ayu'
function! ColorScheme()
    call quickmenu#current(99)
    call quickmenu#reset()
    call g:quickmenu#append('# ColorScheme', '')
    "{{{deus
    if g:VIM_Color_Scheme ==# 'deus'
        set background=dark
        colorscheme deus
        let g:lightline.colorscheme = 'deus_one'  " set background=dark
    endif
    call g:quickmenu#append('deus', 'call SwitchColorScheme("deus")', '', '', 0, '')
    "}}}
    "{{{zenburn
    if g:VIM_Color_Scheme ==# 'zenburn'
        colorscheme zenburn
        let g:lightline.colorscheme = 'zenburn'
    endif
    call g:quickmenu#append('zenburn', 'call SwitchColorScheme("zenburn")', '', '', 0, '')
    "}}}
    "{{{quantum
    if g:VIM_Color_Scheme ==# 'quantum'
        set background=dark
        let g:quantum_black=1
        let g:quantum_italics=1
        colorscheme quantum
        let g:lightline.colorscheme = 'quantum'
    endif
    call g:quickmenu#append('quantum', 'call SwitchColorScheme("quantum")', '', '', 0, '')
    "}}}
    "{{{vorange
    if g:VIM_Color_Scheme ==# 'vorange'
        set background=dark
        colorscheme vorange
        let g:lightline.colorscheme = 'fahrenheit'
    endif
    call g:quickmenu#append('vorange', 'call SwitchColorScheme("vorange")', '', '', 0, '')
    "}}}
    "{{{darcula
    if g:VIM_Color_Scheme ==# 'darcula'
        colorscheme darcula
        let g:lightline.colorscheme = 'darcula'
    endif
    call g:quickmenu#append('darcula', 'call SwitchColorScheme("darcula")', '', '', 0, '')
    "}}}
    "{{{molokai
    if g:VIM_Color_Scheme ==# 'molokai'
        colorscheme molokai
        let g:lightline.colorscheme = 'molokai'
    endif
    call g:quickmenu#append('molokai', 'call SwitchColorScheme("molokai")', '', '', 0, '')
    "}}}
    "{{{nord
    if g:VIM_Color_Scheme ==# 'nord'
        let g:nord_italic = 1
        let g:nord_underline = 1
        let g:nord_italic_comments = 1
        let g:nord_uniform_status_lines = 1
        let g:nord_uniform_diff_background = 1
        colorscheme nord
        let g:lightline.colorscheme = 'nord'
    endif
    call g:quickmenu#append('nord', 'call SwitchColorScheme("nord")', '', '', 0, '')
    "}}}
    "{{{tender
    if g:VIM_Color_Scheme ==# 'tender'
        set background=dark
        colorscheme tender
        let g:material_theme_style = 'dark'
        let g:lightline.colorscheme = 'material_vim'
    endif
    call g:quickmenu#append('tender', 'call SwitchColorScheme("tender")', '', '', 0, '')
    "}}}
    "{{{palenight
    if g:VIM_Color_Scheme ==# 'palenight'
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        set background=dark
        colorscheme palenight
        let g:lightline.colorscheme = 'deepspace'
    endif
    call g:quickmenu#append('palenight', 'call SwitchColorScheme("palenight")', '', '', 0, '')
    "}}}
    "{{{iceberg
    if g:VIM_Color_Scheme ==# 'iceberg'
        colorscheme iceberg
        let g:lightline.colorscheme = 'iceberg'
    endif
    call g:quickmenu#append('iceberg', 'call SwitchColorScheme("iceberg")', '', '', 0, '')
    "}}}
    "{{{deepspace
    if g:VIM_Color_Scheme ==# 'deepspace'
        set background=dark
        let g:deepspace_italics=1
        colorscheme deep-space
        let g:lightline.colorscheme = 'deepspace'
    endif
    call g:quickmenu#append('deepspace', 'call SwitchColorScheme("deepspace")', '', '', 0, '')
    "}}}
    "{{{archery
    if g:VIM_Color_Scheme ==# 'archery'
        colorscheme archery
        let g:lightline.colorscheme = 'archery'
    endif
    call g:quickmenu#append('archery', 'call SwitchColorScheme("archery")', '', '', 0, '')
    "}}}
    "{{{hydrangea
    if g:VIM_Color_Scheme ==# 'hydrangea'
        colorscheme hydrangea
        let g:lightline.colorscheme = 'hydrangea'
    endif
    call g:quickmenu#append('hydrangea', 'call SwitchColorScheme("hydrangea")', '', '', 0, '')
    "}}}
    "{{{gotham
    if g:VIM_Color_Scheme ==# 'gotham'
        colorscheme gotham256
        let g:lightline.colorscheme = 'gotham256'
    endif
    call g:quickmenu#append('gotham', 'call SwitchColorScheme("gotham")', '', '', 0, '')
    "}}}
    "{{{orbital
    if g:VIM_Color_Scheme ==# 'orbital'
        colorscheme orbital
        let g:lightline.colorscheme = 'orbital'
    endif
    call g:quickmenu#append('orbital', 'call SwitchColorScheme("orbital")', '', '', 0, '')
    "}}}
    "{{{fahrenheit
    if g:VIM_Color_Scheme ==# 'fahrenheit'
        colorscheme fahrenheit
        let g:lightline.colorscheme = 'fahrenheit'
    endif
    call g:quickmenu#append('fahrenheit', 'call SwitchColorScheme("fahrenheit")', '', '', 0, '')
    "}}}
    "{{{farout
    if g:VIM_Color_Scheme ==# 'farout'
        colorscheme farout
        let g:lightline.colorscheme = 'farout'
    endif
    call g:quickmenu#append('farout', 'call SwitchColorScheme("farout")', '', '', 0, '')
    "}}}
    "{{{github
    if g:VIM_Color_Scheme ==# 'github'
        colorscheme github
        let g:lightline.colorscheme = 'github'
    endif
    call g:quickmenu#append('github', 'call SwitchColorScheme("github")', '', '', 0, '')
    "}}}
    "{{{ayu
    if g:VIM_Color_Scheme ==# 'ayu'
        let g:ayucolor = 'light'
        set background=light
        colorscheme ayu
        let g:lightline.colorscheme = 'one'
    endif
    call g:quickmenu#append('ayu', 'call SwitchColorScheme("ayu")', '', '', 0, '')
    "}}}
    "{{{inkstained
    if g:VIM_Color_Scheme ==# 'inkstained'
        colorscheme inkstained
        let g:lightline.colorscheme = 'inkstained'
    endif
    call g:quickmenu#append('inkstained', 'call SwitchColorScheme("inkstained")', '', '', 0, '')
    "}}}
    "{{{nemo
    if g:VIM_Color_Scheme ==# 'nemo'
        set background=light
        colorscheme nemo-light
        let g:lightline.colorscheme = 'Atelier_Sulphurpool'
    endif
    call g:quickmenu#append('nemo', 'call SwitchColorScheme("nemo")', '', '', 0, '')
    "}}}
    "{{{forgotten
    if g:VIM_Color_Scheme ==# 'forgotten'
        set background=light
        colorscheme forgotten-light
        let g:lightline.colorscheme = 'Atelier_Lakeside'
    endif
    call g:quickmenu#append('forgotten', 'call SwitchColorScheme("forgotten")', '', '', 0, '')
    "}}}
    "{{{onehalf*
    if g:VIM_Color_Scheme ==# 'onehalf-dark'
        set background=dark
        colorscheme onehalfdark
        let g:lightline.colorscheme = 'one'
    elseif g:VIM_Color_Scheme ==# 'onehalf-light'
        set background=light
        colorscheme onehalflight
        let g:lightline.colorscheme = 'one'
    endif
    call g:quickmenu#append('onehalf-dark', 'call SwitchColorScheme("onehalf-dark")', '', '', 0, '')
    call g:quickmenu#append('onehalf-light', 'call SwitchColorScheme("onehalf-light")', '', '', 0, '')
    "}}}
    "{{{material*
    if g:VIM_Color_Scheme ==# 'material-dark'
        set background=dark
        let g:material_theme_style = 'dark'
        let g:material_terminal_italics = 1
        colorscheme material
        let g:lightline.colorscheme = 'material_vim'
    elseif g:VIM_Color_Scheme ==# 'material-light'
        set background=light
        colorscheme vim-material
        let g:lightline.colorscheme = 'snow_light'
    endif
    call g:quickmenu#append('material-dark', 'call SwitchColorScheme("material-dark")', '', '', 0, '')
    call g:quickmenu#append('material-light', 'call SwitchColorScheme("material-light")', '', '', 0, '')
    "}}}
    "{{{snow*
    if g:VIM_Color_Scheme ==# 'snow-dark'
        set background=dark
        colorscheme snow
        let g:lightline.colorscheme = 'snow_dark'
    endif
    if g:VIM_Color_Scheme ==# 'snow-light'
        set background=light
        colorscheme snow
        let g:lightline.colorscheme = 'snow_light'
    endif
    call g:quickmenu#append('snow-dark', 'call SwitchColorScheme("snow-dark")', '', '', 0, '')
    call g:quickmenu#append('snow-light', 'call SwitchColorScheme("snow-light")', '', '', 0, '')
    "}}}
    "{{{seoul256*
    if g:VIM_Color_Scheme ==# 'seoul256-dark'
        " 233 (darkest) ~ 239 (lightest)
        let g:seoul256_background = 236
        colo seoul256
        set background=dark
        let g:lightline.colorscheme = 'snow_dark'
    endif
    if g:VIM_Color_Scheme ==# 'seoul256-light'
        " 252 (darkest) ~ 256 (lightest)
        let g:seoul256_background = 252
        colo seoul256
        set background=light
        let g:lightline.colorscheme = 'Tomorrow'
    endif
    call g:quickmenu#append('seoul256-dark', 'call SwitchColorScheme("seoul256-dark")', '', '', 0, '')
    call g:quickmenu#append('seoul256-light', 'call SwitchColorScheme("seoul256-light")', '', '', 0, '')
    "}}}
    "{{{gruvbox*
    if g:VIM_Color_Scheme ==# 'gruvbox-dark'
        set background=dark
        colorscheme gruvbox
        let g:lightline.colorscheme = 'gruvbox'
    endif
    if g:VIM_Color_Scheme ==# 'gruvbox-light'
        set background=light
        colorscheme gruvbox
        let g:lightline.colorscheme = 'gruvbox'
    endif
    call g:quickmenu#append('gruvbox-dark', 'call SwitchColorScheme("gruvbox-dark")', '', '', 0, '')
    call g:quickmenu#append('gruvbox-light', 'call SwitchColorScheme("gruvbox-light")', '', '', 0, '')
    "}}}
    "{{{stellarized*
    if g:VIM_Color_Scheme ==# 'stellarized-dark'
        set background=dark
        colorscheme stellarized
        let g:lightline.colorscheme = 'stellarized_dark'
    endif
    if g:VIM_Color_Scheme ==# 'stellarized-light'
        set background=light
        colorscheme stellarized
        let g:lightline.colorscheme = 'stellarized_light'
    endif
    call g:quickmenu#append('stellarized-dark', 'call SwitchColorScheme("stellarized-dark")', '', '', 0, '')
    call g:quickmenu#append('stellarized-light', 'call SwitchColorScheme("stellarized-light")', '', '', 0, '')
    "}}}
    "{{{Tomorrow*
    if g:VIM_Color_Scheme ==# 'Tomorrow-light'
        colorscheme Tomorrow
        let g:lightline.colorscheme = 'Tomorrow'
    elseif g:VIM_Color_Scheme ==# 'Tomorrow-dark'
        colorscheme Tomorrow-Night-Eighties
        let g:lightline.colorscheme = 'Tomorrow_Night_Eighties'
    endif
    call g:quickmenu#append('Tomorrow-dark', 'call SwitchColorScheme("Tomorrow-dark")', '', '', 0, '')
    call g:quickmenu#append('Tomorrow-light', 'call SwitchColorScheme("Tomorrow-light")', '', '', 0, '')
    "}}}
    "{{{Atelier**
    "{{{Atelier_Cave*
    if g:VIM_Color_Scheme ==# 'Atelier_Cave-light'
        set background=light
        colorscheme Atelier_CaveDark
        let g:lightline.colorscheme = 'Atelier_Cave'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Cave-dark'
        set background=dark
        colorscheme Atelier_CaveLight
        let g:lightline.colorscheme = 'Atelier_Cave'
    endif
    call g:quickmenu#append('Atelier_Cave-dark', 'call SwitchColorScheme("Atelier_Cave-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Cave-light', 'call SwitchColorScheme("Atelier_Cave-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Dune*
    if g:VIM_Color_Scheme ==# 'Atelier_Dune-light'
        set background=light
        colorscheme Atelier_DuneDark
        let g:lightline.colorscheme = 'Atelier_Dune'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Dune-dark'
        set background=dark
        colorscheme Atelier_DuneLight
        let g:lightline.colorscheme = 'Atelier_Dune'
    endif
    call g:quickmenu#append('Atelier_Dune-dark', 'call SwitchColorScheme("Atelier_Dune-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Dune-light', 'call SwitchColorScheme("Atelier_Dune-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Estuary*
    if g:VIM_Color_Scheme ==# 'Atelier_Estuary-light'
        set background=light
        colorscheme Atelier_EstuaryDark
        let g:lightline.colorscheme = 'Atelier_Estuary'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Estuary-dark'
        set background=dark
        colorscheme Atelier_EstuaryLight
        let g:lightline.colorscheme = 'Atelier_Estuary'
    endif
    call g:quickmenu#append('Atelier_Estuary-dark', 'call SwitchColorScheme("Atelier_Estuary-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Estuary-light', 'call SwitchColorScheme("Atelier_Estuary-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Forest*
    if g:VIM_Color_Scheme ==# 'Atelier_Forest-light'
        set background=light
        colorscheme Atelier_ForestDark
        let g:lightline.colorscheme = 'Atelier_Forest'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Forest-dark'
        set background=dark
        colorscheme Atelier_ForestLight
        let g:lightline.colorscheme = 'Atelier_Forest'
    endif
    call g:quickmenu#append('Atelier_Forest-dark', 'call SwitchColorScheme("Atelier_Forest-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Forest-light', 'call SwitchColorScheme("Atelier_Forest-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Heath*
    if g:VIM_Color_Scheme ==# 'Atelier_Heath-light'
        set background=light
        colorscheme Atelier_HeathDark
        let g:lightline.colorscheme = 'Atelier_Heath'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Heath-dark'
        set background=dark
        colorscheme Atelier_HeathLight
        let g:lightline.colorscheme = 'Atelier_Heath'
    endif
    call g:quickmenu#append('Atelier_Heath-dark', 'call SwitchColorScheme("Atelier_Heath-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Heath-light', 'call SwitchColorScheme("Atelier_Heath-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Lakeside*
    if g:VIM_Color_Scheme ==# 'Atelier_Lakeside-light'
        set background=light
        colorscheme Atelier_LakesideDark
        let g:lightline.colorscheme = 'Atelier_Lakeside'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Lakeside-dark'
        set background=dark
        colorscheme Atelier_LakesideLight
        let g:lightline.colorscheme = 'Atelier_Lakeside'
    endif
    call g:quickmenu#append('Atelier_Lakeside-dark', 'call SwitchColorScheme("Atelier_Lakeside-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Lakeside-light', 'call SwitchColorScheme("Atelier_Lakeside-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Plateau*
    if g:VIM_Color_Scheme ==# 'Atelier_Plateau-light'
        set background=light
        colorscheme Atelier_PlateauDark
        let g:lightline.colorscheme = 'Atelier_Plateau'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Plateau-dark'
        set background=dark
        colorscheme Atelier_PlateauLight
        let g:lightline.colorscheme = 'Atelier_Plateau'
    endif
    call g:quickmenu#append('Atelier_Plateau-dark', 'call SwitchColorScheme("Atelier_Plateau-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Plateau-light', 'call SwitchColorScheme("Atelier_Plateau-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Savanna*
    if g:VIM_Color_Scheme ==# 'Atelier_Savanna-light'
        set background=light
        colorscheme Atelier_SavannaDark
        let g:lightline.colorscheme = 'Atelier_Savanna'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Savanna-dark'
        set background=dark
        colorscheme Atelier_SavannaLight
        let g:lightline.colorscheme = 'Atelier_Savanna'
    endif
    call g:quickmenu#append('Atelier_Savanna-dark', 'call SwitchColorScheme("Atelier_Savanna-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Savanna-light', 'call SwitchColorScheme("Atelier_Savanna-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Seaside*
    if g:VIM_Color_Scheme ==# 'Atelier_Seaside-light'
        set background=light
        colorscheme Atelier_SeasideDark
        let g:lightline.colorscheme = 'Atelier_Seaside'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Seaside-dark'
        set background=dark
        colorscheme Atelier_SeasideLight
        let g:lightline.colorscheme = 'Atelier_Seaside'
    endif
    call g:quickmenu#append('Atelier_Seaside-dark', 'call SwitchColorScheme("Atelier_Seaside-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Seaside-light', 'call SwitchColorScheme("Atelier_Seaside-light")', '', '', 0, '')
    "}}}
    "{{{Atelier_Sulphurpool*
    if g:VIM_Color_Scheme ==# 'Atelier_Sulphurpool-light'
        set background=light
        colorscheme Atelier_SulphurpoolDark
        let g:lightline.colorscheme = 'Atelier_Sulphurpool'
    elseif g:VIM_Color_Scheme ==# 'Atelier_Sulphurpool-dark'
        set background=dark
        colorscheme Atelier_SulphurpoolLight
        let g:lightline.colorscheme = 'Atelier_Sulphurpool'
    endif
    call g:quickmenu#append('Atelier_Sulphurpool-dark', 'call SwitchColorScheme("Atelier_Sulphurpool-dark")', '', '', 0, '')
    call g:quickmenu#append('Atelier_Sulphurpool-light', 'call SwitchColorScheme("Atelier_Sulphurpool-light")', '', '', 0, '')
    "}}}
    "}}}
endfunction
call ColorScheme()
"{{{InitBG()
function! InitBG()
    if empty($TERM_Emulator)
        let g:TransparentBG = 0
    else
        if $TERM_Emulator ==# 'konsole'
            let g:TransparentBG = 1
        else
            let g:TransparentBG = 0
        endif
    endif
endfunction
call InitBG()
"}}}
"{{{SwitchColorScheme()
function! SwitchColorScheme(name)
    let g:VIM_Color_Scheme = a:name
    call ColorScheme()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
"}}}
"{{{TransparentBG()
function! TransparentBG()
    if g:TransparentBG == 1
        hi Normal guibg=NONE ctermbg=NONE
    endif
endfunction
call TransparentBG()
"}}}
"{{{ToggleBG()
function! ToggleBG()
    if g:TransparentBG == 1
        let g:TransparentBG = 0
        set background=light
    elseif g:TransparentBG == 0
        let g:TransparentBG = 1
        call TransparentBG()
    endif
endfunction
"}}}
"}}}
"{{{vim-startify
let g:startify_session_dir = '~/.vim/sessions/'
let g:startify_files_number = 5
let g:startify_update_oldfiles = 1
" let g:startify_session_autoload = 1
" let g:startify_session_persistence = 1 " autoupdate sessions
let g:startify_session_delete_buffers = 1 " delete all buffers when loading or closing a session, ignore unsaved buffers
let g:startify_change_to_dir = 1 " when opening a file or bookmark, change to its directory
let g:startify_fortune_use_unicode = 1 " beautiful symbols
let g:startify_padding_left = 3 " the number of spaces used for left padding
let g:startify_session_remove_lines = ['setlocal', 'winheight'] " lines matching any of the patterns in this list, will be removed from the session file
let g:startify_session_sort = 1 " sort sessions by alphabet or modification time
let g:startify_custom_indices = ['1', '2', '3', '4', '5', '1', '2', '3', '4', '5'] " MRU indices
" line 579 for more details
if executable('toilet')
    let g:startify_custom_header =
                \ map(split(system('toilet -t -f tombstone SainnheParkArchLinux'), '\n'), '"   ". v:val')
else
    let g:startify_custom_header = [
                \ ' _,  _, _ _, _ _, _ _,_ __, __,  _, __, _,_  _, __,  _, _,_ _,  _ _, _ _,_ _  ,',
                \ "(_  /_\\ | |\\ | |\\ | |_| |_  |_) /_\\ |_) |_/ / \\ |_) / ` |_| |   | |\\ | | | '\\/",
                \ ', ) | | | | \| | \| | | |   |   | | | \ | \ |~| | \ \ , | | | , | | \| | |  /\ ',
                \ " ~  ~ ~ ~ ~  ~ ~  ~ ~ ~ ~~~ ~   ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  ~  ~ ~ ~~~ ~ ~  ~ `~' ~  ~",
                \ ]
endif
" costom startify list
let g:startify_lists = [
            \ { 'type': 'sessions',  'header': [" \ue62e Sessions"]       },
            \ { 'type': 'bookmarks', 'header': [" \uf5c2 Bookmarks"]      },
            \ { 'type': 'files',     'header': [" \ufa1eMRU Files"]            },
            \ { 'type': 'dir',       'header': [" \ufa1eMRU Files in ". getcwd()] },
            \ { 'type': 'commands',  'header': [" \uf085 Commands"]       },
            \ ]
highlight StartifyBracket ctermfg=240
highlight StartifyFooter  ctermfg=240
highlight StartifyHeader  ctermfg=114
highlight StartifyNumber  ctermfg=215
highlight StartifyPath    ctermfg=245
highlight StartifySlash   ctermfg=240
highlight StartifySpecial ctermfg=240
" on Start
if g:VIM_Explore ==# 'defx'
    function! DefxStartify()
        execute 'Startify'
        execute 'call ToggleDefx()'
        execute 'wincmd l'
    endfunction
    augroup Startify_Config
        autocmd VimEnter *
                    \   if !argc()
                    \ |   call DefxStartify()
                    \ | endif
        " on Enter
        autocmd User Startified nmap <silent><buffer> <CR> <plug>(startify-open-buffers)<Esc>:call ToggleDefx()<CR>
    augroup END
elseif g:VIM_Explore ==# 'nerdtree'
    function! NerdtreeStartify()
        execute 'Startify'
        execute 'NERDTreeToggle'
        execute 'wincmd l'
    endfunction
    augroup Startify_Config
        autocmd VimEnter *
                    \   if !argc()
                    \ |   call NerdtreeStartify()
                    \ | endif
        " on Enter
        autocmd User Startified nmap <silent><buffer> <CR> <plug>(startify-open-buffers):NERDTreeToggle<CR>
    augroup END
endif
" list of commands to be executed before save a session
let g:startify_session_before_save = [
            \ 'echo "Cleaning up before saving.."',
            \ 'silent! NERDTreeTabsClose',
            \ ]
" MRU skipped list, do not use ~
let g:startify_skiplist = [
            \ '/mnt/*',
            \ ]
"}}}
"{{{vim-signify
"{{{vim-signify-usage
" g? 显示帮助
function Help_vim_signify()
    echo "gj  next hunk\n"
    echo "gk  previous hunk\n"
    echo "gJ  last hunk\n"
    echo "gK  first hunk\n"
    echo "gt  :SignifyToggle\n"
    echo "gh  :SignifyToggleHighlight\n"
    echo "gr  :SignifyRefresh\n"
    echo "gd  :SignifyDebug\n"
    echo "g?  Show this help\n"
endfunction
nnoremap g? :call Help_vim_signify()<CR>
"}}}
let g:signify_realtime = 1
let g:signify_disable_by_default = 0
let g:signify_line_highlight = 0
let g:signify_sign_show_count = 1
let g:signify_sign_show_text = 1
let g:signify_difftool = 'diff'
let g:signify_sign_add = '+'
let g:signify_sign_delete = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = '!'
let g:signify_sign_changedelete = g:signify_sign_change
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gJ 9999<leader>gj
nmap <leader>gK 9999<leader>gk
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gr :SignifyRefresh<CR>
nnoremap <leader>gd :SignifyDebug<CR>
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)
let g:signify_vcs_list = [ 'git' ]  " 'accurev''bzr''cvs''darcs''fossil''git''hg''perforce''rcs''svn''tfs'
let g:signify_vcs_cmds = {
            \ 'git':      'git diff --no-color --no-ext-diff -U0 -- %f',
            \ 'hg':       'hg diff --config extensions.color=! --config defaults.diff= --nodates -U0 -- %f',
            \ 'svn':      'svn diff --diff-cmd %d -x -U0 -- %f',
            \ 'bzr':      'bzr diff --using %d --diff-options=-U0 -- %f',
            \ 'darcs':    'darcs diff --no-pause-for-gui --diff-command="%d -U0 %1 %2" -- %f',
            \ 'fossil':   'fossil set diff-command "%d -U 0" && fossil diff --unified -c 0 -- %f',
            \ 'cvs':      'cvs diff -U0 -- %f',
            \ 'rcs':      'rcsdiff -U0 %f 2>%n',
            \ 'accurev':  'accurev diff %f -- -U0',
            \ 'perforce': 'p4 info '. sy#util#shell_redirect('%n') . (has('win32') ? '' : ' env P4DIFF= P4COLORS=') .' p4 diff -du0 %f',
            \ 'tfs':      'tf diff -version:W -noprompt %f',
            \ }
let g:signify_vcs_cmds_diffmode = {
            \ 'git':      'git show HEAD:./%f',
            \ 'hg':       'hg cat %f',
            \ 'svn':      'svn cat %f',
            \ 'bzr':      'bzr cat %f',
            \ 'darcs':    'darcs show contents -- %f',
            \ 'cvs':      'cvs up -p -- %f 2>%n',
            \ 'perforce': 'p4 print %f',
            \ }
" let g:signify_skip_filetype = { 'vim': 1, 'c': 1 }
" let g:signify_skip_filename = { '/home/user/.vimrc': 1 }
"}}}
"{{{indentLine
"{{{indentLine-usage
" :LeadingSpaceToggle  切换显示Leading Space
" :IndentLinesToggle  切换显示indentLine
"}}}
let g:ExcludeIndentFileType_Universal = [ 'startify', 'defx', 'codi', 'help', 'man', 'neoman' ]
let g:ExcludeIndentFileType_Special = [ 'markdown', 'json' ]
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_char = '¦'  " ¦┆│⎸ ▏
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = g:ExcludeIndentFileType_Universal + g:ExcludeIndentFileType_Special
" let g:indentLine_setColors = 0  " disable set grey by default, use colorscheme instead
"}}}
"{{{vim-indent-guides
"{{{vim-indent-guides-usage
" :IndentGuidesToggle  切换显示vim-indent-guides
"}}}
let g:HasLoadIndentGuides = 0
function! InitIndentGuides()
    call plug#load('vim-indent-guides')
    let g:indent_guides_enable_on_vim_startup = 0
    let g:indent_guides_exclude_filetypes = g:ExcludeIndentFileType_Universal
    let g:indent_guides_color_change_percent = 10
    let g:indent_guides_guide_size = 1
    let g:indent_guides_default_mapping = 0
endfunction
function! ToggleIndentGuides()
    if g:HasLoadIndentGuides == 0
        call InitIndentGuides()
        let g:HasLoadIndentGuides = 1
    endif
    execute 'IndentGuidesToggle'
endfunction
"}}}
"{{{limelight.vim
"{{{limelight.vim-usage
" <leader>mf  toggle focus mode
"}}}
let g:limelight_default_coefficient = 0.7
nnoremap <leader>mf :Limelight!!<CR>
"}}}
"{{{goyo.vim
"{{{goyo.vim-usage
" <leader>mr  toggle reading mode
"}}}
let g:goyo_width = 95
let g:goyo_height = 85
let g:goyo_linenr = 0
"进入goyo模式后自动触发limelight,退出后则关闭
augroup Goyo_Config
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
augroup END
nnoremap <leader>mr :Goyo<CR>
"}}}
"{{{golden-ratio
"{{{golden-ratio-usage
" <A-g>  切换
"}}}
" 默认关闭
let g:golden_ratio_autocommand = 0
" Mapping
nmap <A-g> <Plug>(golden_ratio_toggle)
"}}}
" Productivity
"{{{LanguageClient-neovim
if g:VIM_LSP_Client ==# 'lcn'
    "{{{LanguageClient-neovim-usage
    " l 开始
    "}}}
    " Server Register
    let g:LanguageClient_serverCommands = {
                \ 'c': ['ccls'],
                \ 'cpp': ['ccls'],
                \ 'css': ['css-languageserver', '--stdio'],
                \ 'html': ['html-languageserver', '--stdio'],
                \ 'python': ['pyls'],
                \ 'sh': ['bash-language-server', 'start']
                \ }
    " AutoStart
    let g:LanguageClient_autoStart = 1
    " hoverPreview: Never Auto Always
    let g:LanguageClient_hoverPreview = 'Always'
    " Override Snippets
    let g:LanguageClient_hasSnippetSupport = 0
    " Completion
    set omnifunc=LanguageClient#complete
    " Formatting
    set formatexpr=LanguageClient_textDocument_rangeFormatting()
    " Interface
    " let g:LanguageClient_selectionUI = 'fzf'  " fzf quickfix location-list
    " Mappings
    vnoremap <silent> lf :call LanguageClient#textDocument_rangeFormatting()<CR>
    nnoremap <silent> l :call quickmenu#toggle(4)<CR>
    if g:VIM_Fuzzy_Finder ==# 'denite'
        call quickmenu#current(4)
        call quickmenu#reset()
        call g:quickmenu#append('# LSC', '')
        call g:quickmenu#append('Code Action', 'Denite codeAction', 'Show code actions at current location.', '', 0, 'a')
        call g:quickmenu#append('Symbol', 'Denite documentSymbol', "List of current buffer's symbols.", '', 0, 's')
        call g:quickmenu#append('Workspace Symbol', 'Denite workspaceSymbol', "List of project's symbols.", '', 0, 'S')
        call g:quickmenu#append('Definition', 'call LanguageClient#textDocument_definition()', 'Goto definition under cursor.', '', 0, 'd')
        call g:quickmenu#append('Type Definition', 'call LanguageClient#textDocument_typeDefinition()', 'Goto type definition under cursor.', '', 0, 'D')
        call g:quickmenu#append('Reference', 'Denite references', 'List all references of identifier under cursor.', '', 0, 'r')
        call g:quickmenu#append('Rename', 'call LanguageClient#textDocument_rename()', 'Rename identifier under cursor.', '', 0, 'R')
        call g:quickmenu#append('Hover', 'call LanguageClient#textDocument_hover()', 'Show type info (and short doc) of identifier under cursor.', '', 0, 'h')
        call g:quickmenu#append('Implementation', 'call LanguageClient#textDocument_implementation()', 'Goto implementation under cursor.', '', 0, 'i')
        call g:quickmenu#append('Formatting', 'call LanguageClient#textDocument_formatting()', 'Format current document.', '', 0, 'f')
        call g:quickmenu#append('Highlight', 'call LanguageClient#textDocument_documentHighlight()', 'Highlight usages of the symbol under the cursor.', '', 0, 'l')
        call g:quickmenu#append('Clear Highlight', 'call LanguageClient#clearDocumentHighlight()', 'Clear the symbol usages highlighting.', '', 0, 'L')
        call g:quickmenu#append('Apply Edit', 'call LanguageClient#workspace_applyEdit()', 'Apply a workspace edit.', '', 0, 'A')
        call g:quickmenu#append('Command', 'call LanguageClient#workspace_executeCommand()', 'Execute a workspace command.', '', 0, 'c')
        call g:quickmenu#append('Notify', 'call LanguageClient#Notify()', 'Send a notification to the current language server.', '', 0, 'n')
        call g:quickmenu#append('Start LSC', 'LanguageClientStart', '', '', 0, '$')
        call g:quickmenu#append('Stop LSC', 'LanguageClientStop', '', '', 0, '#')
    else
        call quickmenu#current(4)
        call quickmenu#reset()
        call g:quickmenu#append('# LSC', '')
        call g:quickmenu#append('Code Action', 'call LanguageClient#textDocument_codeAction()', 'Show code actions at current location.', '', 0, 'a')
        call g:quickmenu#append('Symbol', 'call LanguageClient#textDocument_documentSymbol()', "List of current buffer's symbols.", '', 0, 's')
        call g:quickmenu#append('Workspace Symbol', 'call LanguageClient#workspace_symbol()', "List of project's symbols.", '', 0, 'S')
        call g:quickmenu#append('Definition', 'call LanguageClient#textDocument_definition()', 'Goto definition under cursor.', '', 0, 'd')
        call g:quickmenu#append('Type Definition', 'call LanguageClient#textDocument_typeDefinition()', 'Goto type definition under cursor.', '', 0, 'D')
        call g:quickmenu#append('Reference', 'call LanguageClient#textDocument_references()', 'List all references of identifier under cursor.', '', 0, 'r')
        call g:quickmenu#append('Rename', 'call LanguageClient#textDocument_rename()', 'Rename identifier under cursor.', '', 0, 'R')
        call g:quickmenu#append('Hover', 'call LanguageClient#textDocument_hover()', 'Show type info (and short doc) of identifier under cursor.', '', 0, 'h')
        call g:quickmenu#append('Implementation', 'call LanguageClient#textDocument_implementation()', 'Goto implementation under cursor.', '', 0, 'i')
        call g:quickmenu#append('Formatting', 'call LanguageClient#textDocument_formatting()', 'Format current document.', '', 0, 'f')
        call g:quickmenu#append('Highlight', 'call LanguageClient#textDocument_documentHighlight()', 'Highlight usages of the symbol under the cursor.', '', 0, 'l')
        call g:quickmenu#append('Clear Highlight', 'call LanguageClient#clearDocumentHighlight()', 'Clear the symbol usages highlighting.', '', 0, 'L')
        call g:quickmenu#append('Apply Edit', 'call LanguageClient#workspace_applyEdit()', 'Apply a workspace edit.', '', 0, 'A')
        call g:quickmenu#append('Command', 'call LanguageClient#workspace_executeCommand()', 'Execute a workspace command.', '', 0, 'c')
        call g:quickmenu#append('Notify', 'call LanguageClient#Notify()', 'Send a notification to the current language server.', '', 0, 'n')
        call g:quickmenu#append('Start LSC', 'LanguageClientStart', '', '', 0, '$')
        call g:quickmenu#append('Stop LSC', 'LanguageClientStop', '', '', 0, '#')
    endif
    let g:LanguageClient_diagnosticsDisplay = {
                \ 1: {
                \ 'name': 'Error',
                \ 'texthl': 'ALEError',
                \ 'signText': "\uf65b",
                \ 'signTexthl': 'ALEErrorSign',
                \ },
                \ 2: {
                \ 'name': 'Warning',
                \ 'texthl': 'ALEWarning',
                \ 'signText': "\uf421",
                \ 'signTexthl': 'ALEWarningSign',
                \ },
                \ 3: {
                \ 'name': 'Information',
                \ 'texthl': 'ALEInfo',
                \ 'signText': "\uf7fb",
                \ 'signTexthl': 'ALEInfoSign',
                \ },
                \ 4: {
                \ 'name': 'Hint',
                \ 'texthl': 'ALEInfo',
                \ 'signText': "\uf68a",
                \ 'signTexthl': 'ALEInfoSign',
                \ },
                \ }
    " Events
    augroup LanguageClient_config
        autocmd!
        autocmd User LanguageClientStarted setlocal signcolumn=auto
        autocmd User LanguageClientStopped setlocal signcolumn=auto
    augroup END
    "}}}
    "{{{vim-lsp
elseif g:VIM_LSP_Client ==# 'vim-lsp'
    "{{{vim-lsp-usage
    " mappings
    " :LspStatus
    "}}}
    let g:lsp_auto_enable = 1
    let g:lsp_signs_enabled = 1         " enable signs
    let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
    let g:lsp_signs_error = {'text': "\uf65b"}
    let g:lsp_signs_warning = {'text': "\uf421"}
    let g:lsp_signs_hint = {'text': "\uf68a"}
    augroup VIM_LSP_Register
        autocmd!
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'ccls',
                    \ 'cmd': {server_info->['ccls']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
                    \ })
        " au User lsp_setup call lsp#register_server({
        " \ 'name': 'clangd',
        " \ 'cmd': {server_info->['clangd']},
        " \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        "             \ })
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'html-languageserver',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
                    \ 'whitelist': ['html', 'htm', 'xml'],
                    \ })
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'css-languageserver',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
                    \ 'whitelist': ['css', 'less', 'sass'],
                    \ })
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'python-languageserver',
                    \ 'cmd': {server_info->['pyls']},
                    \ 'whitelist': ['python'],
                    \ })
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'bash-languageserver',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
                    \ 'whitelist': ['sh'],
                    \ })
    augroup END
    nnoremap <silent> l :call quickmenu#toggle(4)<CR>
    call quickmenu#current(4)
    call quickmenu#reset()
    call g:quickmenu#append('# LSC', '')
    call g:quickmenu#append('Code Action', 'LspCodeAction', 'Gets a list of possible commands that can be applied to a file so it can be fixed (quickfix)', '', 0, 'a')
    call g:quickmenu#append('DocumentSymbol', 'LspDocumentSymbol', 'Gets the symbols for the current document.', '', 0, 's')
    call g:quickmenu#append('WorkspaceSymbols', 'LspWorkspaceSymbols', 'Search and show workspace symbols.', '', 0, 'S')
    call g:quickmenu#append('Definition', 'LspDefinition', 'Go to definition.', '', 0, 'd')
    call g:quickmenu#append('TypeDefinition', 'LspTypeDefinition', 'Go to the type definition.', '', 0, 'D')
    call g:quickmenu#append('Diagnostics', 'LspDocumentDiagnostics', 'Gets the current document diagnostics.', '', 0, 'e')
    call g:quickmenu#append('References', 'LspReferences', 'Find all references.', '', 0, 'r')
    call g:quickmenu#append('Rename', 'LspRename', 'Rename the symbol.', '', 0, 'R')
    call g:quickmenu#append('Hover', 'LspHover', 'Gets the hover information. Close preview window: <c-w><c-z>', '', 0, 'h')
    call g:quickmenu#append('Implementation', 'LspImplementation', 'Find all implementation of interface.', '', 0, 'i')
    call g:quickmenu#append('DocumentFormat', 'LspDocumentFormat', 'Format the entire document.', '', 0, 'f')
    call g:quickmenu#append('Status', 'LspStatus', '', '', 0, '*')
    call g:quickmenu#append('Start LSC', 'call lsp#enable()', '', '', 0, '$')
    call g:quickmenu#append('Stop LSC', 'call lsp#disable()', '', '', 0, '#')
    call g:quickmenu#append('NextError', 'LspNextError', 'Jump to Next err diagnostics', '', 0, '<down>')
    call g:quickmenu#append('PreviousError', 'LspPreviousError', 'Jump to Previous err diagnostics', '', 0, '<up>')
    vnoremap lf :LspDocumentRangeFormat<CR>
endif
"}}}
"{{{ultisnips
if g:VIM_Snippets ==# 'ultisnips'
    "{{{ultisnips-usage
    " 在补全插件中，Ctrl+L展开
    " 展开后，Ctrl+J和Ctrl+K跳转
    "}}}
    let g:UltiSnipsRemoveSelectModeMappings = 0
    let g:UltiSnipsJumpForwardTrigger       = '<C-j>'
    let g:UltiSnipsJumpBackwardTrigger      = '<C-k>'
    " let g:UltiSnipsExpandTrigger            = '<A-z>se'
    " let g:UltiSnipsListSnippets = "<A-y>l"
    " let g:UltiSnipsEditSplit="vertical"
    "}}}
    "{{{neosnippet.vim
    "{{{neosnippet-usage
    " <C-l> 展开
    " <C-K>跳转到下一个
    "}}}
elseif g:VIM_Snippets ==# 'neosnippet'
    if g:VIM_Completion_Framework !=# 'coc'
        imap <C-l>     <Plug>(neosnippet_expand)
        smap <C-l>     <Plug>(neosnippet_expand)
        xmap <C-l>     <Plug>(neosnippet_expand)
        imap <C-k>     <Plug>(neosnippet_jump)
        smap <C-k>     <Plug>(neosnippet_jump)
        xmap <C-k>     <Plug>(neosnippet_jump)
    endif
    if has('conceal')
        set conceallevel=2 concealcursor=niv
    endif
    let g:neosnippet#snippets_directory='~/.vim/plugins/vim-snippets/snippets'
endif
"}}}
"{{{deoplete.nvim
if g:VIM_Completion_Framework ==# 'deoplete'
    "{{{deoplete-usage
    " <Tab> <S-Tab> 分别向下和向上选中，
    " <S-Tab>当没有显示补全栏的时候手动呼出补全栏
    " :ToggleDeopleteWords  切换words补全
    "}}}
    "{{{extensions
    let g:necosyntax#min_keyword_length = 3
    " deoplete-clang
    " https://github.com/zchee/deoplete-clang
    " deoplete-jedi
    " https://github.com/zchee/deoplete-jedi
    "}}}
    let g:deoplete#enable_at_startup = 0
    augroup Deoplete_Au
        autocmd!
        autocmd InsertEnter * call deoplete#enable()
    augroup END
    call deoplete#custom#option({
                \ 'auto_complete_delay': 0,
                \ 'smart_case': v:true,
                \ })
    call deoplete#custom#source('LanguageClient',
                \ 'min_pattern_length',
                \ 2)
    if g:VIM_Snippets ==# 'ultisnips'
        let g:UltiSnipsExpandTrigger            = '<C-l>'
    endif
    inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
    inoremap <silent><expr> <S-TAB>
                \ pumvisible() ? "\<C-p>" :
                \ <SID>check_back_space() ? "\<S-TAB>" :
                \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction"}}}
    inoremap <expr> <down> pumvisible() ? deoplete#close_popup()."\<down>" : "\<down>"
    inoremap <expr> <up> pumvisible() ? deoplete#close_popup()."\<up>" : "\<up>"
    inoremap <expr> <CR> pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
    function! Func_ToggleDeopleteWords()
        setlocal dictionary+=/usr/share/dict/words
        setlocal dictionary+=/usr/share/dict/american-english
        call deoplete#custom#source(
                    \ 'dictionary', 'min_pattern_length', 4)
    endfunction
    command ToggleDeopleteWords call Func_ToggleDeopleteWords()
    set completeopt-=preview
    function Multiple_cursors_before()
        let g:deoplete#disable_auto_complete = 1
    endfunction
    function Multiple_cursors_after()
        let g:deoplete#disable_auto_complete = 0
    endfunction
    "}}}
    "{{{ncm2
elseif g:VIM_Completion_Framework ==# 'ncm2'
    "{{{ncm2-usage
    " <Tab> <S-Tab> 分别向下和向上选中，
    " <S-Tab>当没有显示补全栏的时候手动呼出补全栏
    " :ToggleNcm2Look  切换ncm2-look
    "}}}
    "{{{ncm2-extensions
    "{{{ncm2-ultisnips
    if g:VIM_Snippets ==# 'ultisnips'
        let g:UltiSnipsExpandTrigger            = '<A-z>``zsf'
        inoremap <silent> <expr> <C-l> ncm2_ultisnips#expand_or("\<C-l>", 'n')
        "}}}
        "{{{neosnippet.vim
    elseif g:VIM_Snippets ==# 'neosnippet'
    endif
    "}}}
    "{{{ncm2-pyclang
    let g:ncm2_pyclang#library_path = '/usr/lib'
    "}}}
    "{{{ncm2-look.vim
    " enable ncm2 for all buffer
    augroup ncm2_enable_for_buffer
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END
    " note that must keep noinsert in completeopt, the others is optional
    set completeopt=noinsert,menuone,noselect
    " Enable && Disable Globally
    let g:ncm2_look_enabled = 0
    " Enable Command
    function! ToggleNcm2LookFunc()
        if g:ncm2_look_enabled == 1
            let g:ncm2_look_enabled = 0
        elseif g:ncm2_look_enabled == 0
            let g:ncm2_look_enabled = 1
        endif
    endfunction
    command ToggleNcm2Look call ToggleNcm2LookFunc()
    " autocmd BufNewFile,BufRead *.md call ToggleNcm2LookFunc()
    " Symbol
    let g:ncm2_look_mark = "\uf02d"
    "}}}
    "}}}
    augroup NCM2_Config
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
        autocmd TextChangedI * call ncm2#auto_trigger()  " enable auto complete for `<backspace>`, `<c-w>` keys
    augroup END
    set completeopt=noinsert,menuone,noselect
    inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
    imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Plug>(ncm2_manual_trigger)\<C-n>"
    inoremap <expr> <down> pumvisible() ? "\<left>\<right>\<down>" : "\<down>"
    inoremap <expr> <up> pumvisible() ? "\<left>\<right>\<up>" : "\<up>"
    inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
    "}}}
    "{{{asyncomplete
    "{{{asyncomplete-usage
    " <Tab> <S-Tab> 分别向下和向上选中，
    " <S-Tab>当没有显示补全栏的时候手动呼出补全栏
    "}}}
elseif g:VIM_Completion_Framework ==# 'asyncomplete'
    inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
    imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Plug>(asyncomplete_force_refresh)\<C-n>"
    inoremap <expr> <down> pumvisible() ? "\<left>\<right>\<down>" : "\<down>"
    inoremap <expr> <up> pumvisible() ? "\<left>\<right>\<up>" : "\<up>"
    inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
    let g:UltiSnipsExpandTrigger            = '<C-l>'
    let g:asyncomplete_remove_duplicates = 1
    let g:asyncomplete_smart_completion = 1
    let g:asyncomplete_auto_popup = 1
    set completeopt-=preview
    augroup Asyncomplete_Au
        autocmd!
        autocmd InsertEnter * call Asyncomplete_Register()
    augroup END
    function! Asyncomplete_Register()
        call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
                    \ 'name': 'buffer',
                    \ 'whitelist': ['*'],
                    \ 'completor': function('asyncomplete#sources#buffer#completor'),
                    \ }))
        call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
                    \ 'name': 'file',
                    \ 'whitelist': ['*'],
                    \ 'priority': 10,
                    \ 'completor': function('asyncomplete#sources#file#completor')
                    \ }))
        call asyncomplete#register_source(asyncomplete#sources#neoinclude#get_source_options({
                    \ 'name': 'neoinclude',
                    \ 'whitelist': ['c', 'cpp'],
                    \ 'refresh_pattern': '\(<\|"\|/\)$',
                    \ 'completor': function('asyncomplete#sources#neoinclude#completor'),
                    \ }))
        call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
                    \ 'name': 'necosyntax',
                    \ 'whitelist': ['*'],
                    \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
                    \ }))
        call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
                    \ 'name': 'necovim',
                    \ 'whitelist': ['vim'],
                    \ 'completor': function('asyncomplete#sources#necovim#completor'),
                    \ }))
        if g:VIM_Snippets ==# 'ultisnips'
            call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
                        \ 'name': 'ultisnips',
                        \ 'whitelist': ['*'],
                        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
                        \ }))
        elseif g:VIM_Snippets ==# 'neosnippet'
            call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
                        \ 'name': 'neosnippet',
                        \ 'whitelist': ['*'],
                        \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
                        \ }))
        endif
    endfunction
    "}}}
    "{{{coc.nvim
elseif g:VIM_Completion_Framework ==# 'coc'
    augroup Load_Coc
        autocmd!
        autocmd InsertEnter * call CocInit()
    augroup END
    let g:Has_Load_Coc = 0
    function! CocInit()
        if g:Has_Load_Coc == 0
            let g:Has_Load_Coc = 1
            call Func_Coc()
        endif
    endfunction
    function! Func_Coc()
        "{{{coc.nvim-usage
        " 主quickmenu中打开COC
        "}}}
        let g:Has_Load_Coc = 1
        if g:VIM_Snippets ==# 'ultisnips'
            call plug#load('ultisnips', 'vim-snippets')
        elseif g:VIM_Snippets ==# 'neosnippet'
            call plug#load('neosnippet.vim', 'neosnippet-snippets', 'vim-snippets')
        endif
        call plug#load('coc.nvim', 'neco-vim', 'coc-neco', 'coc-action-source.nvim')
        if g:VIM_Snippets ==# 'ultisnips'
            let g:UltiSnipsExpandTrigger            = '<A-z>``zsx'
        endif
        set completeopt-=preview
        inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
        imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-n>"
        imap <C-l> <C-y>
        inoremap <expr> <down> pumvisible() ? "\<left>\<right>\<down>" : "\<down>"
        inoremap <expr> <up> pumvisible() ? "\<left>\<right>\<up>" : "\<up>"
        inoremap <expr> <CR> pumvisible() ? "\<left>\<right>\<CR>" : "\<CR>"
        augroup CocAu
            autocmd!
            autocmd CursorHoldI,CursorMovedI * call CocAction('showSignatureHelp')
        augroup END
        nnoremap <silent> l :call quickmenu#toggle(5)<CR>
        vnoremap <silent> lf :call CocActionAsync('format')<CR>
        let g:CurrentLSC = 5
        function! Toggle_LSC()
            if g:CurrentLSC == 4
                let g:CurrentLSC = 5
                nnoremap <silent> l :call quickmenu#toggle(5)<CR>
                vnoremap <silent> lf :call CocActionAsync('format')<CR>
            elseif g:CurrentLSC == 5
                let g:CurrentLSC = 4
                nnoremap <silent> l :call quickmenu#toggle(4)<CR>
                if g:VIM_LSP_Client ==# 'lcn'
                    vnoremap <silent> lf :call LanguageClient#textDocument_rangeFormatting()<CR>
                elseif g:VIM_LSP_Client ==# 'vim-lsp'
                    vnoremap lf :LspDocumentRangeFormat<CR>
                endif
            endif
        endfunction
        call quickmenu#current(6)
        call quickmenu#reset()
        call g:quickmenu#append('# COC Menu', '')
        call g:quickmenu#append('Action', 'Denite coc-action', '', '', 0, '*')
        call g:quickmenu#append('Toggle LSC', 'call Toggle_LSC()', '', '', 0, 't')
        call g:quickmenu#append('Extension Commands', 'Denite coc-command', '', '', 0, 'c')
        call g:quickmenu#append('Extension', 'Denite coc-extension', '', '', 0, 'e')
        call g:quickmenu#append('Service', 'Denite coc-service', '', '', 0, 'm')
        call g:quickmenu#append('Edit COC Config', 'CocConfig', '', '', 0, 'E')
        call g:quickmenu#append('Update Extensions', 'CocUpdate', '', '', 0, 'U')
        call g:quickmenu#append('Disable COC', 'CocDisable', '', '', 0, '#')
        call g:quickmenu#append('Enable COC', 'CocEnable', '', '', 0, '$')
        call g:quickmenu#append('Restart COC', 'CocRestart', '', '', 0, '@')
        call g:quickmenu#append('Rebuild Extensions', 'CocRebuild', '', '', 0, 'B')
        call g:quickmenu#append('Help', 'Denite output:nnoremap output:vnoremap -input="<Plug>(coc)"', '', '', 0, '?')
        call quickmenu#current(5)
        call quickmenu#reset()
        call g:quickmenu#append('Code Action', "call CocActionAsync('codeAction')", 'prompty for a code action and do it.', '', 0, 'a')
        call g:quickmenu#append('Code Lens Action', "call CocActionAsync('codeLensAction')", 'Invoke command for codeLens of current line (or the line contains codeLens just before).', '', 0, 'A')
        call g:quickmenu#append('Symbols', 'Denite coc-symbols', '', '', 0, 's')
        call g:quickmenu#append('Symbols Workspace', 'Denite coc-workspace', '', '', 0, 'S')
        call g:quickmenu#append('Definition', "call CocActionAsync('jumpDefinition')", 'jump to definition position of current symbol.', '', 0, 'd')
        call g:quickmenu#append('Type Definition', "call CocActionAsync('jumpTypeDefinition')", 'Jump to type definition position of current symbol.', '', 0, 'D')
        call g:quickmenu#append('Diagnostics', "call CocActionAsync('diagnosticInfo')", 'Show diagnostic message at current position, no truncate.', '', 0, 'e')
        call g:quickmenu#append('Diagnostic Lists', 'Denite coc-diagnostic', '', '', 0, 'E')
        call g:quickmenu#append('References', "call CocActionAsync('jumpReferences')", 'Jump to references position of current symbol.', '', 0, 'r')
        call g:quickmenu#append('Rename', "call CocActionAsync('rename')", 'Do rename for symbol under cursor position.', '', 0, 'R')
        call g:quickmenu#append('Hover', "call CocActionAsync('doHover')", 'Show documentation of current word at preview window.', '', 0, 'h')
        call g:quickmenu#append('Implementation', "call CocActionAsync('jumpImplementation')", 'Jump to implementation position of current symbol.', '', 0, 'i')
        call g:quickmenu#append('Format', "call CocActionAsync('format')", 'Format current buffer using language server.', '', 0, 'f')
        call g:quickmenu#append('Highlight', "call CocActionAsync('highlight')", 'Highlight symbols under cursor', '', 0, 'l')
        call g:quickmenu#append('Open Link', "call CocActionAsync('openLink')", 'Open link under cursor.', '', 0, 'L')
        call g:quickmenu#append('Command', "call CocActionAsync('runCommand')", 'Run global command provided by language server.', '', 0, 'c')
        function! Install_COC_Sources()
            execute 'CocInstall coc-dictionary'
            execute 'CocInstall coc-tag'
            execute 'CocInstall coc-word'
            execute 'CocInstall coc-emoji'
            execute 'CocInstall coc-ultisnips'
            execute 'CocInstall coc-neosnippet'
            execute 'CocInstall coc-html'
            execute 'CocInstall coc-css'
            execute 'CocInstall coc-eslint'
            execute 'CocInstall coc-stylelint'
            execute 'CocInstall coc-emmet'
            execute 'CocInstall coc-pyls'
            execute 'CocInstall https://github.com/andys8/vscode-jest-snippets.git#master'
            "coc.preferences.snippetIndicator": "\ue796",
            "coc.preferences.minTriggerInputLength": 1,
            "coc.preferences.diagnostic.errorSign": "\uf00d",
            "coc.preferences.diagnostic.warningSign": "\uf529",
            "coc.preferences.diagnostic.infoSign": "ℹ",
            "coc.preferences.diagnostic.hintSign": "➤",
            "https://github.com/neoclide/coc.nvim/wiki/Language-servers
        endfunction
    endfunction
    "}}}
    "{{{neocomplete.vim
elseif g:VIM_Completion_Framework ==# 'neocomplete'
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#auto_complete_delay = 50
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#skip_auto_completion_time = ''
    set completeopt-=preview
    augroup NeocompleteAu
        autocmd!
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END
    let g:UltiSnipsExpandTrigger            = '<C-l>'
    inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
    imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : neocomplete#start_manual_complete()."\<C-n>"
    inoremap <expr> <down> pumvisible() ? neocomplete#smart_close_popup()."\<down>" : "\<down>"
    inoremap <expr> <up> pumvisible() ? neocomplete#smart_close_popup()."\<up>" : "\<up>"
    inoremap <expr> <CR> pumvisible() ? "\<C-y>".neocomplete#smart_close_popup()."\<CR>" : "\<CR>"
endif
"}}}
"{{{denite.nvim
if g:VIM_Fuzzy_Finder ==# 'denite'
    "{{{denite.nvim-usage
    " f  cwd search
    " F  pwd search
    function! Help_denite_mappings()
        echo 'customized mappings'
        echo ''
        echo '"insert" mode mappings.'
        echo '{key}           {mapping}'
        echo '--------        -----------------------------'
        echo '<C-j>           <denite:move_to_next_line>'
        echo '<C-k>           <denite:move_to_previous_line>'
        echo '<S-left>        <denite:move_caret_to_head>'
        echo '<S-right>       <denite:move_caret_to_tail>'
        echo '<C-Space>       <denite:enter_mode:normal>'
        echo '<C-v>           <denite:paste_from_register>'
        echo '<C-p>           <denite:do_action:preview>'
        echo '<C-d>           <denite:do_action:delete>'
        echo '<C-e>           <denite:do_action:edit>'
        echo '<S-Tab>         <denite:do_action:cd>'
        echo '"normal" mode mappings.'
        echo '{key}           {mapping}'
        echo '--------        -----------------------------'
        echo ''
        echo ':h denite-key-mappings'
        echo ''
        echo ''
        echo 'default mappings'
        echo ''
        echo '{key}           {mapping}'
        echo '--------        -----------------------------'
        echo '<C-M>           <denite:do_action:default>'
        echo '<C-Z>           <denite:suspend>'
        echo '<CR>            <denite:do_action:default>'
        echo '<Esc>           <denite:leave_mode>'
        echo '<Tab>           <denite:choose_action>'
        echo '"insert" mode mappings.'
        echo '{key}           {mapping}'
        echo '--------        -----------------------------'
        echo '<BS>            <denite:delete_char_before_caret>'
        echo '<C-B>           <denite:move_caret_to_head>'
        echo '<C-E>           <denite:move_caret_to_tail>'
        echo '<C-G>           <denite:move_to_next_line>'
        echo '<C-H>           <denite:delete_char_before_caret>'
        echo '<C-J>           <denite:input_command_line>'
        echo '<C-K>           <denite:insert_digraph>'
        echo '<C-L>           <denite:redraw>'
        echo '<C-Left>        <denite:move_caret_to_one_word_left>'
        echo '<C-N>           <denite:assign_next_text>'
        echo '<C-O>           <denite:enter_mode:normal>'
        echo '<C-P>           <denite:assign_previous_text>'
        echo '<C-Q>           <denite:insert_special>'
        echo '<C-R>           <denite:paste_from_register>'
        echo '<C-Right>       <denite:move_caret_to_one_word_right>'
        echo '<C-T>           <denite:move_to_previous_line>'
        echo '<C-U>           <denite:delete_entire_text>'
        echo '<C-V>           <denite:do_action:preview>'
        echo '<C-W>           <denite:delete_word_before_caret>'
        echo '<DEL>           <denite:delete_word_under_caret>'
        echo '<Down>          <denite:assign_next_matched_text>'
        echo '<End>           <denite:move_caret_to_tail>'
        echo '<Home>          <denite:move_caret_to_head>'
        echo '<Insert>        <denite:toggle_insert_mode>'
        echo '<Left>          <denite:move_caret_to_left>'
        echo '<PageDown>      <denite:assign_next_text>'
        echo '<PageUp>        <denite:assign_previous_text>'
        echo '<Right>         <denite:move_caret_to_right>'
        echo '<S-Down>        <denite:assign_next_text>'
        echo '<S-Left>        <denite:move_caret_to_one_word_left>'
        echo '<S-Right>       <denite:move_caret_to_one_word_right>'
        echo '<S-Up>          <denite:assign_previous_text>'
        echo '<Up>            <denite:assign_previous_matched_text>'
        echo '"normal" mode mappings.'
        echo '{key}           {mapping}'
        echo '--------        -----------------------------'
        echo '$               <denite:move_caret_to_tail>'
        echo '*               <denite:toggle_select_all>'
        echo '0               <denite:move_caret_to_head>'
        echo '<C-B>           <denite:scroll_page_backwards>'
        echo '<C-D>           <denite:scroll_window_downwards>'
        echo '<C-E>           <denite:scroll_window_up_one_line>'
        echo '<C-F>           <denite:scroll_page_forwards>'
        echo '<C-L>           <denite:redraw>'
        echo '<C-R>           <denite:restart>'
        echo '<C-U>           <denite:scroll_window_upwards>'
        echo '<C-Y>           <denite:scroll_window_down_one_line>'
        echo '<C-w>P          <denite:wincmd:P>'
        echo '<C-w>W          <denite:wincmd:W>'
        echo '<C-w>b          <denite:wincmd:b>'
        echo '<C-w>h          <denite:wincmd:h>'
        echo '<C-w>j          <denite:wincmd:j>'
        echo '<C-w>k          <denite:wincmd:k>'
        echo '<C-w>l          <denite:wincmd:l>'
        echo '<C-w>p          <denite:wincmd:p>'
        echo '<C-w>t          <denite:wincmd:t>'
        echo '<C-w>w          <denite:wincmd:w>'
        echo '<Space>         <denite:toggle_select_down>'
        echo 'A               <denite:append_to_line>'
        echo 'G               <denite:move_to_last_line>'
        echo 'H               <denite:move_to_top>'
        echo 'I               <denite:insert_to_head>'
        echo 'L               <denite:move_to_bottom>'
        echo 'M               <denite:print_messages>'
        echo 'P               <denite:change_path>'
        echo 'S               <denite:change_line>'
        echo 'U               <denite:move_up_path>'
        echo 'X               <denite:quick_move>'
        echo 'a               <denite:append>'
        echo 'b               <denite:move_caret_to_one_word_left>'
        echo 'cc              <denite:change_line>'
        echo 'cw              <denite:change_word>'
        echo 'd               <denite:do_action:delete>'
        echo 'e               <denite:do_action:edit>'
        echo 'gg              <denite:move_to_first_line>'
        echo 'h               <denite:move_caret_to_left>'
        echo 'i               <denite:enter_mode:insert>'
        echo 'j               <denite:move_to_next_line>'
        echo 'k               <denite:move_to_previous_line>'
        echo 'l               <denite:move_caret_to_right>'
        echo 'n               <denite:do_action:new>'
        echo 'p               <denite:do_action:preview>'
        echo 'q               <denite:quit>'
        echo 's               <denite:change_char>'
        echo 't               <denite:do_action:tabopen>'
        echo 'w               <denite:move_caret_to_next_word>'
        echo 'x               <denite:delete_char_under_caret>'
        echo 'y               <denite:do_action:yank>'
        echo 'zb              <denite:scroll_cursor_to_bottom>'
        echo 'zt              <denite:scroll_cursor_to_top>'
        echo 'zz              <denite:scroll_cursor_to_middle>'
        echo '<ScrollWheelUp>         <denite:scroll_window_down_one_line>'
        echo '<ScrollWheelDown>       <denite:scroll_window_downwards>'
    endfunction
    "}}}
    "{{{quickmenu
    " :h denite-commands
    " :h denite-options
    call quickmenu#current(1)
    call quickmenu#reset()
    noremap <silent> f :call quickmenu#toggle(1)<cr>
    call g:quickmenu#append('# Denite', '')
    call g:quickmenu#append('      Fly Grep', 'FlyGrep', '', '', 0, "\uf1d9")
    call g:quickmenu#append('      Source', 'Denite source', '', '', 0, '#')
    if g:VIM_Linter ==# 'ale'
        call g:quickmenu#append('      Lint', 'Denite ale', '', '', 0, '>')
    elseif g:VIM_Linter ==# 'neomake'
        call g:quickmenu#append('      Lint', 'Denite neomake', '', '', 0, '>')
    endif
    call g:quickmenu#append('      Line Buffer', 'Denite line:buffers', '', '', 0, 'l')
    call g:quickmenu#append('      Line All', 'Denite line:all', '', '', 0, 'L')
    call g:quickmenu#append('  Line Backward', 'Denite line:backward', '', '', 0, 'L<up>')
    call g:quickmenu#append('Line Forward', 'Denite line:forward', '', '', 0, 'L<down>')
    call g:quickmenu#append('      Buffer', 'Denite buffer -default-action="switch"', '', '', 0, 'b')
    call g:quickmenu#append('      Buffer!', 'Denite buffer', '', '', 0, 'B')
    call g:quickmenu#append('      File MRU', 'Denite file_mru', '', '', 0, 'f')
    call g:quickmenu#append('      File', 'Denite file_rec', '', '', 0, 'F')
    call g:quickmenu#append('      Marks', 'Denite mark', '', '', 0, 'm')
    call g:quickmenu#append('      Directory MRU', 'Denite directory_mru', '', '', 0, 'd')
    call g:quickmenu#append('      Directory', 'Denite directory_rec', '', '', 0, 'D')
    call g:quickmenu#append('      Outline', 'Denite outline', '', '', 0, 't')
    call g:quickmenu#append('      Gtags', 'Denite source -input="gtags"', '', '', 0, 'T')
    call g:quickmenu#append('     Git Status', 'Denite gitstatus', '', '', 0, 'gs')
    call g:quickmenu#append('     Git Changed', 'Denite gitchanged', '', '', 0, 'gc')
    call g:quickmenu#append('     Git Branch', 'Denite gitbranch', '', '', 0, 'gb')
    call g:quickmenu#append('     Git Log', 'Denite gitlog', '', '', 0, 'gl')
    call g:quickmenu#append('     Git Log All', 'Denite gitlog', '', '', 0, 'gL')
    call g:quickmenu#append('      Register', 'Denite register', '', '', 0, 'r')
    call g:quickmenu#append('      Session', 'Denite session', '', '', 0, 's')
    call g:quickmenu#append('     History Fils', 'Denite file/old', '', '', 0, 'hf')
    call g:quickmenu#append('     History Command', 'Denite command_history', '', '', 0, 'hc')
    call g:quickmenu#append('      Commands', 'Denite commands', '', '', 0, 'C')
    call g:quickmenu#append('     Key Mappings', 'Denite keymap:n', '', '', 0, 'MN')
    call g:quickmenu#append('     Key Mappings', 'Denite keymap:i', '', '', 0, 'MI')
    call g:quickmenu#append('     Key Mappings', 'Denite keymap:v', '', '', 0, 'MV')
    call g:quickmenu#append('      Help Tags', 'Denite help', '', '', 0, 'H')
    call g:quickmenu#append('      Change', 'Denite change', '', '', 0, 'c')
    call g:quickmenu#append('      Project', 'Denite project', '', '', 0, 'p')
    call g:quickmenu#append('      Location List', 'Denite location_list', '', '', 0, 'i')
    call g:quickmenu#append('      Quickfix', 'Denite quickfix', '', '', 0, 'q')
    call g:quickmenu#append('      Grep', 'Denite grep', '', '', 0, 'G')
    call g:quickmenu#append('      Man', 'Denite man', '', '', 0, '$')
    call g:quickmenu#append('      Help Mappings', 'call Help_denite_mappings()', '', '', 0, '?')
    "}}}
    "{{{mappings
    " :h denite-kinds
    call denite#custom#map(
                \ 'insert',
                \ '<S-left>',
                \ '<denite:move_caret_to_head>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<S-right>',
                \ '<denite:move_caret_to_tail>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-Space>',
                \ '<denite:enter_mode:normal>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-v>',
                \ '<denite:paste_from_register>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-p>',
                \ '<denite:do_action:preview>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-j>',
                \ '<denite:move_to_next_line>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-k>',
                \ '<denite:move_to_previous_line>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-d>',
                \ '<denite:do_action:delete>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<C-e>',
                \ '<denite:do_action:edit>',
                \ 'noremap'
                \)
    call denite#custom#map(
                \ 'insert',
                \ '<S-Tab>',
                \ '<denite:do_action:cd>',
                \ 'noremap'
                \)
    "}}}
    augroup DeniteAu
        autocmd!
        autocmd User CocQuickfixChange :Denite -mode=normal quickfix
    augroup END
    let g:fruzzy#usenative = 1
    " Customize Var
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep', '-a', '--hidden'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('outline', 'command', ['ctags'])
    call denite#custom#var('outline', 'options', [])
    call denite#custom#var('outline', 'file_opt', '-o')
    call denite#custom#var('outline', 'ignore_types', [])
    call denite#custom#var('outline', 'encoding', 'utf-8')
    " customize options
    call denite#custom#option('default', {
                \ 'prompt': '➤ ',
                \ 'short_source_names': v:false
                \ })
    " customize sources
    " :h denite-sources
    " :h denite-source-attributes
    " :h denite-filters
    call denite#custom#source('_', 'matchers', ['matcher/cpsm'])  " matcher/fuzzy matcher/fruzzy matcher/cpsm
    call denite#custom#source('_', 'sorters', ['sorter/sublime'])  " sorter/sublime (sorter/rank)
    " if in git dir, git ls-files for file/rec
    call denite#custom#alias('source', 'file/rec/git', 'file/rec')
    call denite#custom#var('file/rec/git', 'command',
                \ ['git', 'ls-files', '-co', '--exclude-standard'])
    "}}}
    "{{{fzf.vim
elseif g:VIM_Fuzzy_Finder ==# 'fzf'
    "{{{fzf.vim-usage
    " f  search
    " grep中用<C-p>预览
    "}}}
    "{{{quickmenu
    call quickmenu#current(1)
    call quickmenu#reset()
    noremap <silent> f :call quickmenu#toggle(1)<cr>
    call g:quickmenu#append('# FZF', '')
    call g:quickmenu#append(' Fly Grep', 'Ag', '', '', 0, "\uf1d9")
    call g:quickmenu#append(' Line Buffer', 'BLines', '', '', 0, 'l')
    call g:quickmenu#append(' Line All', 'Lines', '', '', 0, 'L')
    call g:quickmenu#append(' MRU', 'History', '', '', 0, 'f')
    call g:quickmenu#append(' File', 'Files', '', '', 0, 'F')
    call g:quickmenu#append(' Buffer', 'Buffers', '', '', 0, 'b')
    call g:quickmenu#append(' Buffer!', 'call FZF_Buffer_Open()', '', '', 0, 'B')
    call g:quickmenu#append(' Tags Buffer', 'BTags', '', '', 0, 't')
    call g:quickmenu#append(' Tags All', 'Tags', '', '', 0, 'T')
    call g:quickmenu#append(' Marks', 'Marks', '', '', 0, 'm')
    call g:quickmenu#append(' Maps', 'Maps', '', '', 0, 'M')
    call g:quickmenu#append(' Windows', 'Windows', '', '', 0, 'w')
    call g:quickmenu#append('History Command', 'History:', '', '', 0, 'hc')
    call g:quickmenu#append('History Search', 'History/', '', '', 0, 'hs')
    call g:quickmenu#append(' Snippets', 'Snippets', '', '', 0, 's')
    call g:quickmenu#append('Git Files', 'GFiles', '', '', 0, 'gf')
    call g:quickmenu#append('Git Status', 'GFiles?', '', '', 0, 'gs')
    call g:quickmenu#append('Git Commits Buffer', 'BCommits', '', '', 0, 'gc')
    call g:quickmenu#append('Git Commits All', 'Commits', '', '', 0, 'gC')
    call g:quickmenu#append(' Commands', 'Commands', '', '', 0, 'c')
    call g:quickmenu#append(' Help', 'Helptags', '', '', 0, 'H')
    "}}}
    "{{{functions
    function! FZF_Buffer_Open()
        let g:fzf_buffers_jump = 0
        execute 'Buffers'
        let g:fzf_buffers_jump = 1
    endfunction
    "}}}
    augroup FZF_Au
        autocmd!
        autocmd User CocQuickfixChange :call fzf_quickfix#run()
    augroup END
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)
    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit' }
    let g:fzf_layout = { 'down': '~40%' }
    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
                \ { 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'] }
    let g:fzf_history_dir = '~/.cache/fzf-history'
    let g:fzf_buffers_jump = 1
    " [[B]Commits] Customize the options used by 'git log':
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
    " [Tags] Command to generate tags file
    let g:fzf_tags_command = 'ctags -R'
    " [Commands] --expect expression for directly executing the command
    let g:fzf_commands_expect = 'alt-enter,ctrl-x'
    " Command for git grep
    " - fzf#vim#grep(command, with_column, [options], [fullscreen])
    command! -bang -nargs=* GGrep
                \ call fzf#vim#grep(
                \   'git grep --line-number '.shellescape(<q-args>), 0,
                \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

    " Override Colors command. You can safely do this in your .vimrc as fzf.vim
    " will not override existing commands.
    command! -bang Colors
                \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
    command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
    command! -bang -nargs=* Ag
                \ call fzf#vim#ag(<q-args>,
                \                 <bang>0 ? fzf#vim#with_preview('up:60%')
                \                         : fzf#vim#with_preview('right:50%:hidden', 'ctrl-p'),
                \                 <bang>0)
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', 'ctrl-p'),
                \   <bang>0)
    "}}}
    "{{{LeaderF
elseif g:VIM_Fuzzy_Finder ==# 'leaderf'
    "{{{LeaderF-usage
    " f  search
    function Help_LeaderF()
        echo "<leader>f  呼出帮助窗口\n"
        echo "<C-C> 或 ESC 退出Leaderf\n"
        echo "<C-V>  从剪切板粘贴\n"
        echo "<C-U>  清空输入框\n"
        echo "<C-J>, <C-K>  移动光标\n"
        echo "<up> <down>  历史记录\n"
        echo "<C-R>     switch between fuzzy search mode and regex mode\n"
        echo "<C-F>     switch between full path search mode and name only search mode\n"
        echo "<CR>  打开\n"
        echo "<C-T>  新建Tab打开\n"
        echo "<C-S>  选择多个文件\n"
        echo "<C-A>  选择全部文件\n"
        echo "<C-L>  取消选中\n"
        echo "<Home>, <End>  跳转到行开头或末尾\n"
        echo "<C-P>  预览\n"
        echo '<F5>  刷新'
    endfunction
    "}}}
    "{{{quickmenu
    call quickmenu#current(1)
    call quickmenu#reset()
    noremap <silent> f :call quickmenu#toggle(1)<cr>
    call g:quickmenu#append('# LeaderF', '')
    call g:quickmenu#append('Fly Grep', 'FlyGrep', '', '', 0, "\uf1d9")
    call g:quickmenu#append('Line', 'LeaderfLine', 'Search Line in Current Buffer', '', 0, 'l')
    call g:quickmenu#append('Line All', 'LeaderfLineAll', 'Search Line in All Buffers', '', 0, 'L')
    call g:quickmenu#append('Buffer', 'LeaderfBuffer', 'Search Buffers, "open" as default action', '', 0, 'B')
    call g:quickmenu#append('MRU', 'LeaderfMru', 'Search MRU files', '', 0, 'f')
    call g:quickmenu#append('File', 'LeaderfFile', 'Search files', '', 0, 'F')
    call g:quickmenu#append('Tags', 'LeaderfBufTag', 'Search Tags in Current Buffer', '', 0, 't')
    call g:quickmenu#append('Tags All', 'LeaderfBufTagAll', 'Search Tags in All Buffers', '', 0, 'T')
    call g:quickmenu#append('History Command', 'LeaderfHistoryCmd', 'Search History Commands', '', 0, 'hc')
    call g:quickmenu#append('History Search', 'LeaderfHistorySearch', 'Search History Searching', '', 0, 'hs')
    call g:quickmenu#append('Marks', 'LeaderfMarks', 'Search Marks', '', 0, 'm')
    call g:quickmenu#append('Help Docs', 'LeaderfHelp', 'Search Help Docs', '', 0, 'H')
    call g:quickmenu#append('Leaderf Help', 'call Help_LeaderF()', 'Leaderf Help', '', 0, '?')
    "}}}
    " let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
    let g:Lf_DefaultExternalTool = 'ag'
    let g:Lf_StlColorscheme = 'one'  " /home/sainnhe/.vim/plugins/LeaderF/autoload/leaderf/colorscheme
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    let g:Lf_ShortcutF = '```zw'  " mapping for searching files
    let g:Lf_ShortcutB = '````1cv'  " mapping for searching buffers
    let g:Lf_WindowPosition = 'bottom'  " top bottom left right
    let g:Lf_WindowHeight = 0.4
    let g:Lf_DefaultMode = 'FullPath' " NameOnly FullPath Fuzzy Regex   :h g:Lf_DefaultMode
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_CacheDirectory = '/home/sainnhe/.cache/'
    let g:Lf_PreviewCode = 1  " preview code
    let g:Lf_PreviewResult = {
                \ 'File': 1,
                \ 'Buffer': 1,
                \ 'Mru': 1,
                \ 'Tag': 0,
                \ 'BufTag': 1,
                \ 'Function': 1,
                \ 'Line': 1,
                \ 'Colorscheme': 0
                \}
endif
"}}}
"{{{ale
if g:VIM_Linter ==# 'ale'
    "{{{ale-usage
    let g:ALE_MODE = 2  " 0则只在保存文件时检查，1则只在normal模式下检查，2则异步检查
    " 普通模式下<leader><up>和<leader><down>分别跳转到上一个、下一个错误
    " :ALEDetail  查看详细错误信息
    "}}}
    " ls ~/.vim/plugins/ale/ale_linters/
    let g:ale_linters = {
                \       'asm': ['gcc'],
                \       'c': ['cppcheck'],
                \       'cpp': ['cppcheck'],
                \       'css': ['stylelint'],
                \       'html': ['tidy'],
                \       'json': ['jsonlint'],
                \       'python': ['pylint'],
                \       'sh': ['shellcheck'],
                \       'vim': ['vint'],
                \}
    "查看上一个错误
    nmap <silent> <leader><up> <Plug>(ale_previous_wrap)
    "查看下一个错误
    nmap <silent> <leader><down> <Plug>(ale_next_wrap)
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
    "{{{neomake
elseif g:VIM_Linter ==# 'neomake'
    call neomake#configure#automake('nwr')
    let g:neomake_error_sign = {'text': "\uf65b", 'texthl': 'NeomakeErrorSign'}
    let g:neomake_warning_sign = {'text': "\uf421",'texthl': 'NeomakeWarningSign'}
    let g:neomake_message_sign = {'text': '➤','texthl': 'NeomakeMessageSign'}
    let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
endif
"}}}
"{{{defx.nvim
if g:VIM_Explore ==# 'defx'
    "{{{defx.nvim-usage
    " defx中按?显示帮助
    function! Help_defx()
        echo "<CR>  打开文件或目录并关闭defx\n"
        echo "<right>  打开文件或目录\n"
        echo "<left>  返回上一级目录\n"
        echo "<Tab>  让当前目录成为当前TAB的工作目录\n"
        echo "nd  新建目录\n"
        echo "nf  新建文件\n"
        echo "s  选中\n"
        echo "a  全部选中\n"
        echo ".  切换隐藏文件\n"
        echo "c  复制文件\n"
        echo "m  移动文件\n"
        echo "p  粘贴要移动和复制的文件\n"
        echo "D  彻底删除文件\n"
        echo "r  重命名文件\n"
        echo "x  执行文件\n"
        echo "yy  复制路径\n"
        echo "<C-p>  打印Defx的工作目录\n"
        echo "<A-p>  打印当前文件路径\n"
        echo "~  回到$HOME目录\n"
        echo "<S-left>  跳转到上一个git标识的位置\n"
        echo "<S-right>  跳转到下一个git标识的位置\n"
        echo "<F5>  刷新\n"
        echo "<A-b>  切换bufexplore\n"
        echo 'f  搜索'
        echo "q  退出\n"
        echo '?  帮助'
    endfunction
    "}}}
    "{{{defx-git
    let g:defx_git#indicators = {
                \ 'Modified'  : '✹',
                \ 'Staged'    : '✚',
                \ 'Untracked' : '✭',
                \ 'Renamed'   : '➜',
                \ 'Unmerged'  : '═',
                \ 'Ignored'   : '☒',
                \ 'Deleted'   : '✖',
                \ 'Unknown'   : '?'
                \ }
    let g:defx_git#column_length = 2
    let g:defx_git#show_ignored = 0
    "}}}
    "{{{FuzzyFinderIntegration
    function! DefxFuzzyFind()
        if g:VIM_Fuzzy_Finder ==# 'denite'
            execute 'Denite file_rec directory_rec'
        elseif g:VIM_Fuzzy_Finder ==# 'fzf'
            execute 'Files'
        elseif g:VIM_Fuzzy_Finder ==# 'leaderf'
            execute 'LeaderfFile'
        endif
    endfunction
    "}}}
    function! ToggleDefx()
        execute 'Defx -toggle -auto-cd -buffer-name="Explore" -split=vertical -winwidth=35 -direction=topleft -fnamewidth=19 -columns=mark:icons:filename:git:size:time'
    endfunction
    nnoremap <silent> <C-B> <Esc>:call ToggleDefx()<CR>
    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_column_length = 1
    let g:defx_icons_directory_icon = ''
    let g:defx_icons_mark_icon = "\uf9cd"
    let g:defx_icons_parent_icon = ''
    let g:defx_icons_default_icon = "\uf15b"
    let g:defx_icons_directory_symlink_icon = ''
    " close vim if the only window left open is defx
    augroup Defx_Config
        autocmd!
        autocmd bufenter * if (winnr("$") == 1 && exists("b:defx")) | q | endif
        autocmd FileType defx call s:defx_my_settings()
        autocmd FileType bufexplorer call s:bufexplore_mappings()
    augroup END
    function! s:defx_my_settings() abort
        " Define Mappings
        nmap <silent><buffer><expr> <CR> defx#async_action('open', 'wincmd w \| drop')."\<C-B>"
        nnoremap <silent><buffer><expr> <right>
                    \ defx#async_action('open', 'wincmd w \| drop')
        nnoremap <silent><buffer><expr> <left>
                    \ defx#async_action('cd', ['..'])
        nnoremap <silent><buffer> <Tab> :tcd %:p:h<CR>
        nnoremap <silent><buffer><expr> nd
                    \ defx#async_action('new_directory')
        nnoremap <silent><buffer><expr> nf
                    \ defx#async_action('new_file')
        nnoremap <silent><buffer><expr> c
                    \ defx#async_action('copy')
        nnoremap <silent><buffer><expr> m
                    \ defx#async_action('move')
        nnoremap <silent><buffer><expr> p
                    \ defx#async_action('paste')
        nnoremap <silent><buffer><expr> <A-p>
                    \ defx#async_action('print')
        nnoremap <silent><buffer><expr> D
                    \ defx#async_action('remove')
        nnoremap <silent><buffer><expr> r
                    \ defx#async_action('rename')
        nnoremap <silent><buffer><expr> x
                    \ defx#async_action('execute_system')
        nnoremap <silent><buffer><expr> s
                    \ defx#async_action('toggle_select')
        nnoremap <silent><buffer><expr> a
                    \ defx#async_action('toggle_select_all')
        nnoremap <silent><buffer><expr> yy
                    \ defx#async_action('yank_path')
        nnoremap <silent><buffer><expr> .
                    \ defx#async_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> ~
                    \ defx#async_action('cd')
        nnoremap <silent><buffer><expr> q
                    \ defx#async_action('quit')
        nnoremap <silent><buffer><expr> <F5>
                    \ defx#async_action('redraw')
        nnoremap <silent><buffer> <S-left> <Plug>(defx-git-prev)
        nnoremap <silent><buffer> <S-right> <Plug>(defx-git-next)
        nnoremap <silent><buffer> <C-p> :echo getcwd(0,tabpagenr())<CR>
        nnoremap <silent><buffer> <A-b> :call Toggle_bufexplore()<CR>
        nnoremap <silent><buffer> f :call DefxFuzzyFind()<CR>
        nnoremap <silent><buffer> ? :call Help_defx()<CR>
    endfunction
    "}}}
    "{{{nerdtree
elseif g:VIM_Explore ==# 'nerdtree'
    nnoremap <silent> <C-B> <Esc>:NERDTreeToggle<CR>
    augroup NERDTreeAu
        autocmd!
        " open NERDTree automatically when vim starts up on opening a directory
        autocmd StdinReadPre * let s:std_in=1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
        " close vim if the only window left open is a NERDTree
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END
    let g:NERDTreeDirArrowExpandable = ''
    let g:NERDTreeDirArrowCollapsible = ''
    let g:NERDTreeIndicatorMapCustom = {
                \ 'Modified'  : '✹',
                \ 'Staged'    : '✚',
                \ 'Untracked' : '✭',
                \ 'Renamed'   : '➜',
                \ 'Unmerged'  : '═',
                \ 'Deleted'   : '✖',
                \ 'Dirty'     : '✗',
                \ 'Clean'     : '✔︎',
                \ 'Ignored'   : '☒',
                \ 'Unknown'   : '?'
                \ }
endif
"}}}
"{{{bufexplore
"{{{bufexplore-usage
" defx中<A-b>  切换bufexplorer, <C-b>退出
" ?  显示帮助文档
"}}}
"{{{Toggle_bufexplore()
function! Toggle_bufexplore()
    if &filetype ==# 'defx'
        execute 'ToggleBufExplorer'
    elseif &filetype ==# 'bufexplorer'
        execute 'ToggleBufExplorer'
        execute 'q'
        call ToggleDefx()
    endif
endfunction
"}}}
" Use Default Mappings
let g:bufExplorerDisableDefaultKeyMapping=1
function! s:bufexplore_mappings() abort
    nnoremap <silent><buffer> <A-b> :call Toggle_bufexplore()<CR>
    nnoremap <silent><buffer> <C-b> :q<CR>
    nmap <silent><buffer> ? <F1>
endfunction
let g:bufExplorerShowTabBuffer=1 " 只显示当前tab的buffer
let g:bufExplorerSplitBelow=1 " explore水平分割时，在下方打开
let g:bufExplorerDefaultHelp=0 " 默认不显示帮助信息
let g:bufExplorerSplitBelow=1 " Split new window below current.
let g:bufExplorerSplitHorzSize=10 " New split window is n rows high.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
" let g:bufExplorerSortBy='extension'  " Sort by file extension.
" let g:bufExplorerSortBy='fullpath'   " Sort by full file path name.
" let g:bufExplorerSortBy='name'       " Sort by the buffer's name.
" let g:bufExplorerSortBy='number'     " Sort by the buffer's number.
"}}}
"{{{tagbar
nnoremap <silent><A-b> <Esc>:call ToggleTagbar()<CR>
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
    call plug#load('tagbar', 'tagbar-markdown')
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
endfunction
"}}}
"{{{vim-autoformat
"{{{vim-autoformat-usage
" 主quickmenu
"}}}
call quickmenu#current(7)
call quickmenu#reset()
call g:quickmenu#append('# Format', '')
call g:quickmenu#append('Auto Format', 'Autoformat', '', '', 0, 'f')
call g:quickmenu#append('Next Formatter', 'NextFormatter', '', '', 0, 'n')
call g:quickmenu#append('Previous Formatter', 'PreviousFormatter', '', '', 0, 'p')
call g:quickmenu#append('Current Formatter', 'CurrentFormatter', '', '', 0, 'c')
" au BufWrite * :Autoformat     "在保存文件时自动排版
" 自定义formatters
" 你可以改变它们的顺序，但是不要改变它们的值
let g:formatters_c = ['astyle_c', 'clangformat']
let g:formatters_cpp = ['astyle_cpp', 'clangformat']
let g:formatters_cs = ['astyle_cs']
let g:formatters_objc = ['clangformat']
let g:formatters_java = ['astyle_java']
let g:formatters_javascript = [
            \ 'eslint_local',
            \ 'jsbeautify_javascript',
            \ 'jscs',
            \ 'standard_javascript',
            \ 'prettier',
            \ 'xo_javascript',
            \ ]
let g:formatters_python = ['yapf', 'autopep8']
let g:formatters_json = [
            \ 'jsbeautify_json',
            \ 'fixjson',
            \ 'prettier',
            \ ]
let g:formatters_html = ['tidy_html', 'htmlbeautify']
let g:formatters_xml = ['tidy_xml']
let g:formatters_svg = ['tidy_xml']
let g:formatters_xhtml = ['tidy_xhtml']
let g:formatters_ruby = ['rbeautify', 'rubocop']
let g:formatters_css = ['prettier', 'cssbeautify']
let g:formatters_scss = ['prettier', 'sassconvert']
let g:formatters_less = ['prettier']
let g:formatters_typescript = ['tsfmt', 'prettier']
let g:formatters_go = ['gofmt_1', 'goimports', 'gofmt_2']
let g:formatters_rust = ['rustfmt']
let g:formatters_dart = ['dartfmt']
let g:formatters_perl = ['perltidy']
let g:formatters_haskell = ['stylish_haskell']
let g:formatters_markdown = ['prettier', 'remark_markdown']
let g:formatters_graphql = ['prettier']
let g:formatters_fortran = ['fprettify']
let g:formatters_elixir = ['mix_format']
let g:formatters_sh = ['shfmt']
let g:formatters_sql = ['sqlformat']
"}}}
"{{{nerdcommenter
"{{{nerdcommenter-usage
" <leader>c?  显示帮助
function! Help_nerdcommenter()
    echo "[count]<Leader>cc NERDComComment, Comment out the current [count] line or text selected in visual mode\n"
    echo "[count]<Leader>cu NERDComUncommentLine, Uncomments the selected line(s)\n"
    echo "[count]<Leader>cn NERDComNestedComment, Same as <Leader>cc but forces nesting\n"
    echo "[count]<Leader>c<space> NERDComToggleComment, Toggles the comment state of the selected line(s). If the topmost selected, line is commented, all selected lines are uncommented and vice versa.\n"
    echo "[count]<Leader>cm NERDComMinimalComment, Comments the given lines using only one set of multipart delimiters\n"
    echo "[count]<Leader>ci NERDComInvertComment, Toggles the comment state of the selected line(s) individually\n"
    echo "[count]<Leader>cs NERDComSexyComment, Comments out the selected lines sexily'\n"
    echo "[count]<Leader>cy NERDComYankComment, Same as <Leader>cc except that the commented line(s) are yanked first\n"
    echo "<Leader>c$ NERDComEOLComment, Comments the current line from the cursor to the end of line\n"
    echo "<Leader>cA NERDComAppendComment, Adds comment delimiters to the end of line and goes into insert mode between them\n"
    echo "<Leader>ca NERDComAltDelim, Switches to the alternative set of delimiters\n"
    echo '[count]<Leader>cl && [count]<Leader>cb NERDComAlignedComment, Same as NERDComComment except that the delimiters are aligned down the left side (<Leader>cl) or both sides (<Leader>cb)'
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
"{{{vim-multiple-cursors
"{{{vim-multiple-cursors-usage
" 主quickmenu
function! Help_vim_multiple_cursors()
    echo '<leader><A-[>  start word'
    echo '<leader><A-]>  start character'
    echo '<A-]>  next match'
    echo '<A-[>  previous match'
    echo '<A-\>  skip match'
    echo 'v <C-v>  visual select'
    echo '<Esc>  quit'
endfunction
"}}}
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<leader><A-[>'
let g:multi_cursor_start_key           = '<leader><A-]>'
let g:multi_cursor_next_key            = '<A-]>'
let g:multi_cursor_prev_key            = '<A-[>'
let g:multi_cursor_skip_key            = '<A-\>'
let g:multi_cursor_quit_key            = '<Esc>'
let g:multi_cursor_select_all_word_key = '<leader>`zxcasdsfxc'
let g:multi_cursor_select_all_key      = '<leader>`zxcafdsfa'
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0
"}}}
"{{{vim-bookmarks
"{{{vim-bookmarks-usage
function! Help_vim_bookmarks()
    echo '<Leader>bs Show/Search Bookmarks'
    echo '<Leader>bb <Plug>BookmarkToggle'
    echo '<Leader>ba <Plug>BookmarkAnnotate'
    echo '<Leader>b<down> <Plug>BookmarkNext'
    echo '<Leader>b<left> <Plug>BookmarkPrev'
    echo '<Leader>bc <Plug>BookmarkClear'
    echo '<Leader>bC <Plug>BookmarkClearAll'
    echo '" these will also work with a [count] prefix'
    echo '<Leader>b<up> <Plug>BookmarkMoveUp'
    echo '<Leader>b<down> <Plug>BookmarkMoveDown'
    echo '<Leader>b<Tab> <Plug>BookmarkMoveToLine'
    echo ''
    echo '<Leader>b? Help'
endfunction
"}}}
"{{{FuzzyFinderIntegration
function! VIM_Bookmarks_FuzzyFinder()
    if g:VIM_Fuzzy_Finder ==# 'denite'
        execute 'BookmarkShowAll'
        execute 'q'
        execute 'Denite quickfix -default-action="switch"'
    elseif g:VIM_Fuzzy_Finder ==# 'fzf'
        execute 'BookmarkShowAll'
        execute 'q'
        execute 'call fzf_quickfix#run()'
    else
        execute 'BookmarkShowAll'
    endif
endfunction
"}}}
let g:bookmark_sign = '✭'
let g:bookmark_annotation_sign = '☰'
let g:bookmark_auto_save = 1
let g:bookmark_auto_save_file = $HOME .'/.cache/.vimbookmarks'
let g:bookmark_highlight_lines = 1
let g:bookmark_show_warning = 0
let g:bookmark_show_toggle_warning = 0
let g:bookmark_auto_close = 1
let g:bookmark_no_default_key_mappings = 1
nmap <Leader>bb <Plug>BookmarkToggle
nmap <Leader>ba <Plug>BookmarkAnnotate
nmap <silent> <Leader>bs :call VIM_Bookmarks_FuzzyFinder()<CR>
nmap <Leader>b<down> <Plug>BookmarkNext
nmap <Leader>b<left> <Plug>BookmarkPrev
nmap <Leader>bc <Plug>BookmarkClear
nmap <Leader>bC <Plug>BookmarkClearAll
" these will also work with a [count] prefix
nmap <Leader>b<up> <Plug>BookmarkMoveUp
nmap <Leader>b<down> <Plug>BookmarkMoveDown
nmap <Leader>b<Tab> <Plug>BookmarkMoveToLine
nmap <silent> <Leader>b? :call Help_vim_bookmarks()<CR>
"}}}
"{{{suda.vim
"{{{suda.vim-usage
" :E filename  sudo edit
" :W       sudo edit
"}}}
command! -nargs=1 E  edit  suda://<args>
command W w suda://%
"}}}
"{{{auto-pairs
"{{{auto-pairs-usage
" 主quickmenu
function! Help_auto_pairs()
    echo '插入模式下：'
    echo '<A-w>  fast wrap'
    echo '<A-n>  jump to next closed pair'
endfunction
"}}}
let g:AutoPairsShortcutToggle = '<A-z>`asdxcvdsf'
let g:AutoPairsShortcutFastWrap = '<A-w>'
let g:AutoPairsShortcutJump = '<A-n>'
"}}}
"{{{vim-surround
"{{{vim-surround-usage
" 主quickmenu
function! Help_vim_surround()
    echo 'ds([  delete surround'
    echo 'cs([  change surround () to []'
    echo 'ysw[  add surround [] from current position to the end of this word'
    echo 'ysiw[  add surround [] from the begin of this word to the end'
    echo 'yss[  add surround [] from the begin of this line to the end'
endfunction
"}}}
"}}}
"{{{vim-youdao-translater
"{{{vim-youdao-translater-usage
" 普通模式<leader>t翻译当前word
" 可视模式<leader>t翻译选中文本
" 普通模式<leader>T输入pattern翻译
"}}}
vnoremap <silent> <leader>t :<C-u>Ydv<CR>
nnoremap <silent> <leader>t :<C-u>Ydc<CR>
nnoremap <silent> <leader>T :<C-u>Yde<CR>
"}}}
"{{{comfortable-motion.vim
"{{{comfortable-motion.vim-usage
" <S-pageup> <S-pagedown>平滑滚动
"}}}
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
nnoremap <silent> <S-pagedown> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <S-pageup> :call comfortable_motion#flick(-200)<CR>
inoremap <silent> <S-pagedown> <Esc>:call comfortable_motion#flick(100)<CR>a
inoremap <silent> <S-pageup> <Esc>:call comfortable_motion#flick(-100)<CR>a
vnoremap <silent> <S-pagedown> <Esc>:call comfortable_motion#flick(150)<CR>v
vnoremap <silent> <S-pageup> <Esc>:call comfortable_motion#flick(-150)<CR>v
"}}}
"{{{vim-smooth-scroll
nnoremap <silent> <S-up> :call smooth_scroll#up(&scroll/2, 10, 2)<CR>
nnoremap <silent> <S-down> :call smooth_scroll#down(&scroll/2, 10, 2)<CR>
"}}}
"{{{codi.vim
let g:codi#width = 40
let g:codi#rightsplit = 1
let g:codi#rightalign = 0
"}}}
" "{{{neoman.vim
" neoman.vim-usage
function! Help_neoman()
    echo 'Nman " display man page for <cWORD>'
    echo 'Nman [sect] page'
    echo 'Nman page[(sect)]'
    echo 'Nman path " if in current directory, start path with ./'
    echo ':Nman printf'
    echo ':Nman 3 printf'
    echo ':Nman printf(3)'
    echo ':Nman ./fzf.1 " open manpage in current directory'
    echo ''
    echo 'Commands'
    echo 'Nman Snman Vnman Tnman'
    echo ''
    echo 'Mappings'
    echo '<C-]>  jump to a manpage under the cursor'
    echo '<C-t>  jump back to the previous man page'
    echo 'q  quit'
endfunction
" "}}}
"{{{emmet-vim
"{{{emmet-vim-usage
" https://blog.zfanw.com/zencoding-vim-tutorial-chinese/
" :h emmet
"}}}
function Func_emmet_vim()
    let g:user_emmet_leader_key='<A-x>'
    let g:user_emmet_mode='in'  "enable in insert and normal mode
endfunction
"}}}
"{{{vim-closetag
"{{{vim-closetag-usage
function! Help_vim_closetag()
    echo '<A-z>z  Add > at current position without closing the current tag'
endfunction
"}}}
function! Func_vim_closetag()
    " Shortcut for closing tags, default is '>'
    let g:closetag_shortcut = '>'
    " Add > at current position without closing the current tag, default is ''
    let g:closetag_close_shortcut = '<A-z>>'
endfunction
"}}}
"{{{MatchTagAlways
"{{{MatchTagAlways-usage
function! Help_MatchTagAlways()
    echo '<A-j>  普通模式下跳转tag'
endfunction
"}}}
function! Func_MatchTagAlways()
    inoremap <silent><A-j> <Esc>:MtaJumpToOtherTag<CR>i
    nnoremap <silent><A-j> <Esc>:MtaJumpToOtherTag<CR>
endfunction
"}}}
