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

| mode | mapping | info | command |
| ---- | ------- | ---- | ------- |
| n | <Space>lr | Show symbol references | *@<Lua 129: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:556> |
| n | ] |  | * <Cmd>lua require("which-key").show("]", {mode = "n", auto = true})<CR> |
| n | <C-D> | Down 1/2 page, re-center | * <C-D>zz |
| n | [ |  | * <Cmd>lua require("which-key").show("[", {mode = "n", auto = true})<CR> |
| n | ]% |  | <Plug>(MatchitNormalMultiForward) |
| n | g |  | * <Cmd>lua require("which-key").show("g", {mode = "n", auto = true})<CR> |
| n | N | Go to prev result, centered, unfolded | * Nzzzv |
| n | ' |  | * <Cmd>lua require("which-key").show("'", {mode = "n", auto = true})<CR> |
| n | & | Nvim builtin | * :&&<CR> |
| n | Q | <nop> | * <Nop> |
| n | @ |  | * <Cmd>lua require("which-key").show("@", {mode = "n", auto = true})<CR> |
| n | % |  | <Plug>(MatchitNormalForward) |
| n | gx |  | <Plug>NetrwBrowseX |
| n | <Plug>(MatchitNormalBackward) |  | * :<C-U>call matchit#Match_wrapper('',0,'n')<CR> |
| n | <Plug>(MatchitNormalMultiBackward) |  | * :<C-U>call matchit#MultiMatch("bW", "n")<CR> |
| n | <Plug>(MatchitNormalMultiForward) |  | * :<C-U>call matchit#MultiMatch("W",  "n")<CR> |
| n | <Plug>(MatchitNormalForward) |  | * :<C-U>call matchit#Match_wrapper('',1,'n')<CR> |
| n | <C-K> | Move selection up by 1 | * :m '<-2<CR>gv=gv |
| n | <C-J> | Move selection down by 1 | * :m '>+1<CR>gv=gv |
| n | <C-U> | Up 1/2 page, re-center | * <C-U>zz |
| n | <Plug>NetrwBrowseX |  | * :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))<CR> |
| n | <Plug>fugitive:y<C-G> |  | & :<C-U>call setreg(v:register, fugitive#Object(@%))<CR> |
| n | y |  | * <Cmd>lua require("which-key").show("y", {mode = "n", auto = true})<CR> |
| n | <Plug>PlenaryTestFile |  | * :lua require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))<CR> |
| n | z |  | * <Cmd>lua require("which-key").show("z", {mode = "n", auto = true})<CR> |
| n | <Plug>fugitive: |  | & <Nop> |
| n | <C-W> |  | * <Cmd>lua require("which-key").show("\23", {mode = "n", auto = true})<CR> |
| n | " |  | * <Cmd>lua require("which-key").show("\"", {mode = "n", auto = true})<CR> |
| n | <C-L> | Nvim builtin | * <Cmd>nohlsearch|diffupdate|normal! <C-L><CR> |
| n | <Space>tG | Grep from directory without preview | * <Lua 124: ~/.config/nvim/after/plugin/telescope.lua:4> |
| n | <Space> |  | * <Cmd>lua require("which-key").show(" ", {mode = "n", auto = true})<CR> |
| n | <C-Space> | Rename symbol under cursor | *@<Lua 161: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:41> |
| n | gd |  | *@<Cmd>lua vim.lsp.buf.definition()<CR> |
| n | <Space>tg | Live grep from directory | * <Lua 125: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483> |
| n | <Space>CL | Open cheat.sh list of categories | * :CheatList<CR> |
| n | <Space>tf | Open file search | * <Lua 111: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483> |
| n | <Space>Cl | Open cheat.sh list of categories | * :CheatList<CR> |
| n | <Space>CQ | Open cheat.sh query window | * :Cheat<CR> |
| n | gD |  | *@<Cmd>lua vim.lsp.buf.declaration()<CR> |
| n | go |  | *@<Cmd>lua vim.lsp.buf.type_definition()<CR> |
| n | K |  | *@<Cmd>lua vim.lsp.buf.hover()<CR> |
| n | <Space>ld | Show symbol definitions | *@<Lua 145: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:75> |
| n | <Space>li | Show symbol implementations | *@<Lua 128: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:95> |
| n | gi |  | *@<Cmd>lua vim.lsp.buf.implementation()<CR> |
| n | [d |  | *@<Cmd>lua vim.diagnostic.goto_prev()<CR> |
| n | gl |  | *@<Cmd>lua vim.diagnostic.open_float()<CR> |
| n | ]d |  | *@<Cmd>lua vim.diagnostic.goto_next()<CR> |
| n | gr |  | *@<Cmd>lua vim.lsp.buf.references()<CR> |
| n | <Space>Cq | Open cheat.sh query window | * :Cheat<CR> |
| n | <Space>u | Open Undo tree | * <Lua 112: vim/_editor.lua:0> |
| n | <Space>f | Format buffer (LSP) | * <Lua 3: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:220> |
| n | <Space>gP | Git pull --rebase | * <Lua 46: ~/.config/nvim/after/plugin/fugitive.lua:5> |
| n | <Space>j | Jump to prev error in location list | * <Cmd>lprev<CR>zz |
| n | <Space>y | Yank to system clipboard (+) | * "+y |
| n | <Space>gpp | Git push | * <Lua 59: ~/.config/nvim/after/plugin/fugitive.lua:10> |
| n | <Space>Y | Yank line to system clipboard (+) | * "+Y |
| n | ! |  | * <Cmd>lua require("which-key").show("!", {mode = "n", auto = true})<CR> |
| n | <Space>gg | Show fugitive window | * <Lua 45: vim/_editor.lua:0> |
| n | <Space>gpo | Git push -u origin <your input> | * :Git push -u origin<Space> |
| o | <Plug>(MatchitOperationMultiForward) |  | * :<C-U>call matchit#MultiMatch("W",  "o")<CR> |
| o | <Plug>(MatchitOperationMultiBackward) |  | * :<C-U>call matchit#MultiMatch("bW", "o")<CR> |
| o | [% |  | <Plug>(MatchitOperationMultiBackward) |
| o | % |  | <Plug>(MatchitOperationForward) |
| o | g% |  | <Plug>(MatchitOperationBackward) |
| o | ]% |  | <Plug>(MatchitOperationMultiForward) |
| o | <Plug>(MatchitOperationForward) |  | * :<C-U>call matchit#Match_wrapper('',1,'o')<CR> |
| o | <Plug>(MatchitOperationBackward) |  | * :<C-U>call matchit#Match_wrapper('',0,'o')<CR> |
| s | <Plug>luasnip-expand-snippet |  | * <Cmd>lua require'luasnip'.expand()<CR> |
| s | <Plug>luasnip-expand-or-jump | <Plug>luasnip-delete-check * <Cmd>lua require'luasnip'.unlink_current_if_deleted()<CR> | * <Cmd>lua require'luasnip'.expand_or_jump()<CR> |
| s | <Plug>luasnip-jump-next |  | * <Cmd>lua require'luasnip'.jump(1)<CR> |
| s | <Plug>luasnip-prev-choice |  | * <Cmd>lua require'luasnip'.change_choice(-1)<CR> |
| s | <Plug>luasnip-next-choice |  | * <Cmd>lua require'luasnip'.change_choice(1)<CR> |
| s | <Plug>luasnip-jump-prev |  | * <Cmd>lua require'luasnip'.jump(-1)<CR> |
| s | <C-D> | cmp.utils.keymap.set_map | * <Lua 172: ~/.local/share/nvim/site/pack/packer/start/nvim-cmp/lua/cmp/utils/keymap.lua:127> |
| s | <S-Tab> | cmp.utils.keymap.set_map | * <Lua 166: ~/.local/share/nvim/site/pack/packer/start/nvim-cmp/lua/cmp/utils/keymap.lua:127> |
| v | <Space>y | Yank to system clipboard (+) | * "+y |
| x | [% |  | <Plug>(MatchitVisualMultiBackward) |
| x | gx |  | <Plug>NetrwBrowseXVis |
| x | <Plug>(MatchitVisualBackward) |  | * :<C-U>call matchit#Match_wrapper('',0,'v')<CR>m'gv`` |
| x | <Plug>(MatchitVisualForward) |  | * :<C-U>call matchit#Match_wrapper('',1,'v')<CR>:if col("''") != col("$") | exe ":normal! m'" | endif<CR>gv`` |
| x | a |  | * <Cmd>lua require("which-key").show("a", {mode = "v", auto = true})<CR> |
| x | % |  | <Plug>(MatchitVisualForward) |
| x | <Plug>(MatchitVisualMultiBackward) |  | * :<C-U>call matchit#MultiMatch("bW", "n")<CR>m'gv`` |
| x | <Plug>(MatchitVisualMultiForward) |  | * :<C-U>call matchit#MultiMatch("W",  "n")<CR>m'gv`` |
| x | ]% |  | <Plug>(MatchitVisualMultiForward) |
| x | <Space>p | Paste but retain yank buffer | * "_dP |
| x | <Plug>NetrwBrowseXVis |  | * :<C-U>call netrw#BrowseXVis()<CR> |
| x | <Plug>(MatchitVisualTextObject) |  | <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward) |
| x | " |  | * <Cmd>lua require("which-key").show("\"", {mode = "v", auto = true})<CR> |
| x | g% |  | <Plug>(MatchitVisualBackward) |
| x | i |  | * <Cmd>lua require("which-key").show("i", {mode = "v", auto = true})<CR> |
| x | # | Nvim builtin | * y?\V<C-R>"<CR> |

