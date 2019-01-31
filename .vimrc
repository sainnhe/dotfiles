function! VIM_Global_Settings()
    let g:VIM_LSP_Client = 'lcn'  " lcn vim-lsp
    let g:VIM_Snippets = 'ultisnips'  " ultisnips neosnippet
    let g:VIM_Completion_Framework = 'ncm2'  " ncm2 asyncomplete neocomplete deoplete
    let g:VIM_Fuzzy_Finder = 'remix'  " remix denite fzf leaderf
    let g:VIM_Linter = 'ale'  " ale neomake
    let g:VIM_Explore = 'nerdtree'  " defx nerdtree
endfunction
source ~/.config/nvim/init.vim
