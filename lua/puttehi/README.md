# My config

This folder contains my personal configuration

## Structure

### plugins/

Neovim plugins which are either in their own files (plugin per file, like `nvim-colorizer.lua`), or in their own category (several plugins per file, like `git.lua` with fugitive and gitsigns).

### vim/

"Raw" configuration and Lua scripts outside of anything "plugin", such as base keymaps, `:set`tings etc. Things that do not depend on anything but VIM installation.
