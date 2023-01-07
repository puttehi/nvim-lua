# personal nvim cfg

Time to learn neovim.

Based on ThePrimeagen cfg: https://www.youtube.com/watch?v=w7i4amO_zaE

## Prerequisites

1. Install [`rg`](https://github.com/BurntSushi/ripgrep)
2. Install [`fd-find`](https://github.com/sharkdp/fd)
3. Install [Packer](https://github.com/wbthomason/packer.nvim)

## Setup

1. Clone to `~/.config` as `nvim/`
2. `nvim lua/puttehi/packer.lua`
3. `:so`
4. `:PackerSync`

## Updating plugins

Steps 2. to 4. in [setup](#setup).

## Structure

- `lua/puttehi/`: Base nvim configuration (non-plugin) + Packer setup
  - `init.lua`: Load mappings and settings
  - `remap.lua`: Base remapping
  - `set.lua`: Base settings
  - `packer.lua`: Packer configuration (plugin list and colors)
- `after/plugin`: Plugin-specific configuration
  - `<plugin>.lua`: Configuration and remaps for `<plugin>`
  - `colors.lua`: Colorscheme activation
- `init.lua`: Loads `lua/puttehi/init.lua`
