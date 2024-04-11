return {
    "nvim-tree/nvim-web-devicons",
    -- NOTE: Latest is broken (invalid HL group name)
    commit = "20921d33",
    -- See root init.lua
    enabled = vim.g.have_nerd_font,
    lazy = true, -- TODO: Needed? Used with previous kyazdani42/nvim-web-devicons
}
