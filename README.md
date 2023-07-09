## Gallery

![demo-1](https://gitlab.com/sainnhe/img/-/raw/master/dotfiles-1.png)

![demo-2](https://gitlab.com/sainnhe/img/-/raw/master/dotfiles-2.png)

![demo-3](https://gitlab.com/sainnhe/img/-/raw/master/dotfiles-3.png)

## About

This repository contains my personal configuration files for development on Windows && macOS && Linux (mainly for Arch).

It's not recommended to directly copy my configs, unless you know what they mean. Google and the manual pages are your best friends when exploring the open source world.

However I built a container image for portable development, you can try it out if you are interested in my config :)

This container image is based on alpine and will be built on schedule. It features the following:

- Vim/Neovim
- Zsh
- Tmux
- Some UNIX Development Tools

To try it, install podman and run this command:

```shell
podman run -it --rm <registry>/sainnhe/dotfiles:latest
```

Where `<registry>` is one of the following:

- [`ghcr.io`](https://github.com/sainnhe/dotfiles/pkgs/container/dotfiles)
- [`quay.io`](https://quay.io/repository/sainnhe/dotfiles)

To access local directory in the container, use:

```shell
podman run -v <workdir-on-local-machine>:/root/work -it --rm sainnhe/dotfiles:latest
```

Where `<workdir-on-local-machine>` is the path of the directory you want to access on your local machine.

## Tips

- Don't forget to install nerd font for your terminal emulater.
- Execute `tmuxinit` in zsh to start a tmux session.
- Press Ctrl-Space twice to launch tmux-fzf which can help you better manage tmux environment.
- Execute `colorscheme` in zsh to switch color schemes.
- Press Space in Vim/Neovim normal mode to get a set of shortcuts.

## License

[MIT](./LICENSE-MIT) && [Anti-996](./LICENSE-Anti-996) © sainnhe
