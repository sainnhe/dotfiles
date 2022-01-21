" My configuration is compatible with both vim and neovim
" On Linux/macOS:
" ln -s /path/to/dotfiles/.config/nvim ~/.vim
" On Windows:
" mklink /D C:\Users\username\vimfiles \path\to\dotfiles\.config\nvim
if has('win32')
  source ~/vimfiles/init.vim
else
  source ~/.vim/init.vim
endif
