-- DAP and debuggers
-- NOTE: Setup order should be:
-- 1. Virtual text
-- 2. dap-go
-- 3. DAP UI
-- (Main nvim-dap does not require setup!)
return {
    {
        -- Inline virtual text for helping debugging
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
        config = function(_, _)
            require("nvim-dap-virtual-text").setup()
        end,
        dependencies = {},
    },
    {
        -- Main DAP enabler
        "mfussenegger/nvim-dap",
        dependencies = {
            -- Installs the debug adapters for you (see: lsp.lua for further usage)
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = {
                    "williamboman/mason.nvim",
                },
            },
            "theHamsta/nvim-dap-virtual-text", -- See above
            -- Debuggers
            {
                "leoluz/nvim-dap-go",
                dependencies = {
                    "mortepau/codicons.nvim",
                },
            },
        },
        config = function(_, opts)
            local dap = require("dap")

            require("mason-nvim-dap").setup({
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_setup = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                    "delve",
                },
            })
            -- Remaps
            local prefix = "<leader>d"

            vim.keymap.set("n", prefix .. "r", dap.repl.open, { desc = "Open REPL" })
            vim.keymap.set(
                "n",
                prefix .. "b",
                dap.toggle_breakpoint,
                { desc = "Toggle breakpoint" }
            )
            vim.keymap.set("n", prefix .. "B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Toggle conditional breakpoint <input>" })
            vim.keymap.set(
                "n",
                "<F5>",
                dap.continue,
                { desc = "Start debugging / Continue execution" }
            )
            vim.keymap.set("n", prefix .. "t", dap.terminate, { desc = "Terminate execution" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })

            -- Install golang specific config
            require("dap-go").setup()
        end,
    },
    {
        -- Creates a beautiful debugger UI
        "rcarriga/nvim-dap-ui",
        opts = {
            controls = {
                element = "repl",
                enabled = true,
                --[[ icons = {
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = ""
                } ]]
                -- Set icons to characters that are more likely to work in every terminal.
                --    Feel free to remove or use ones that you like more! :)
                --    Don't feel like these are good choices.
                icons = {
                    pause = "⏸",
                    play = "▶",
                    step_into = "⏎",
                    step_over = "⏭",
                    step_out = "⏮",
                    step_back = "b",
                    run_last = "▶▶",
                    terminate = "⏹",
                    disconnect = "⏏",
                },
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            force_buffers = true,
            -- High compatibility icons
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.25,
                        },
                        {
                            id = "breakpoints",
                            size = 0.25,
                        },
                        {
                            id = "stacks",
                            size = 0.25,
                        },
                        {
                            id = "watches",
                            size = 0.25,
                        },
                    },
                    position = "left",
                    size = 40,
                },
                {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5,
                        },
                        {
                            id = "console",
                            size = 0.5,
                        },
                    },
                    position = "bottom",
                    size = 10,
                },
            },
            mappings = {
                edit = "e",
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t",
            },
            render = {
                indent = 1,
                max_value_lines = 100,
            },
        },
        config = function(_, opts)
            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            --vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

            local dap = require("dap")
            local dapui = require("dapui")

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            dapui.setup(opts)
        end,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap", -- see above
        },
    },
    {
        -- Adds Telescope functionality for DAPs
        "nvim-telescope/telescope-dap.nvim",
        --opts = {},
        --config = true,
        dependencies = {
            "nvim-telescope/telescope.nvim", -- see telescope.lua
            "mfussenegger/nvim-dap", -- see above
        },
    },
}
