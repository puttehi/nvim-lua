local ts = require('telescope.builtin')

local prefix = "<leader>t"
local prefix_git = prefix .. 'G'
local prefix_lsp = prefix .. 'l'

-- base
vim.keymap.set('n', prefix .. 'f', ts.find_files, { desc = "Open file search" })
vim.keymap.set("n", prefix .. "g", ts.live_grep, { desc = "Live grep from directory" })
vim.keymap.set("n", prefix .. "q", ts.quickfix, { desc = "Open quickfix list" })
vim.keymap.set("n", prefix .. "l", ts.loclist, { desc = "Open loclist for current window" })
vim.keymap.set("n", prefix .. "*", ts.grep_string, { desc = "Open search results for word under cursor" })


-- git
vim.keymap.set('n', prefix_git .. 'f', ts.git_files, { desc = "Open git ls-files search" })
vim.keymap.set('n', prefix_git .. 'l', ts.git_commits,
    { desc = "Open git log - <CR> checks out-  <C-r>soft/hard resets" })
vim.keymap.set('n', prefix_git .. 'b', ts.git_bcommits, { desc = "Open git log for active buffer" })
vim.keymap.set('n', prefix_git .. 's', ts.git_stash, { desc = "Open git stash - <CR> to pop" })

-- LSP
vim.keymap.set('n', prefix .. 'd', ts.diagnostics, { desc = "Open diagnostics" })
vim.keymap.set('n', prefix_lsp .. 'd', ts.lsp_definitions, { desc = "Open symbol definitions" })
vim.keymap.set('n', prefix_lsp .. 'i', ts.lsp_implementations, { desc = "Open symbol implementations" })
vim.keymap.set('n', prefix_lsp .. 'r', ts.lsp_references, { desc = "Open symbol references" })
