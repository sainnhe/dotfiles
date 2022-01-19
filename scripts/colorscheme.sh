#!/usr/bin/env bash

echo ""
echo "[1]  Gruvbox Material Dark"
echo "[2]  Gruvbox Mix Dark"
echo "[3]  Gruvbox Material Light"
echo "[4]  Edge Dark"
echo "[5]  Edge Light"
echo "[6]  Everforest Dark"
echo "[7]  Everforest Light"
echo "[8]  Sonokai"
echo "[9]  Sonokai Shusia"
echo "[10] Sonokai Andromeda"
echo "[11] Sonokai Atlantis"
echo "[12] Sonokai Maia"
echo "[13] Sonokai Espresso"
echo "[14] Soft Era"
echo ""

read -r THEME
if [ "$THEME"x == ""x ]; then
    exit
fi

_switch_color_scheme() {
    sed -E -i.bak \
        "s/let g:vim_color_scheme = '.*'/let g:vim_color_scheme = '$2'/" \
        ~/.config/nvim/envs.vim && \
        rm ~/.config/nvim/envs.vim.bak
    sed -E -i.bak \
        "s/^source.*/source ~\/\.tmux\/tmuxline\/$1\.tmux\.conf/" \
        ~/.tmux.conf && \
        rm ~/.tmux.conf.bak
    sed -E -i.bak \
        "s/^include themes.*/include themes\/$1/" \
        ~/.config/zathura/zathurarc && \
        rm ~/.config/zathura/zathurarc.bak
    rm ~/.zsh-theme
    cp -f "$3" ~/.zsh-theme
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
tmux source-file ~/.tmux.conf
unset _switch_color_scheme
