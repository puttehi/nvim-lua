-- Default mode to open results of :Cheat with
vim.g.cheat_default_window_layout = 'vertical_split' -- Open output in vertical split. Default is nil -> floating window
-- Remaps --
vim.keymap.set("n", "<leader>Cq", ":Cheat<CR>", { desc = "Open cheat.sh query window" })
vim.keymap.set("n", "<leader>CQ", ":Cheat<CR>", { desc = "Open cheat.sh query window" })
vim.keymap.set("n", "<leader>Cl", ":CheatList<CR>", { desc = "Open cheat.sh list of categories" })
vim.keymap.set("n", "<leader>CL", ":CheatList<CR>", { desc = "Open cheat.sh list of categories" })
