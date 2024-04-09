-- Set space as <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Jumps / navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down 1/2 page, re-center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up 1/2 page, re-center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Go to next result, centered, unfolded" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Go to prev result, centered, unfolded" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Jump to next item in quickfix list" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Jump to prev item in quickfix list" })
vim.keymap.set(
    "n",
    "<leader>k",
    "<cmd>lnext<CR>zz",
    { desc = "Jump to next item in location list" }
)
vim.keymap.set(
    "n",
    "<leader>j",
    "<cmd>lprev<CR>zz",
    { desc = "Jump to prev item in location list" }
)

-- Move between windows 1-6
for i = 1, 6 do
    vim.keymap.set("n", "<leader>" .. i, i .. "<C-W>w", { desc = "Set Window " .. i .. " active" })
end
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Copy-paste
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste but retain yank buffer" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard (+)" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard (+)" })

-- Line manipulation
-- TODO: These bug with bigger selections
vim.keymap.set("n", "<C-J>", ":m '>+1<CR>gv=gv", { desc = "Move selection down by 1" })
vim.keymap.set("n", "<C-K>", ":m '<-2<CR>gv=gv", { desc = "Move selection up by 1" })

-- LSP
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format buffer (plugin: LSP)" }) -- see lua/puttehi/plugins/format.lua for option 2

-- Misc
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "<Esc>" })
vim.keymap.set("n", "Q", "<nop>", { desc = "<nop>" })

-- Terminal
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Search (non-Telescope)
-- Clear hlsearch on pressing <Esc> in normal mode to disable old annoying search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
