local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    -- lsp
    'ansiblels',
    'bashls',
    'diagnosticls',
    'eslint',
    --'gopls', -- fails on latest go
    'grammarly',
    'jedi_language_server', -- needs python3-venv
    'luau_lsp',
    'marksman',
    'rust_analyzer',
    'sqlls',
    --'sumneko_lua', -- invalid entry?
    'taplo',
    'terraformls',
    'tsserver',
    'yamlls',
})

-- (Auto)completion/suggestions settings --
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local luasnip = require("luasnip")
luasnip.config.setup()

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Tab>'] = cmp.mapping(function(fallback)
        local col = vim.fn.col('.') - 1

        if cmp.visible() then
            cmp.select_next_item(cmp_select)
        elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump() -- jump luasnip locations
        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
        else
            cmp.complete()
        end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item(cmp_select)
        elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1) -- jump luasnip locations backwards
        else
            fallback()
        end
    end, { 'i', 's' }),
    ['<C-e>'] = cmp.mapping.abort(),                   -- closes window
    ['<Right>'] = cmp.mapping.abort(),                 -- closes window
    ['<Left>'] = cmp.mapping.abort(),                  -- closes window
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- choose selection
    --    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    --    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-K>'] = cmp.mapping.scroll_docs(-4), -- scroll docs up
    ['<C-J>'] = cmp.mapping.scroll_docs(4),  -- scroll docs down
    ['<C-h'] = nil
})
lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    set_lsp_keymaps = false, -- we bake our own
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

-- Attach which-key descriptions to keymaps
local function opts(bufnr, description)
    local options = { buffer = bufnr, remap = false }
    if description ~= nil then
        for k, v in pairs({ desc = description }) do options[k] = v end
    end
    return options
end

lsp.on_attach(function(_, bufnr)
    -- Show diagnostic hover on cursor over
    -- as virtual text is tough on small window
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local diagnostic_opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, diagnostic_opts)
        end
    })

    -- "Global" remaps --
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts(bufnr, "Rename symbol under cursor"))             -- rename all references under cursor
    vim.keymap.set("i", "<C-Space>", vim.lsp.buf.signature_help, opts(bufnr, "Show signature help popup")) -- show signature help (called function signature popup)
    vim.keymap.set("n", "<C-Space>", vim.lsp.buf.hover, opts(bufnr, "Show symbol help popup"))             -- show hovering information window

    -- Prefixed remaps --
    local prefix = "<leader>l"
    vim.keymap.set("n", prefix .. "d", vim.lsp.buf.definition, opts(bufnr, "Show symbol definitions"))         -- show definitions
    vim.keymap.set("n", prefix .. "i", vim.lsp.buf.implementation, opts(bufnr, "Show symbol implementations")) -- show implementations
    vim.keymap.set("n", prefix .. "r", vim.lsp.buf.references, opts(bufnr, "Show symbol references"))          -- show references
    vim.keymap.set("n", prefix .. "c", vim.lsp.buf.code_action, opts(bufnr, "Show code actions"))
end)

-- Python
--lspconfig.jedi_language_server.setup {}
lsp.configure('diagnosticls', {
    cmd = { "diagnostic-languageserver", "--stdio" },
    --args = { "--log-level", "5" },
    filetypes = { "python", "shell" },
    init_options = {
        formatters = {
            black = {
                command = "black",
                args = { '--quiet', '-' },
                rootPatterns = {
                    '.git',
                    'pyproject.toml',
                    'setup.py',
                },
            },
            isort = {
                command = "isort",
                args = { '-' },
                rootPatterns = {
                    '.git',
                    'pyproject.toml',
                    'setup.py',
                },
            }
        },
        linters = {
            shellcheck = {
                command = "shellcheck",
                args = { '-' },
            }
        },
        formatFiletypes = {
            python = { "black", "isort" },
        },
        filetypes = {
            shell = { "shellcheck" }
        }
    }
})

-- Lua
-- (Optional) Configure lua language server for neovim
-- lsp.nvim_workspace()
-- Folkes neodev, supposed to be before lspconfig setup.
require("neodev").setup({
    library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options) end,
    -- With lspconfig, Neodev will automatically setup your lua-language-server
    -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
    -- in your lsp start options
    lspconfig = true,
    -- much faster, but needs a recent built of lua-language-server
    -- needs lua-language-server >= 3.6.0
    pathStrict = true,
})

-- Bash
lsp.configure('bashls', {})


lsp.setup()

-- must be after lsp.setup or hidden
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = true,
    severity_sort = true
})
