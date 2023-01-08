-- Remaps --
local prefix = "<leader>g"

vim.keymap.set("n", prefix .. "g", vim.cmd.Git, { desc = "Show fugitive window" })
vim.keymap.set("n", prefix .. "P", function()
    vim.cmd.Git({ 'pull', '--rebase' })
end, { desc = "Git pull --rebase" })

-- p ...
vim.keymap.set("n", prefix .. "pp", function()
    vim.cmd.Git('push')
end, { desc = "Git push" })
vim.keymap.set("n", prefix .. "po", ":Git push -u origin ", { desc = "Git push -u origin <your input>" })
