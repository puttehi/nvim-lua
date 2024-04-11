return {
    -- Git UI
    {
        "tpope/vim-fugitive",
        config = function(_, _)
            -- Remaps --
            local prefix = "<leader>g"

            vim.keymap.set("n", prefix .. "g", vim.cmd.Git, { desc = "Show fugitive window" })
            vim.keymap.set("n", prefix .. "P", function()
                vim.cmd.Git({ "pull", "--rebase" })
            end, { desc = "Git pull --rebase" })

            -- p ...
            vim.keymap.set("n", prefix .. "pp", function()
                vim.cmd.Git("push")
            end, { desc = "Git push" })
            vim.keymap.set(
                "n",
                prefix .. "po",
                ":Git push -u origin ",
                { desc = "Git push -u origin <your input>" }
            )
        end,
    },
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns` to understand what the configuration keys do
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
        config = true,
    },
}
