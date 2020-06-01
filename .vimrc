" Settings{{{
set encoding=utf-8 nobomb
set termencoding=utf-8
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
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,menu,longest
set dictionary+=/usr/share/dict/words
let g:sessions_dir = expand('~/.cache/vim/sessions/')
set smartindent                         " 智能缩进
set hlsearch                            " 高亮搜索
set undofile                            " 始终保留undo文件
set undodir=$HOME/.cache/vim/undo       " 设置undo文件的目录
set timeoutlen=5000                     " 超时时间为5秒
set foldmethod=marker                   " 折叠方式为按照marker折叠
set hidden                              " buffer自动隐藏
set showtabline=2                       " 总是显示标签
set scrolloff=5                         " 保持5行
set viminfo='1000                       " 文件历史个数
set autoindent                          " 自动对齐
set wildmenu                            " 命令框Tab呼出菜单
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab     " tab设定，:retab 使文件中的TAB匹配当前设置
set updatetime=100
set incsearch
" Key{{{
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
" }}}
" }}}
"Mappings{{{
"{{{NormalMode
" <leader>e open netrw
nnoremap <silent> <leader>e :Explore<CR>
" buffer management
nnoremap <silent> <leader>bb :buffers<CR>
nnoremap <silent> <leader>bj :bn<CR>
nnoremap <silent> <leader>bk :bp<CR>
nnoremap <silent> <leader>bd :bw<CR>
nnoremap <silent> <leader>bD :bw!<CR>
" Alt+X进入普通模式
nnoremap <A-x> <ESC>
nnoremap ^@ <ESC>
" ; 绑定到 :
nnoremap ; :
" q 绑定到:q
nmap <silent> q :q<CR>
" <leader>q 关闭 quickfix list
nnoremap <silent> <leader>q :cclose<CR>
" m 绑定到 q
nnoremap m q
" Ctrl+S保存文件
nnoremap <C-S> :<C-u>w<CR>
" Shift加方向键加速移动
nnoremap <S-up> <Esc>7<up>
nnoremap <S-down> <Esc>7<down>
nnoremap <S-left> <Esc>0
nnoremap <S-right> <Esc>$
" Shift+HJKL快速移动
nnoremap K 7<up>
nnoremap J 7<down>
nnoremap H 0
nnoremap L $
" x删除字符但不保存到剪切板
nnoremap x "_x
" Ctrl+X剪切当前行但不保存到剪切板
nnoremap <C-X> <ESC>"_dd
" <leader>+Y复制到系统剪切板
nnoremap <leader>y "+y
" <leader>+P从系统剪切板粘贴
nnoremap <leader>p "+p
" Alt+T新建tab
nnoremap <silent> <A-t> :<C-u>tabnew<CR>
" Alt+W关闭当前标签
nnoremap <silent> <A-w> :<C-u>call CloseOnLastTab()<CR>
" Alt+上下左右可以跳转和移动窗口
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
" Completion
imap <C-x>d <C-x><C-k>
imap <C-x>b <C-x><C-i>
imap <C-x>p <C-x><C-f>
imap <C-x>o <C-x><C-o>
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" Ctrl+X剪切当前行但不保存到剪切板
inoremap <C-X> <ESC>"_ddi
" Alt+X进入普通模式
inoremap <A-x> <ESC><right>
inoremap ^@ <ESC>
" Ctrl+V粘贴
inoremap <C-V> <Space><Backspace><ESC>pa
" <A-z><C-v>从系统剪切板粘贴
inoremap <A-z><C-V> <Space><Backspace><ESC>"+pa
" Ctrl+S保存文件
inoremap <C-S> <Esc>:w<CR>a
" Ctrl+Z撤销上一个动作
inoremap <C-Z> <ESC>ua
" Ctrl+R撤销撤销的动作
inoremap <C-R> <ESC><C-R>a
" Ctrl+hjkl移动
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
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
vnoremap ^@ <ESC>
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
cmap ^@ <ESC>
" Ctrl+S保存
cmap <C-S> :<C-u>w<CR>
"}}}
"}}}
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
"{{{StatuslineGit
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! StatuslineGit()
    let l:branchname = GitBranch()
    if strlen(l:branchname) > 0
        return ' '.l:branchname.' '
    else
        return ' clean '
    endif
endfunction"}}}
"}}}
" UI{{{
syntax enable
set t_Co=256
if has('termguicolors')
  set termguicolors
endif
set background=dark
let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_menu_selection_background = 'green'
let g:gruvbox_material_sign_column_background = 'none'
colo gruvbox-material
" Statusline{{{
" :h 'statusline'
set laststatus=2
set statusline=
set statusline+=%#TabLineSel#
set statusline+=%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%{(mode()=='r')?'\ \ REPLACE\ ':''}
set statusline+=%#StatusLine#
set statusline+=%r\ 
set statusline+=%f
set statusline+=%m\ 
set statusline+=%#Normal#
set statusline+=%=
set statusline+=%#StatusLine#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c\ 
set statusline+=%#TabLineSel#
set statusline+=%{StatuslineGit()}
" }}}
" }}}
