--[[
Load health checker for :checkhealth
]]

-- require("puttehi.vim.health")

--[[
Load custom initial configuration
]]

require("puttehi.vim.set")
require("puttehi.vim.remap")
require("puttehi.vim.autocmd")
require("puttehi.vim.netrw")
require("puttehi.vim.macros")

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

--[[
Install `lazy.nvim` plugin manager
See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

--[[
Configure and install plugins

To update plugins you can run :Lazy update

To sync with lock file, use :Lazy sync
]]
require("lazy").setup({
    {
        -- This reads all files in the folder (lua. prefix is not needed)
        import = "puttehi.plugins",
    },
}, {
    ui = {
        -- NerdFont enabled -> Use Lazy NerdFont defaults, otherwise use following unicode/emoji table
        -- TODO: Add toggle for dap-ui
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
    dev = {
        path = "~/dev/repos",
        ---plugins that match these patterns will use your local versions instead of being fetched from GitHub
        -- patterns = {}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
    },
})
