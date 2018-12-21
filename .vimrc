function! VIM_Global_Settings()
let g:VIM_LSP_Client = 'lcn'  " lcn vim-lsp
let g:VIM_Snippets = 'ultisnips'  " ultisnips neosnippet
let g:VIM_Completion_Framework = 'deoplete'  " deoplete ncm2 asyncomplete coc
let g:VIM_Fuzzy_Finder = 'fzf'  " denite fzf leaderf
let g:VIM_Linter = 'ale' | let g:EnableCocLint = 0  " ale neomake
let g:VIM_Explore = 'nerdtree'  " defx nerdtree
endfunction
source ~/.config/nvim/init.vim
