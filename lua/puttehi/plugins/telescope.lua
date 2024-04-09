return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- See devicons.lua
        "nvim-telescope/telescope-ui-select.nvim",
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            "nvim-telescope/telescope-fzf-native.nvim",

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = "make",

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
    },
    config = function()
        -- See `:help telescope` and `:help telescope.setup()`
        require("telescope").setup({
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            -- defaults = {
            --   mappings = {
            --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --   },
            -- },
            -- pickers = {}
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        -- Enable Telescope extensions if they are installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        -- See `:help telescope.builtin`
        local ts = require("telescope.builtin")

        local prefix = "<leader>t"
        local prefix_git = prefix .. "G"
        local prefix_lsp = prefix .. "l"

        -- base
        -- TODO: Some nice kickstart.nvim defaults to explore
        --vim.keymap.set("n", "<leader>sr", ts.resume, { desc = "[S]earch [R]esume" })
        --vim.keymap.set( "n", "<leader>s.", ts.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set("n", prefix .. "b", ts.buffers, { desc = "TS: Open open buffers search" })
        vim.keymap.set("n", "<leader>sn", function()
            ts.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "TS: Open nvim config search" })
        vim.keymap.set("n", prefix .. "f", ts.find_files, { desc = "TS: Open file search" })
        vim.keymap.set("n", prefix .. "g", ts.live_grep, { desc = "TS: Live grep from directory" })
        vim.keymap.set("n", prefix .. "q", ts.quickfix, { desc = "TS: Open quickfix list" })
        vim.keymap.set(
            "n",
            prefix .. "l",
            ts.loclist,
            { desc = "Open loclist of current window search" }
        )
        vim.keymap.set("n", prefix .. "h", ts.help_tags, { desc = "TS: Open help tag search" })
        vim.keymap.set("n", prefix .. "k", ts.keymaps, { desc = "TS: Open keymap search" })
        vim.keymap.set(
            "n",
            prefix .. "*",
            ts.grep_string,
            { desc = "TS: Open search results for word under cursor" }
        )

        -- git
        vim.keymap.set("n", prefix_git .. "f", ts.git_files, { desc = "Open git ls-files search" })
        vim.keymap.set(
            "n",
            prefix_git .. "l",
            ts.git_commits,
            { desc = "Git: Open git log - CR checks out - C-r soft/hard resets" }
        )
        vim.keymap.set(
            "n",
            prefix_git .. "b",
            ts.git_bcommits,
            { desc = "Git: Open git log for active buffer" }
        )
        vim.keymap.set(
            "n",
            prefix_git .. "s",
            ts.git_stash,
            { desc = "Git: Open git stash - CR to pop" }
        )

        -- LSP
        vim.keymap.set("n", prefix .. "d", ts.diagnostics, { desc = "LSP: Open diagnostics" })
        vim.keymap.set(
            "n",
            prefix_lsp .. "d",
            ts.lsp_definitions,
            { desc = "LSP: Open symbol definitions" }
        )
        vim.keymap.set(
            "n",
            prefix_lsp .. "i",
            ts.lsp_implementations,
            { desc = "LSP: Open symbol implementations" }
        )
        vim.keymap.set(
            "n",
            prefix_lsp .. "r",
            ts.lsp_references,
            { desc = "LSP: Open symbol references" }
        )
    end,
}
