# Steps to enable user css

- Open [about:support](about:support)
- Find "Profile Folder" and create a symlink to the `chrome` folder in this repository
- Open [about:config](about:config)
- Enable the following items:
  - `toolkit.legacyUserProfileCustomizations.stylesheets`
  - `layers.acceleration.force-enabled`
  - `gfx.webrender.all`
  - `gfx.webrender.enabled`
  - `layout.css.backdrop-filter.enabled`
  - `svg.context-properties.content.enabled`
- Restart Firefox
