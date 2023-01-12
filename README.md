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
| n | \<Space>u | Open Undo tree | * \<Lua 112: vim/_editor.lua:0> |
| n | gx |  | \<Plug>NetrwBrowseX |
| n | g% |  | \<Plug>(MatchitNormalBackward) |
| n | n | Go to next result, centered, unfolded | * nzzzv |
| n | y\<C-G> |  | & :\<C-U>call setreg(v:register, fugitive#Object(@%))<CR> |
| n | \<C-D> | Down 1/2 page, re-center | * \<C-D>zz |
| n | [% |  | \<Plug>(MatchitNormalMultiBackward) |
| n | ]% |  | \<Plug>(MatchitNormalMultiForward) |
| n | Q | \<nop> | * \<Nop> |
| n | Y | Nvim builtin | * y$ |
| n | N | Go to prev result, centered, unfolded | * Nzzzv |
| n | \<Plug>fugitive: |  | & \<Nop> |
| n | \<Plug>PlenaryTestFile |  | * :lua require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))\<CR> |
| n | \<C-J> | Move selection down by 1 | * :m '>+1\<CR>gv=gv |
| n | \<C-K> | Move selection up by 1 | * :m '\<-2<CR>gv=gv |
| n | \<C-U> | Up 1/2 page, re-center | * \<C-U>zz |
| n | \<Plug>fugitive:y<C-G> |  | & :\<C-U>call setreg(v:register, fugitive#Object(@%))<CR> |
| n | \<Plug>(MatchitNormalForward) |  | * :\<C-U>call matchit#Match_wrapper('',1,'n')<CR> |
| n | \<Plug>(MatchitNormalMultiBackward) |  | * :\<C-U>call matchit#MultiMatch("bW", "n")<CR> |
| n | \<Plug>(MatchitNormalBackward) |  | * :\<C-U>call matchit#Match_wrapper('',0,'n')<CR> |
| n | \<Plug>NetrwBrowseX |  | * :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))\<CR> |
| n | \<Plug>(MatchitNormalMultiForward) |  | * :\<C-U>call matchit#MultiMatch("W",  "n")<CR> |
| n | & | Nvim builtin | * :&&\<CR> |
| n | \<C-L> | Nvim builtin | * \<Cmd>nohlsearch|diffupdate|normal! <C-L><CR> |
| n | \<Space>Cq | Open cheat.sh query window | * :Cheat\<CR> |
| n | \<Space>gg | Show fugitive window | * \<Lua 45: vim/_editor.lua:0> |
| n | \<Space>f | Format buffer (LSP) | * \<Lua 3: /usr/local/share/nvim/runtime/lua/vim/lsp/buf.lua:220> |
| n | \<Space>CQ | Open cheat.sh query window | * :Cheat\<CR> |
| n | \<Space>y | Yank to system clipboard (+) | * "+y |
| n | \<Space>gP | Git pull --rebase | * \<Lua 46: ~/.config/nvim/after/plugin/fugitive.lua:5> |
| n | % |  | \<Plug>(MatchitNormalForward) |
| n | \<Space>gpp | Git push | * \<Lua 59: ~/.config/nvim/after/plugin/fugitive.lua:10> |
| n | \<Space>gpo | Git push -u origin \<your input> | * :Git push -u origin\<Space> |
| n | \<Space>Cl | Open cheat.sh list of categories | * :CheatList\<CR> |
| n | \<Space>Y | Yank line to system clipboard (+) | * "+Y |
| n | \<Space>tf | Open file search | * \<Lua 111: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483> |
| n | \<Space>j | Jump to prev error in location list | * \<Cmd>lprev<CR>zz |
| n | \<Space>tg | Live grep from directory | * \<Lua 125: ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/builtin/init.lua:483> |
| n | \<Space>k | Jump to next error in location list | * \<Cmd>lnext<CR>zz |
| n | \<Space>tG | Grep from directory without preview | * \<Lua 124: ~/.config/nvim/after/plugin/telescope.lua:4> |
| n | \<Space>CL | Open cheat.sh list of categories | * :CheatList\<CR> |
| o | g% |  | \<Plug>(MatchitOperationBackward) |
| o | \<Plug>(MatchitOperationBackward) |  | * :\<C-U>call matchit#Match_wrapper('',0,'o')<CR> |
| o | \<Plug>(MatchitOperationMultiBackward) |  | * :\<C-U>call matchit#MultiMatch("bW", "o")<CR> |
| o | [% |  | \<Plug>(MatchitOperationMultiBackward) |
| o | % |  | \<Plug>(MatchitOperationForward) |
| o | \<Plug>(MatchitOperationForward) |  | * :\<C-U>call matchit#Match_wrapper('',1,'o')<CR> |
| o | ]% |  | \<Plug>(MatchitOperationMultiForward) |
| o | \<Plug>(MatchitOperationMultiForward) |  | * :\<C-U>call matchit#MultiMatch("W",  "o")<CR> |
| s | \<Plug>luasnip-prev-choice |  | * \<Cmd>lua require'luasnip'.change_choice(-1)<CR> |
| s | \<Plug>luasnip-expand-or-jump | \<Plug>luasnip-delete-check * <Cmd>lua require'luasnip'.unlink_current_if_deleted()<CR> | * \<Cmd>lua require'luasnip'.expand_or_jump()<CR> |
| s | \<Plug>luasnip-jump-next |  | * \<Cmd>lua require'luasnip'.jump(1)<CR> |
| s | \<Plug>luasnip-next-choice |  | * \<Cmd>lua require'luasnip'.change_choice(1)<CR> |
| s | \<Plug>luasnip-jump-prev |  | * \<Cmd>lua require'luasnip'.jump(-1)<CR> |
| s | \<Plug>luasnip-expand-snippet |  | * \<Cmd>lua require'luasnip'.expand()<CR> |
| v | \<Space>y | Yank to system clipboard (+) | * "+y |
| x | \<Plug>(MatchitVisualBackward) |  | * :\<C-U>call matchit#Match_wrapper('',0,'v')<CR>m'gv`` |
| x | \<Plug>(MatchitVisualForward) |  | * :\<C-U>call matchit#Match_wrapper('',1,'v')<CR>:if col("''") != col("$") | exe ":normal! m'" | endif<CR>gv`` |
| x | * | Nvim builtin | * y/\V\<C-R>"<CR> |
| x | \<Plug>(MatchitVisualMultiForward) |  | * :\<C-U>call matchit#MultiMatch("W",  "n")<CR>m'gv`` |
| x | [% |  | \<Plug>(MatchitVisualMultiBackward) |
| x | ]% |  | \<Plug>(MatchitVisualMultiForward) |
| x | # | Nvim builtin | * y?\V\<C-R>"<CR> |
| x | % |  | \<Plug>(MatchitVisualForward) |
| x | \<Plug>(MatchitVisualMultiBackward) |  | * :\<C-U>call matchit#MultiMatch("bW", "n")<CR>m'gv`` |
| x | a% |  | \<Plug>(MatchitVisualTextObject) |
| x | g% |  | \<Plug>(MatchitVisualBackward) |
| x | \<Space>p | Paste but retain yank buffer | * "_dP |
| x | \<Plug>(MatchitVisualTextObject) |  | \<Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward) |
| x | \<Plug>NetrwBrowseXVis |  | * :\<C-U>call netrw#BrowseXVis()<CR> |
| x | gx |  | \<Plug>NetrwBrowseXVis |

