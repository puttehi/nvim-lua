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

-- Python
require 'lspconfig'.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                mypy = {
                    enabled = true
                },
                pylint = {
                    enabled = true
                },
                flake8 = {
                    enabled = true
                },
                black = {
                    enabled = true
                },
                isort = {
                    enabled = true,
                    profile = "black"
                }
            }
        }
    }
}


-- Lua settings --
-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


-- (Auto)completion/suggestions settings --
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.complete(), -- opens window
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

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
