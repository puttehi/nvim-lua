vim.g.mapleader = " "

-- Jumps / navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down 1/2 page, re-center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up 1/2 page, re-center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Go to next result, centered, unfolded" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Go to prev result, centered, unfolded" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Jump to next error in quickfix list" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Jump to prev error in quickfix list" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Jump to next error in location list" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Jump to prev error in location list" })

-- Move between windows 1-6
for i = 1, 6 do
    vim.keymap.set("n", "<leader>" .. i, i .. "<C-W>w", { desc = "Set Window " .. i .. " active" })
end

-- Copy-paste
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste but retain yank buffer" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard (+)" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard (+)" })

-- Line manipulation
vim.keymap.set("n", "<C-J>", ":m '>+1<CR>gv=gv", { desc = "Move selection down by 1" })
vim.keymap.set("n", "<C-K>", ":m '<-2<CR>gv=gv", { desc = "Move selection up by 1" })


-- LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer (LSP)" })

-- Misc
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "<Esc>" })
vim.keymap.set("n", "Q", "<nop>", { desc = "<nop>" })
