# personal nvim cfg

Lazy-managed config built with the help of [kickstart.nvim](TODO).

## Prerequisites

1. Neovim v0.9.x
    - ['stable'](https://github.com/neovim/neovim/releases/tag/stable) or
    - ['nightly'](https://github.com/neovim/neovim/releases/tag/nightly)
    - NOTE: I personally use v0.9.5 for now, built from source: `make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim" CMAKE_BUILD_TYPE=Release && make install`
2. [`rg`](https://github.com/BurntSushi/ripgrep)
3. [`fd-find`](https://github.com/sharkdp/fd)
4. [`fzf`](https://github.com/junegunn/fzf)
5. `unzip`: `sudo apt install unzip`
6. `git`: `sudo apt install git`

Clean up your existing nvim plugins to prevent weird clashes. Usually `rm -rf ~/.local/share/nvim`.

## Setup

1. Clone to `~/.config/` as `nvim/`: `cd ~/.config && git clone https://www.github.com/puttehi/nvim-lua` nvim`
2. Start and let Lazy do its thing: `nvim`

## Updating plugins

Use `:Lazy update`. This should also update `lazy-lock.json`.

## Structure

- `init.lua`: Main entrypoint, installs Lazy and imports everything.
- `lua/puttehi/`: Custom configuration that is imported.
- `lua/puttehi/plugins`: Plugins which are either in their own files (plugin per file, like `nvim-colorizer.lua`), or in their own category (several plugins per file, like `git.lua` with fugitive and gitsigns).
- `lua/puttehi/vim`: "Raw" configuration and Lua scripts outside of anything "plugin", such as base keymaps, `:set`tings etc. Things that do not depend on anything but VIM installation.

