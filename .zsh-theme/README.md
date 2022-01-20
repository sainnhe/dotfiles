## Preview

![gruvbox-material-dark](https://user-images.githubusercontent.com/37491630/64084858-c9364200-cd1e-11e9-8353-492ac95d5ce2.png)

## Syntax Highlighting

The syntax highlighting is implemented by [zdharma-continuum/fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting).

The `default` theme in fast-syntax-highlighting will use the colors of your terminal emulator color scheme to highlight words, so you can set the theme to `default` and change the terminal emulator color scheme to the corresponding one to get proper syntax highlighting.

## Prompt

The prompt theme is based on [pure-power](https://github.com/romkatv/dotfiles-public/blob/master/.purepower) which is inspired by [pure](https://github.com/sindresorhus/pure), it depends on [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k).

To use it, simply source this file in your zshrc after powerlevel10k has been load:

```zsh
source /path/to/dotfiles/.zsh-theme/<color-scheme>.zsh
```

Where `<color-scheme>` is one of the following:

- `gruvbox-material-dark`
- `gruvbox-material-light`
- `gruvbox-mix-dark`
- `everforest-dark`
- `everforest-light`
- `edge-dark`
- `edge-light`
- `sonokai`
- `sonokai-andromeda`
- `sonokai-atlantis`
- `sonokai-espresso`
- `sonokai-maia`
- `sonokai-shusia`
- `soft-era`

Alternatively, if you are using [zinit](https://github.com/zdharma-continuum/zinit) (formerly known as zplugin, [highly recommended](https://gist.github.com/laggardkernel/4a4c4986ccdcaf47b91e8227f9868ded)), you can install the theme like this:

```zsh
zinit light romkatv/powerlevel10k
zinit snippet https://github.com/sainnhe/dotfiles/raw/master/.zsh-theme/<color-scheme>.zsh
```

## Customization

There are 3 modes of the prompt themes:

```zsh
PURE_POWER_MODE=modern    # use nerdfont characters in the prompt
PURE_POWER_MODE=fancy     # use unicode characters in the prompt (default)
PURE_POWER_MODE=portable  # use only ascii characters in the prompt
```

To switch between them, set this variable **Before** sourcing the color scheme file in your zshrc.

## License

[Anti-996](../LICENSE-Anti-996) && [MIT](../LICENSE-MIT) © sainnhe
