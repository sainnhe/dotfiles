let g:vim_plug_auto_install = 1
let g:vim_lightline_artify = 1
let g:vim_color_scheme = 'Forest Night'
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
