return {
    "mbbill/undotree",
    config = function(_, _)
        -- Remaps --
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open Undo tree" })
    end,
}
