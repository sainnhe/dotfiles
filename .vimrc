function! VIM_Global_Settings()
    let g:VIM_LSP_Client = 'lcn'  " lcn vim-lsp
    let g:VIM_Snippets = 'ultisnips'  " ultisnips neosnippet
    let g:VIM_Completion_Framework = 'asyncomplete'  " deoplete ncm2 asyncomplete neocomplete
    let g:VIM_Fuzzy_Finder = 'fzf'  " remix denite fzf leaderf
    let g:VIM_Linter = 'ale'  " ale neomake
    let g:VIM_Explore = 'defx'  " defx nerdtreeendfunction
endfunction
source ~/.config/nvim/init.vim
