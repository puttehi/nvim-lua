local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
    'marksman',
    'ansiblels',
    'yamlls',
    'terraformls',
    'gopls'
})

-- (Auto)completion/suggestions settings --
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Tab>'] = cmp.mapping(function(fallback)
        local col = vim.fn.col('.') - 1

        if cmp.visible() then
            cmp.select_next_item(cmp_select)
        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
        else
            cmp.complete()
        end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item(cmp_select)
        else
            fallback()
        end
    end, { 'i', 's' }),
    ['<C-e>'] = cmp.mapping.abort(), -- closes window
    ['<Right>'] = cmp.mapping.abort(), -- closes window
    ['<Left>'] = cmp.mapping.abort(), -- closes window
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- choose selection
    --    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    --    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-K>'] = cmp.mapping.scroll_docs(-4), -- scroll docs up
    ['<C-J>'] = cmp.mapping.scroll_docs(4), -- scroll docs down
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

-- LSP remaps --
lsp.on_attach(function(_, bufnr)
    -- "Global" remaps --
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts(bufnr, "Rename symbol under cursor")) -- rename all references under cursor
    vim.keymap.set("i", "<C-Space>", vim.lsp.buf.signature_help, opts(bufnr, "Show signature help popup")) -- show signature help (called function signature popup)
    vim.keymap.set("n", "<C-Space>", vim.lsp.buf.hover, opts(bufnr, "Show symbol help popup")) -- show hovering information window

    -- Prefixed remaps --
    local prefix = "<leader>l"
    vim.keymap.set("n", prefix .. "d", vim.lsp.buf.definition, opts(bufnr, "Show symbol definitions")) -- show definitions
    vim.keymap.set("n", prefix .. "i", vim.lsp.buf.implementation, opts(bufnr, "Show symbol implementations")) -- show implementations
    vim.keymap.set("n", prefix .. "r", vim.lsp.buf.references, opts(bufnr, "Show symbol references")) -- show references
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
lsp.nvim_workspace()

-- Bash
lsp.configure('bashls', {})


lsp.setup()

-- must be after lsp.setup or hidden
vim.diagnostic.config({
    virtual_text = true,
})
