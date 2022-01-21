" My configuration is compatible with both vim and neovim
" ln -s /path/to/dotfiles/.config/nvim ~/.vim
if has('win32')
  source ~/vimfiles/init.vim
else
  source ~/.vim/init.vim
endif
