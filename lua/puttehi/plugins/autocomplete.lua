return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
        "saadparwaiz1/cmp_luasnip", -- Loaded to LuaSnip, not to sources (comes from luasnip source)

        -- LSP completions
        "hrsh7th/cmp-nvim-lsp",
        -- Filepaths when doing ~/, ./ etc..
        "hrsh7th/cmp-path",
        -- Words in the buffer (previous occurrences)
        "hrsh7th/cmp-buffer",
        -- NVIM Lua API
        "hrsh7th/cmp-nvim-lua",
    },
    config = function()
        -- See `:help cmp`
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },

            --[[ KICKSTART DEFAULTS
            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            }),]]
            mapping = cmp.mapping.preset.insert({
                --[[-- Tab will run the completion or jump ahead in a completion of a snippet
                -- Shift+Tab vice versa
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local col = vim.fn.col(".") - 1

                    --if cmp.visible() then
                    --    cmp.select_next_item(cmp_select)
                    if cmp.visible() then
                        -- Menu open -> Select
                        cmp.confirm({ select = true })
                    elseif luasnip.expand_or_locally_jumpable(1) then
                        -- In luasnip -> Jump to next location
                        luasnip.expand_or_jump() -- jump luasnip locations
                    --elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                    --    -- Not in menu or in end of luasnip and cursor col not empty -> done!
                    --    cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    --if cmp.visible() then
                    --    cmp.select_prev_item(cmp_select)
                    --else
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1) -- jump luasnip locations backwards
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ]]
                -- "Super-Tab"
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({
                                select = true,
                            })
                        end
                    else
                        fallback()
                    end
                end),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- Window closers, C-e during typing, Right and Left added since I commonly use them to move in insert mode
                ["<C-e>"] = cmp.mapping.abort(),
                ["<Right>"] = cmp.mapping.abort(),
                ["<Left>"] = cmp.mapping.abort(),
                -- Enter selects the current cmp
                --["<CR>"] = cmp.mapping.confirm({ select = true }),
                --    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                --    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                -- Arrows scroll the cmp menu
                ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
                -- CTRL k/j scrolls the cmp docs
                ["<C-k>"] = cmp.mapping.scroll_docs(-4), -- scroll docs up
                ["<C-j>"] = cmp.mapping.scroll_docs(4), -- scroll docs down
                -- TODO: Why was this keymap disable here again?
                ["<C-h>"] = nil,
            }),

            sources = {
                { name = "nvim_lsp" }, -- hrsh7th/cmp-nvim-lsp
                { name = "luasnip" }, -- L3m0N4D3/LuaSnip engine and whatever was set up in it, either directly or loaded from other plugins
                { name = "path" }, -- hrsh7th/cmp-path
                { name = "buffer" }, -- hrsh7th/cmp-buffer
                { name = "nvim_lua" }, -- hrsh7th/cmp-nvim-lua
            },
        })
    end,
}
