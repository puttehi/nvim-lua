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
        vim.keymap.set("n", prefix .. "b", ts.buffers, { desc = "Open open buffers search (TS)" })
        vim.keymap.set("n", prefix .. "n", function()
            ts.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "Open nvim config search" })
        vim.keymap.set("n", prefix .. "f", ts.find_files, { desc = "Open file search (TS)" })
        vim.keymap.set("n", prefix .. "g", ts.live_grep, { desc = "Live grep from directory (TS)" })
        vim.keymap.set("n", prefix .. "q", ts.quickfix, { desc = "Open quickfix list (TS)" })
        vim.keymap.set(
            "n",
            prefix .. "l",
            ts.loclist,
            { desc = "Open loclist of current window search" }
        )
        vim.keymap.set("n", prefix .. "h", ts.help_tags, { desc = "Open help tag search (TS)" })
        vim.keymap.set("n", prefix .. "k", ts.keymaps, { desc = "Open keymap search (TS)" })
        vim.keymap.set(
            "n",
            prefix .. "*",
            ts.grep_string,
            { desc = "Open search results for word under cursor (TS)" }
        )

        -- git
        vim.keymap.set(
            "n",
            prefix_git .. "f",
            ts.git_files,
            { desc = "Open git ls-files (tracked) search (Git)" }
        )
        vim.keymap.set(
            "n",
            prefix_git .. "l",
            ts.git_commits,
            { desc = "Open git log, CR checkouts (Git)" }
        )
        vim.keymap.set(
            "n",
            prefix_git .. "b",
            ts.git_bcommits,
            { desc = "Open git log for active buffer, CR checkouts (Git)" }
        )
        vim.keymap.set(
            "n",
            prefix_git .. "s",
            ts.git_stash,
            { desc = "Open git stash, CR pops (Git)" }
        )

        -- LSP
        vim.keymap.set("n", prefix .. "d", ts.diagnostics, { desc = "Open diagnostics (LSP)" })
        vim.keymap.set(
            "n",
            prefix_lsp .. "d",
            ts.lsp_definitions,
            { desc = "Open symbol definitions (LSP)" }
        )
        vim.keymap.set(
            "n",
            prefix_lsp .. "i",
            ts.lsp_implementations,
            { desc = "Open symbol implementations (LSP)" }
        )
        vim.keymap.set(
            "n",
            prefix_lsp .. "r",
            ts.lsp_references,
            { desc = "Open symbol references (LSP)" }
        )
    end,
}
