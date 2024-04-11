return {
    -- Color scheme and Lualine theme
    "puttehi/nvim-puttehi-dark",
    opts = {},
    config = function(_, _)
        require("nvim-puttehi-dark").setup()
        vim.cmd.colorscheme("puttehi-dark")
    end,
}
