# personal nvim cfg

Lazy-managed config built with the help of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

![image](https://github.com/puttehi/nvim-puttehi-dark/assets/19575408/2c46cc91-1510-40b1-8472-ca7afb7d3db7)

## Prerequisites

1. Neovim v0.11.x
    - ['v0.11.4'](https://github.com/neovim/neovim/releases/tag/v0.11.4) or
2. [`rg`](https://github.com/BurntSushi/ripgrep)
3. [`fd-find`](https://github.com/sharkdp/fd)
4. [`fzf`](https://github.com/junegunn/fzf)
5. `unzip`: `sudo apt install unzip`
6. `git`: `sudo apt install git`

### Optional but recommended

1. `xclip` to enable `<leader>y` to yank to system clipboard: `sudo apt install xclip`
2. Clean up your existing nvim plugins to prevent weird clashes. Usually `rm -rf ~/.local/share/nvim` (backup is a good idea).
3. Get a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) for snazzy symbols. I like [Fira Mono](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraMono). Make sure to set it as your terminals font (not your systems).
  - Don't care about a nerd font? Set `vim.g.have_nerd_font = false` in `init.lua`.

## Setup

1. Clone to `~/.config/` as `nvim/`: `cd ~/.config && git clone https://www.github.com/puttehi/nvim-lua nvim`
2. Start and let Lazy do its thing: `nvim`

## Updating plugins

Use `:Lazy update`. This should also update `lazy-lock.json`.

## Quickstart from scratch: Neovim build + install and dependency + config install

The official neovim build instructions are really complicated for the average
Joe that wants to build a specific tag from source.

Just do this to get this config up and running from zero:

```sh
git clone https://github.com/neovim/neovim ~/dev/repos/neovim
# Nvim build dependencies for Ubuntu
sudo apt-get install ninja-build gettext cmake curl build-essential
cd ~/dev/repos/neovim
git checkout v0.11.4
# (if checkout fails, this should definitely fix it):
git fetch --tags && git checkout v0.11.4 && git pull
# CMAKE_BUILD_TYPE defaults to Debug. RelWithDebInfo is optimized like Release
# but contains debug symbols for troubleshooting if(when) nvim shits itself
# (likely because this lua config sucked or a plugin decided to not honor semver
# anymore)
make CMAKE_BUILD_TYPE=RelWithDebInfo
# Now in .build/, move to system paths (install).
# CMAKE_INSTALL_PREFIX defaults to /usr/local, example for user-installation:
make CMAKE_INSTALL_PREFIX=$HOME/local/nvim install
# Make sure this configs dependencies are ready to go
sudo apt install unzip git fzf fd-find ripgrep xclip
git clone ssh://git@github.com:puttehi/nvim-lua.git ~/.config/nvim
# Open nvim and run :checkhealth and fix any relevant issues found. Most likely your Go version is too old (1.23+ due to used plugins), your .NET is too old (9+ due to used plugins) or similar.
```

## Structure

- `init.lua`: Main entrypoint, installs Lazy and imports everything.
- `lua/puttehi/`: Custom configuration that is imported.
- `lua/puttehi/plugins`: Plugins which are either in their own files (plugin per file, like `nvim-colorizer.lua`), or in their own category (several plugins per file, like `git.lua` with fugitive and gitsigns).
- `lua/puttehi/vim`: "Raw" configuration and Lua scripts outside of anything "plugin", such as base keymaps, `:set`tings etc. Things that do not depend on anything but VIM installation.

## Troubleshooting

### General

- Start with `:checkhealth`. Not everything must be fixed.

### Treesitter

- Start with `:Lazy update` + `:TSUpdate`.
- Find highlights under cursor with `:Inspect`-
- Debug node tree with `:InspectTree`
- Highlights refuse to work? Revert buffer to use no highlighter from TS: `:TSBufToggle highlight`.

### LSP

- Getting some weird "could not start `xxx-yyy-zzz`" errors with languages? Try adding it to `lsp.lua` under the language server, i.e. `languages["lua_ls"].tools = { "lua-language-server" }`.
- Server does not seem to be working? Check `:LSPInfo` and if it crashed, check `:LSPLog`. Filetype setting (`:set filetype=...`) could also be wrong, check with `:echo &filetype`.
- `:LSPRestart` can work when you managed to blow up the language server, IT Crowd style.

