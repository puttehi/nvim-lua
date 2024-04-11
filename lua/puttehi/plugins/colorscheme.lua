return {
    "puttehi/poimandres",
    branch = "puttehi-dark",
    config = function(_, _)
        require("puttehi_dark").setup()
        vim.cmd.colorscheme("puttehi_dark")
        --transparent bg (needs vim + terminal setting)
        --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}
