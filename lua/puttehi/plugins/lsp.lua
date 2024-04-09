-- LSP Configuration & Plugins
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
                local function with_buf_mapopts(bufnr, description)
                    local options = { buffer = bufnr, remap = false }
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

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
            --
            -- Some languages (like typescript) have entire language plugins that can be useful:
            --    https://github.com/pmizio/typescript-tools.nvim
            --
            -- But for many setups, the LSP (`tsserver`) will work just fine
            -- tsserver = {},
            --

            lua_ls = {
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
            -- Diagnostic LSP is a workaround to get CLI tools without nvim integrations to work nicely
            diagnosticls = {
                cmd = { "diagnostic-languageserver", "--stdio" },
                --args = { "--log-level", "5" },
                filetypes = { "python", "shell" },
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
        }

        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "ansiblels",
            "bashls",
            "diagnosticls",
            "eslint",
            --'gopls', -- fails on latest go
            "grammarly",
            "jedi_language_server", -- needs python3-venv
            "luau_lsp",
            "marksman",
            "rust_analyzer",
            "sqlls",
            "stylua", -- Used to format Lua code
            --'sumneko_lua', -- invalid entry?
            "taplo",
            "terraformls",
            "tsserver",
            "yamlls",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities =
                        vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })

        -- must be after lsp.setup or it wont work (hidden)
        -- TODO: Right place with default LSP with lazy?
        vim.diagnostic.config({
            virtual_text = true,
            underline = true,
            signs = true,
            severity_sort = true,
        })
    end,
}
