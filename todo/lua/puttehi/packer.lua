-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

local debug_mode = false

local plugin_definitions = {
    -- Packer can manage itself
    { "wbthomason/packer.nvim" },
    --use { 'mhartington/formatter.nvim' }
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    {
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "folke/neodev.nvim" },
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },
    { "norcalli/nvim-colorizer.lua" },
    {
        "RishabhRD/nvim-cheat.sh",
        requires = { "RishabhRD/popfix" },
    },

    -- noob mode
    {
        "folke/which-key.nvim",
        disabled = true, -- attempt to not update, as which-key has custom workaround: https://github.com/folke/which-key.nvim/issues/388#issuecomment-1374499121
    },
    {
        "numToStr/Comment.nvim",
    },
    -- DAP
    {
        "mfussenegger/nvim-dap",
        requires = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            -- nvim-dap-go needs codicons
            "leoluz/nvim-dap-go",
            "mortepau/codicons.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
    },
}

if debug_mode == true then
    plugin_definitions["nvim-luadev"] = { "bfredl/nvim-luadev" }
end

require("packer").startup({ plugin_definitions })

return plugin_definitions
