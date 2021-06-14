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

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
