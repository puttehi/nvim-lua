-- LSP Configuration & Plugins
-- Install and enable the following language servers
-- These use lspconfig names: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
-- Structure:
--   [key](string):
--     Server name in lspconfig format (e.g. lua-language-server will be ["lua_ls"]
--
--     server_config(table):
--       You can pass in extra configuration to override the defaults here for mason-lspconfig
--       - cmd (table): Override the default command used to start the server
--       - filetypes (table): Override the default list of associated filetypes for the server
--       - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--       - settings (table): Override the default settings passed when initializing the server.
--             For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
--
--       NOTE: These might miss some required tooling, which is usually present in some related error message, e.g. "lua-language-server not found".
--
--     tools(table):
--       You can add other tools here that you want Mason to install using mason-tool-installer
--       so they are available in the Neovim environment. These work with both lspconfig and regular Mason names.
--       https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
--       You can pass in a string for defaults, or a table for further configuration:
--       - auto_update(bool): Update automatically? (false)
--       - run_on_start(bool): Install/update on Neovim startup? (true)
--       - start_delay(number): Milliseconds until starting to run. (3000)
--       - debounce_hours(number): Hours between startups to wait before updating again (5)
--       - version(string): Tool version to pin to (nil)
--
--       NOTE: "tool" or {"tool", auto_update = ..., run_on_start = ...}

local languages = {
    ["ansiblels"] = {
        server_config = {},
        tools = {},
    }, -- Ansible
    ["bashls"] = {
        server_config = {},
        tools = { "shellcheck" },
    }, -- Bash
    ["diagnosticls"] = {
        server_config = {
            cmd = { "diagnostic-languageserver", "--stdio" },
            --args = { "--log-level", "5" },
            filetypes = { "python", "shell" },
            settings = {
                init_options = {
                    formatters = {
                        black = {
                            command = "black",
                            args = { "--quiet", "-" },
                            rootPatterns = {
                                ".git",
                                "pyproject.toml",
                                "setup.py",
                            },
                        },
                        isort = {
                            command = "isort",
                            args = { "-" },
                            rootPatterns = {
                                ".git",
                                "pyproject.toml",
                                "setup.py",
                            },
                        },
                    },
                    linters = {
                        shellcheck = {
                            command = "shellcheck",
                            args = { "-" },
                        },
                    },
                    formatFiletypes = {
                        python = { "black", "isort" },
                    },
                    filetypes = {
                        shell = { "shellcheck" },
                    },
                },
            },
        },
        tools = {},
    }, -- TODO/redundant?: Workaround for binary tooling
    ["eslint"] = {
        server_config = {},
        tools = {},
    }, -- ESLint (multilang)
    ["gopls"] = {
        server_config = {},
        tools = {},
    }, -- Golang
    ["grammarly"] = {
        server_config = {},
        tools = {},
    }, -- Markdown spell checking
    ["jedi_language_server"] = {
        server_config = {},
        tools = { "black", "isort" },
    }, -- Python, NOTE: needs sudo apt install python3-venv
    ["lua_ls"] = {
        server_config = {
            -- cmd = {...},
            -- filetypes = { ...},
            -- capabilities = {},
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                    -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                },
            },
        },
        tools = { "stylua" },
    }, -- Lua
    ["luau_lsp"] = {
        server_config = {},
        tools = {},
    }, -- LuaU
    ["marksman"] = {
        server_config = {},
        tools = {},
    }, -- Markdown
    ["rust_analyzer"] = {
        server_config = {},
        tools = {},
    }, -- Rust
    ["sqlls"] = {
        server_config = {},
        tools = {},
    }, -- SQL
    ["tailwindcss"] = {
        server_config = {},
        tools = {},
    }, -- TailwindCSS
    ["taplo"] = {
        server_config = {},
        tools = {},
    }, -- TOML
    ["terraformls"] = {
        server_config = {},
        tools = {},
    }, -- Terraform
    ["tsserver"] = {
        server_config = {},
        tools = {},
    }, -- TypeScript
    ["yamlls"] = {
        server_config = {},
        tools = {},
    }, -- YAML
}

function to_tool_installer_setup_opts(t)
    out = {}
    for key, value in pairs(t) do
        table.insert(out, key) -- lspconfig name for whatever tool installer picks up for it
        for _, tool_config in pairs(value.tools) do
            table.insert(out, tool_config) -- extra tools user wanted that are associated with the lang
        end
    end
    return out
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Mason is like a plugin manager for LSPs, formaters, linters etc. See :Mason
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- Wait for notifications to be enabled, see: toast.lua
        "j-hui/fidget.nvim",
        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("PuttehiLspAttach", { clear = true }),
            callback = function(event)
                local bufnr = event.buf
                -- Highlight references of symbol under cursor
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = bufnr,
                        callback = function()
                            -- Highlight references
                            vim.lsp.buf.document_highlight()
                            -- Open diagnostic float since virtual text can be tough on narrow screen
                            vim.diagnostic.open_float(nil, {
                                focusable = false,
                                close_events = {
                                    "BufLeave",
                                    "CursorMoved",
                                    "CursorMovedI",
                                    "InsertEnter",
                                    "FocusLost",
                                },
                                border = "rounded",
                                source = "always",
                                prefix = " ",
                                scope = "cursor",
                            })
                        end,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
                -- Attach which-key descriptions to keymaps
                local function with_buf_mapopts(buf, description)
                    local options = { buffer = buf, remap = false }
                    if description ~= nil then
                        for k, v in pairs({ desc = "LSP: " .. description }) do
                            options[k] = v
                        end
                    end
                    return options
                end

                -- "Global" remaps --
                vim.keymap.set(
                    "n",
                    "<F2>",
                    vim.lsp.buf.rename,
                    with_buf_mapopts(bufnr, "Rename symbol under cursor")
                ) -- rename all references under cursor
                vim.keymap.set(
                    "i",
                    "<C-Space>",
                    vim.lsp.buf.signature_help,
                    with_buf_mapopts(bufnr, "Show signature help popup")
                ) -- show signature help (called function signature popup)
                vim.keymap.set(
                    "n",
                    "<C-Space>",
                    vim.lsp.buf.hover,
                    with_buf_mapopts(bufnr, "Show symbol help popup")
                ) -- show hovering information window

                -- Prefixed remaps --
                local prefix = "<leader>l"
                -- Show definition (a --> const a = ...)
                vim.keymap.set(
                    "n",
                    prefix .. "d",
                    vim.lsp.buf.definition,
                    with_buf_mapopts(bufnr, "Show symbol definition")
                )
                -- Show implementations (interface Fooer --> class Foo, class Bar)
                vim.keymap.set(
                    "n",
                    prefix .. "i",
                    vim.lsp.buf.implementation,
                    with_buf_mapopts(bufnr, "Show symbol implementations")
                )
                -- Show references (all occurences of symbol)
                vim.keymap.set(
                    "n",
                    prefix .. "r",
                    vim.lsp.buf.references,
                    with_buf_mapopts(bufnr, "Show symbol references")
                )
                -- Show code actions (Import, reorganize imports, autofix, ...)
                vim.keymap.set(
                    "n",
                    prefix .. "c",
                    vim.lsp.buf.code_action,
                    with_buf_mapopts(bufnr, "Show code actions")
                )
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend(
            "force",
            capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        -- Let's install Mason as the first thing since everything else is a plugin for it
        require("mason").setup()

        -- Let's install and configure the LSPs
        require("mason-lspconfig").setup({
            -- Handlers is like ensure_installed but allows us to modify the input, here we ensure our capabilities are as we set them.
            handlers = {
                function(server_name)
                    local server = languages[server_name].server_config or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    -- (Setup can be used for lspconfig unique keys, or to override lsp.setup_client params such as capabilities)
                    server.capabilities =
                        vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })

        -- Let's install any extras last
        require("mason-tool-installer").setup({
            ensure_installed = to_tool_installer_setup_opts(languages),
        })

        -- NOTE: This must be after setups or will be overridden
        vim.diagnostic.config({
            virtual_text = true, -- Show inline errors
            underline = true, -- Show squiqqlies
            signs = true, -- Show signs in sign column
            severity_sort = true, -- Sort diagnostic list by severity
        })
    end,
}
