let g:vimAutoInstall = 1
let g:lightlineArtify = 1
let g:vimColorScheme = 'Gruvbox Material Light'
let g:vimEnableItalic = 0
if !has('win32')
  let g:startify_bookmarks = [
        \ {'R': '~/repo/'},
        \ {'r': '~/repo/notes'},
        \ {'r': '~/repo/dotfiles'},
        \ {'r': '~/repo/scripts'},
        \ {'P': '~/playground/'},
        \ {'c': '~/repo/dotfiles/.config/nvim/init.vim'},
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
if exists('g:fvim_loaded') || exists('g:neovide')
  set guifont=Fira\ Code\ iCursive\ Op:h15
endif
