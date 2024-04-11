local ts_opts = {
    -- A list of parser names, or "all"
    ensure_installed = { "lua", "luadoc", "bash", "vim", "vimdoc", "markdown", "go", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true, -- NOTE: I generally don't have the CLI and like to live dangerously

    --[[ -- TODO/Deprecated: nvim-ts-rainbow TS module
    rainbow = {
        enable = false,
        extended_mode = false,
    }, ]]

    -- We need highlights for powerful color scheme
    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
        -- additional_vim_regex_highlighting = { "ruby" },
    },
    indent = {
        enable = true,
        disable = { "ruby" },
    },
}

local ts_context_opts = {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
            "interface",
            "struct",
            "enum",
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        tex = {
            "chapter",
            "section",
            "subsection",
            "subsubsection",
        },
        haskell = {
            "adt",
        },
        rust = {
            "impl_item",
        },
        terraform = {
            "block",
            "object_elem",
            "attribute",
        },
        scala = {
            "object_definition",
        },
        vhdl = {
            "process_statement",
            "architecture_body",
            "entity_declaration",
        },
        markdown = {
            "section",
        },
        elixir = {
            "anonymous_function",
            "arguments",
            "block",
            "do_block",
            "list",
            "map",
            "tuple",
            "quoted_content",
        },
        json = {
            "pair",
        },
        typescript = {
            "export_statement",
        },
        yaml = {
            "block_mapping_pair",
        },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
}

---@type LazyPlugin[]
return {
    -- Main TS
    ---@diagnostic disable-next-line: missing-fields
    {
        "nvim-treesitter/nvim-treesitter",
        -- Whenever updating treesitter (so, also building it), update queries
        build = ":TSUpdate",
        opts = ts_opts,
        -- See `:help nvim-treesitter`
        config = function(_, opts)
            --[[
	        -- DEBUG: Force older go parser (fd577c4358c28cbcb6748bbf65354cc85f1cf7a4)
            -- Even though the revision key is not in the parser configs, it seems to be used downstream and allows overriding,
            -- See: cat /home/puttehi/.local/share/nvim/lazy/nvim-treesitter/parser-info/<lang>.revision
            local go_version = "5c0024cfbb10f0a6b54ed4b14dc5acadacd19b61"
            require("nvim-treesitter.parsers").get_parser_configs()["go"].install_info.revision = go_version
	        ]]
            require("nvim-treesitter.configs").setup(opts)
            vim.opt.runtimepath:append(
                "/home/puttehi/.local/share/nvim/lazy/nvim-treesitter/parsers"
            )
        end,
    },
    -- Show context of the block(s) the cursor is in, even when they are off screen
    ---@diagnostic disable-next-line: missing-fields
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = true,
        opts = ts_context_opts,
        config = true, -- Run require(...).setup(opts) TODO/check: treesitter-context.setup, not nvim-treesitter-context
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    -- Automatically add closing tags for HTML and JSX
    ---@diagnostic disable-next-line: missing-fields
    {
        "windwp/nvim-ts-autotag",
        opts = {
            enable = true,
            enable_rename = true,
            enable_close = true,
            enable_close_on_slash = true,
            filetypes = { "html", "xml" },
        },
        config = true,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
}
