local dap = require("dap")
local dap_virtual_text = require("nvim-dap-virtual-text")
local dap_go = require("dap-go")
local dapui = require("dapui")

local dap_virtual_text_opts = nil --{}
local dap_go_opts = nil --{}

local dapui_opts = {
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.25
        }, {
            id = "breakpoints",
            size = 0.25
        }, {
            id = "stacks",
            size = 0.25
        }, {
            id = "watches",
            size = 0.25
        } },
        position = "left",
        size = 40
    }, {
        elements = { {
            id = "repl",
            size = 0.5
        }, {
            id = "console",
            size = 0.5
        } },
        position = "bottom",
        size = 10
    } },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
}

-- Remaps
local prefix = "<leader>d"

vim.keymap.set("n", prefix .. "r", ":lua require'dap'.repl.open()<CR>", { desc = "Open REPL" })
vim.keymap.set("n", prefix .. "b", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle breakpoint" })
vim.keymap.set("n", prefix .. "B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { desc = "Toggle conditional breakpoint <input>" })
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", { desc = "Start debugging / Continue execution" })
vim.keymap.set("n", prefix .. "t", ":lua require'dap'.terminate()<CR>", { desc = "Terminate execution" })
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>", { desc = "Step over" })
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>", { desc = "Step into" })
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>", { desc = "Step out" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
dap_virtual_text.setup(dap_virtual_text_opts)
dap_go.setup(dap_go_opts)
dapui.setup(dapui_opts)
