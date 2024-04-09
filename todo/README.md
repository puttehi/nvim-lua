# personal nvim cfg

Time to learn neovim.

Based on ThePrimeagen cfg: https://www.youtube.com/watch?v=w7i4amO_zaE

## Prerequisites

1. Install [`rg`](https://github.com/BurntSushi/ripgrep)
2. Install [`fd-find`](https://github.com/sharkdp/fd)
3. Install [Packer](https://github.com/wbthomason/packer.nvim)

## Setup

1. Clone to `~/.config/` as `nvim/`
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
- `docs/`: README generator scripts to run with `/generate_docs.sh`

## Keymaps

Generated with `docs/remap.lua`: `./generate_docs.sh`

<!-- DOCGEN_START -->
| mode | mapping | info | command |
| ---- | ------- | ---- | ------- |
| `n` | `%` |  | `<Plug>(MatchitNormalForward)` |
| `n` | `&` | Nvim builtin | `:&&<CR>` |
| `n` | `<C-D>` | Down 1/2 page, re-center | `<C-D>zz` |
| `n` | `<C-J>` | Move selection down by 1 | `:m '>+1<CR>gv=gv` |
| `n` | `<C-K>` | Move selection up by 1 | `:m '<-2<CR>gv=gv` |
| `n` | `<C-L>` | Nvim builtin | `<Cmd>nohlsearch\|diffupdate\|normal! <C-L><CR>` |
| `n` | `<C-Space>` | Rename symbol under cursor | `@<Lua 244: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:41>` |
| `n` | `<C-U>` | Up 1/2 page, re-center | `<C-U>zz` |
| `n` | `<Space>CL` | Open cheat.sh list of categories | `:CheatList<CR>` |
| `n` | `<Space>CQ` | Open cheat.sh query window | `:Cheat<CR>` |
| `n` | `<Space>Cl` | Open cheat.sh list of categories | `:CheatList<CR>` |
| `n` | `<Space>Cq` | Open cheat.sh query window | `:Cheat<CR>` |
| `n` | `<Space>Y` | Yank line to system clipboard (+) | `"+Y` |
| `n` | `<Space>cb` | /** Toggle blockwise comment **/ | `<Plug>(comment_toggle_blockwise)` |
| `n` | `<Space>cc` | // Toggle linewise comment | `<Plug>(comment_toggle_linewise_current)` |
| `n` | `<Space>dB` | Toggle conditional breakpoint <input> | `:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>` |
| `n` | `<Space>db` | Toggle breakpoint | `:lua require'dap'.toggle_breakpoint()<CR>` |
| `n` | `<Space>dr` | Open REPL | `:lua require'dap'.repl.open()<CR>` |
| `n` | `<Space>dt` | Terminate execution | `:lua require'dap'.terminate()<CR>` |
| `n` | `<Space>f` | Format buffer (LSP) | `<Lua 3: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:220>` |
| `n` | `<Space>gP` | Git pull --rebase | `<Lua 73: ~/.config/nvim/after/plugin/fugitive.lua:5>` |
| `n` | `<Space>gg` | Show fugitive window | `<Lua 72: vim/_editor.lua:0>` |
| `n` | `<Space>gpo` | Git push -u origin <your input> | `:Git push -u origin<Space>` |
| `n` | `<Space>gpp` | Git push | `<Lua 86: ~/.config/nvim/after/plugin/fugitive.lua:10>` |
| `n` | `<Space>j` | Jump to prev error in location list | `<Cmd>lprev<CR>zz` |
| `n` | `<Space>k` | Jump to next error in location list | `<Cmd>lnext<CR>zz` |
| `n` | `<Space>ld` | Show symbol definitions | `@<Lua 254: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:75>` |
| `n` | `<Space>li` | Show symbol implementations | `@<Lua 253: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:95>` |
| `n` | `<Space>lr` | Show symbol references | `@<Lua 249: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:556>` |
| `n` | `<Space>t*` | Open search results for word under cursor | `<Lua 274: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tGb` | Open git log for active buffer | `<Lua 277: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tGf` | Open git ls-files search | `<Lua 275: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tGl` | Open git log - <CR> checks out-  <C-r>soft/hard resets | `<Lua 276: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tGs` | Open git stash - <CR> to pop | `<Lua 278: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>td` | Open diagnostics | `<Lua 279: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tf` | Open file search | `<Lua 257: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tg` | Live grep from directory | `<Lua 258: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tl` | Open loclist for current window | `<Lua 273: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tld` | Open symbol definitions | `<Lua 280: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tli` | Open symbol implementations | `<Lua 281: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tlr` | Open symbol references | `<Lua 282: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tq` | Open quickfix list | `<Lua 272: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>u` | Open Undo tree | `<Lua 283: vim/_editor.lua:0>` |
| `n` | `<Space>y` | Yank to system clipboard (+) | `"+y` |
| `n` | `N` | Go to prev result, centered, unfolded | `Nzzzv` |
| `n` | `Q` | <nop> | `<Nop>` |
| `n` | `Y` | Nvim builtin | `y$` |
| `n` | `[%` |  | `<Plug>(MatchitNormalMultiBackward)` |
| `n` | `]%` |  | `<Plug>(MatchitNormalMultiForward)` |
| `n` | `g%` |  | `<Plug>(MatchitNormalBackward)` |
| `n` | `gx` |  | `<Plug>NetrwBrowseX` |
| `n` | `n` | Go to next result, centered, unfolded | `nzzzv` |
| `n` | `y<C-G>` | Start debugging / Continue execution | `& :<C-U>call setreg(v:register, fugitive#Object(@%))<CR>` |
| `o` | `%` |  | `<Plug>(MatchitOperationForward)` |
| `o` | `[%` |  | `<Plug>(MatchitOperationMultiBackward)` |
| `o` | `]%` |  | `<Plug>(MatchitOperationMultiForward)` |
| `o` | `g%` |  | `<Plug>(MatchitOperationBackward)` |
| `v` | `<Space>cb` | /** Toggle blockwise comment **/ | `<Plug>(comment_toggle_blockwise)` |
| `v` | `<Space>cc` | // Toggle linewise comment | `<Plug>(comment_toggle_linewise_current)` |
| `v` | `<Space>y` | Yank to system clipboard (+) | `"+y` |
| `x` | `#` | Nvim builtin | `y?\V<C-R>"<CR>` |
| `x` | `%` |  | `<Plug>(MatchitVisualForward)` |
| `x` | `*` | Nvim builtin | `y/\V<C-R>"<CR>` |
| `x` | `<Space>p` | Set Window 1 active | `"_dP` |
| `x` | `[%` |  | `<Plug>(MatchitVisualMultiBackward)` |
| `x` | `]%` |  | `<Plug>(MatchitVisualMultiForward)` |
| `x` | `a%` |  | `<Plug>(MatchitVisualTextObject)` |
| `x` | `g%` |  | `<Plug>(MatchitVisualBackward)` |
| `x` | `gx` |  | `<Plug>NetrwBrowseXVis` |
<!-- DOCGEN_END -->

# Plugins

Generated with `docs/packer.lua`: `./generate_docs.sh`

<!-- DOCGEN_PLUGS_START -->
| name | branch/tag | commit | info | requires |
| ---- | ---------- | ------ | ---- | -------- |
| `wbthomason/packer.nvim` | `master/main` | latest |  |  |
| `nvim-telescope/telescope.nvim` | `0.1.0` | latest |  | `{ { "nvim-lua/plenary.nvim" } }` |
| `puttehi/poimandres` | `puttehi-dark` | latest |  |  |
| `nvim-treesitter/nvim-treesitter` | `master/main` | latest |  |  |
| `nvim-treesitter/playground` | `master/main` | latest |  |  |
| `nvim-treesitter/nvim-treesitter-context` | `master/main` | latest |  |  |
| `p00f/nvim-ts-rainbow` | `master/main` | latest |  |  |
| `mbbill/undotree` | `master/main` | latest |  |  |
| `tpope/vim-fugitive` | `master/main` | latest |  |  |
| `VonHeikemen/lsp-zero.nvim` | `master/main` | latest |  | `{ { "neovim/nvim-lspconfig" }, { "williamboman/mason.nvim" }, { "williamboman/mason-lspconfig.nvim" }, { "hrsh7th/nvim-cmp" }, { "hrsh7th/cmp-buffer" }, { "hrsh7th/cmp-path" }, { "saadparwaiz1/cmp_luasnip" }, { "hrsh7th/cmp-nvim-lsp" }, { "hrsh7th/cmp-nvim-lua" }, { "L3MON4D3/LuaSnip" }, { "rafamadriz/friendly-snippets" } }` |
| `nvim-lualine/lualine.nvim` | `master/main` | latest |  | `"opt: kyazdani42/nvim-web-devicons"` |
| `norcalli/nvim-colorizer.lua` | `master/main` | latest |  |  |
| `RishabhRD/nvim-cheat.sh` | `master/main` | latest |  | `{ "RishabhRD/popfix" }` |
| `folke/which-key.nvim` | `master/main` | latest |  |  |
| `numToStr/Comment.nvim` | `master/main` | latest |  |  |
| `mfussenegger/nvim-dap` | `master/main` | latest |  | `{ "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui", "leoluz/nvim-dap-go", "nvim-telescope/telescope-dap.nvim" }` |
<!-- DOCGEN_PLUGS_END -->
