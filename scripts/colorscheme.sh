#!/usr/bin/env bash

THEME=$(printf "\
[1]  Gruvbox Material Dark\n\
[2]  Gruvbox Mix Dark\n\
[3]  Gruvbox Material Light\n\
[4]  Edge Dark\n\
[5]  Edge Light\n\
[6]  Everforest Dark\n\
[7]  Everforest Light\n\
[8]  Sonokai\n\
[9]  Sonokai Shusia\n\
[10] Sonokai Andromeda\n\
[11] Sonokai Atlantis\n\
[12] Sonokai Maia\n\
[13] Sonokai Espresso\n\
[14] Soft Era\n" |\
fzf |\
sed -E -e 's/^\[//' -e 's/].*//')

if [ "$THEME"x == ""x ]; then
    exit
fi

_switch_color_scheme() {
    [ -f ~/.config/nvim/envs.vim ] && \
        sed -E -i.bak \
        "s/let g:vim_color_scheme = '.*'/let g:vim_color_scheme = '$2'/" \
        ~/.config/nvim/envs.vim && \
        rm ~/.config/nvim/envs.vim.bak
    [ -f ~/.tmux.conf ] && \
        sed -E -i.bak \
        "s/^source.*/source ~\/\.tmux\/tmuxline\/$1\.tmux\.conf/" \
        ~/.tmux.conf && \
        rm ~/.tmux.conf.bak
    [ -f ~/.config/zathura/zathurarc ] && \
        sed -E -i.bak \
        "s/^include themes.*/include themes\/$1/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
    rm ~/.zsh-theme
    cp -f "${3}.zsh" ~/.zsh-theme
}

if [ "$THEME" == "1" ]; then
    _switch_color_scheme \
        gruvbox-material-dark \
        gruvbox_material_dark \
        ~/repo/dotfiles/.zsh-theme/gruvbox-material-dark
elif [ "$THEME" == "2" ]; then
    _switch_color_scheme \
        gruvbox-mix-dark \
        gruvbox_mix_dark \
        ~/repo/dotfiles/.zsh-theme/gruvbox-mix-dark
elif [ "$THEME" == "3" ]; then
    _switch_color_scheme \
        gruvbox-material-light \
        gruvbox_material_light \
        ~/repo/dotfiles/.zsh-theme/gruvbox-material-light
elif [ "$THEME" == "4" ]; then
    _switch_color_scheme \
        edge-dark \
        edge_dark \
        ~/repo/dotfiles/.zsh-theme/edge-dark
elif [ "$THEME" == "5" ]; then
    _switch_color_scheme \
        edge-light \
        edge_light \
        ~/repo/dotfiles/.zsh-theme/edge-light
elif [ "$THEME" == "6" ]; then
    _switch_color_scheme \
        everforest-dark \
        everforest_dark \
        ~/repo/dotfiles/.zsh-theme/everforest-dark
elif [ "$THEME" == "7" ]; then
    _switch_color_scheme \
        everforest-light \
        everforest_light \
        ~/repo/dotfiles/.zsh-theme/everforest-light
elif [ "$THEME" == "8" ]; then
    _switch_color_scheme \
        sonokai \
        sonokai \
        ~/repo/dotfiles/.zsh-theme/sonokai
    sed -E -i.bak \
        "s/^include themes.*/include themes\/edge-dark/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
elif [ "$THEME" == "9" ]; then
    _switch_color_scheme \
        sonokai-shusia \
        sonokai_shusia \
        ~/repo/dotfiles/.zsh-theme/sonokai-shusia
    sed -E -i.bak \
        "s/^include themes.*/include themes\/edge-dark/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
elif [ "$THEME" == "10" ]; then
    _switch_color_scheme \
        sonokai-andromeda \
        sonokai_andromeda \
        ~/repo/dotfiles/.zsh-theme/sonokai-andromeda
    sed -E -i.bak \
        "s/^include themes.*/include themes\/edge-dark/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
elif [ "$THEME" == "11" ]; then
    _switch_color_scheme \
        sonokai-atlantis \
        sonokai_atlantis \
        ~/repo/dotfiles/.zsh-theme/sonokai-atlantis
    sed -E -i.bak \
        "s/^include themes.*/include themes\/edge-dark/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
elif [ "$THEME" == "12" ]; then
    _switch_color_scheme \
        sonokai-maia \
        sonokai_maia \
        ~/repo/dotfiles/.zsh-theme/sonokai-maia
    sed -E -i.bak \
        "s/^include themes.*/include themes\/edge-dark/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
elif [ "$THEME" == "13" ]; then
    _switch_color_scheme \
        sonokai-espresso \
        sonokai_espresso \
        ~/repo/dotfiles/.zsh-theme/sonokai-espresso
    sed -E -i.bak \
        "s/^include themes.*/include themes\/edge-dark/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
elif [ "$THEME" == "14" ]; then
    _switch_color_scheme \
        soft-era \
        soft_era \
        ~/repo/dotfiles/.zsh-theme/soft-era
    sed -E -i.bak \
        "s/^include themes.*/include themes\/edge-light/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
fi

if [ -n "${TMUX}" ]; then
    tmux source-file ~/.tmux.conf
fi
