## Steps to enable user css/js

- Open [about:support](about:support)
- Find "Profile Folder" and create a symlink to the `chrome` and `user.js` in this directory.
- Open [about:config](about:config)
- Enable the following items:
  - `toolkit.legacyUserProfileCustomizations.stylesheets`
  - `layers.acceleration.force-enabled`
  - `gfx.webrender.all`
  - `gfx.webrender.enabled`
  - `layout.css.backdrop-filter.enabled`
  - `svg.context-properties.content.enabled`
- Restart Firefox

## Awesome userChrome.css

[Store](https://firefoxcss-store.github.io/)

- [artsyfriedchicken/EdgyArc-fr](https://github.com/artsyfriedchicken/EdgyArc-fr/)
- [awwpotato/PotatoFox](https://codeberg.org/awwpotato/PotatoFox): Mirrored on Gitea
