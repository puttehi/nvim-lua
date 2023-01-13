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

## Keymaps

Generated with `docs/docs.lua`: `./keymaps_docs.sh`

By default, the generator will append in to the end of the `$PWD/README.md` but you can manually set or move the tags to choose the injection location.

<!-- DOCGEN_START -->
| mode | mapping | info | command |
| ---- | ------- | ---- | ------- |
| `n` | `%` |  | `<Plug>(MatchitNormalForward)` |
| `n` | `&` | Nvim builtin | `:&&<CR>` |
| `n` | `<C-D>` | Down 1/2 page, re-center | `<C-D>zz` |
| `n` | `<C-J>` | Move selection down by 1 | `:m '>+1<CR>gv=gv` |
| `n` | `<C-K>` | Move selection up by 1 | `:m '<-2<CR>gv=gv` |
| `n` | `<C-L>` | Nvim builtin | `<Cmd>nohlsearch|diffupdate|normal! <C-L><CR>` |
| `n` | `<C-Space>` | Rename symbol under cursor | `@<Lua 156: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:41>` |
| `n` | `<C-U>` | Up 1/2 page, re-center | `<C-U>zz` |
| `n` | `<Space>CL` | Open cheat.sh list of categories | `:CheatList<CR>` |
| `n` | `<Space>CQ` | Open cheat.sh query window | `:Cheat<CR>` |
| `n` | `<Space>Cl` | Open cheat.sh list of categories | `:CheatList<CR>` |
| `n` | `<Space>Cq` | Open cheat.sh query window | `:Cheat<CR>` |
| `n` | `<Space>Y` | Yank line to system clipboard (+) | `"+Y` |
| `n` | `<Space>f` | Format buffer (LSP) | `<Lua 3: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:220>` |
| `n` | `<Space>gP` | Git pull --rebase | `<Lua 46: ~/.config/nvim/after/plugin/fugitive.lua:5>` |
| `n` | `<Space>gg` | Show fugitive window | `<Lua 45: vim/_editor.lua:0>` |
| `n` | `<Space>gpo` | Git push -u origin <your input> | `:Git push -u origin<Space>` |
| `n` | `<Space>gpp` | Git push | `<Lua 59: ~/.config/nvim/after/plugin/fugitive.lua:10>` |
| `n` | `<Space>j` | Jump to prev error in location list | `<Cmd>lprev<CR>zz` |
| `n` | `<Space>k` | Jump to next error in location list | `<Cmd>lnext<CR>zz` |
| `n` | `<Space>ld` | Show symbol definitions | `@<Lua 158: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:75>` |
| `n` | `<Space>li` | Show symbol implementations | `@<Lua 159: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:95>` |
| `n` | `<Space>lr` | Show symbol references | `@<Lua 160: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:556>` |
| `n` | `<Space>tG` | Grep from directory without preview | `<Lua 124: ~/.config/nvim/after/plugin/telescope.lua:4>` |
| `n` | `<Space>tf` | Open file search | `<Lua 111: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>tg` | Live grep from directory | `<Lua 125: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483>` |
| `n` | `<Space>u` | Open Undo tree | `<Lua 112: vim/_editor.lua:0>` |
| `n` | `<Space>y` | Yank to system clipboard (+) | `"+y` |
| `n` | `N` | Go to prev result, centered, unfolded | `Nzzzv` |
| `n` | `Q` | <nop> | `<Nop>` |
| `n` | `Y` | Nvim builtin | `y$` |
| `n` | `[%` |  | `<Plug>(MatchitNormalMultiBackward)` |
| `n` | `]%` |  | `<Plug>(MatchitNormalMultiForward)` |
| `n` | `g%` |  | `<Plug>(MatchitNormalBackward)` |
| `n` | `gx` |  | `<Plug>NetrwBrowseX` |
| `n` | `n` | Go to next result, centered, unfolded | `nzzzv` |
| `n` | `y<C-G>` |  | `& :<C-U>call setreg(v:register, fugitive#Object(@%))<CR>` |
| `o` | `%` |  | `<Plug>(MatchitOperationForward)` |
| `o` | `[%` |  | `<Plug>(MatchitOperationMultiBackward)` |
| `o` | `]%` |  | `<Plug>(MatchitOperationMultiForward)` |
| `o` | `g%` |  | `<Plug>(MatchitOperationBackward)` |
| `v` | `<Space>y` | Yank to system clipboard (+) | `"+y` |
| `x` | `#` | Nvim builtin | `y?\V<C-R>"<CR>` |
| `x` | `%` |  | `<Plug>(MatchitVisualForward)` |
| `x` | `*` | Nvim builtin | `y/\V<C-R>"<CR>` |
| `x` | `<Space>p` | Paste but retain yank buffer | `"_dP` |
| `x` | `[%` |  | `<Plug>(MatchitVisualMultiBackward)` |
| `x` | `]%` |  | `<Plug>(MatchitVisualMultiForward)` |
| `x` | `a%` |  | `<Plug>(MatchitVisualTextObject)` |
| `x` | `g%` |  | `<Plug>(MatchitVisualBackward)` |
| `x` | `gx` |  | `<Plug>NetrwBrowseXVis` |
<!-- DOCGEN_END -->
