-- trunc: https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
        end
        return str
    end
end

local function get_winnr()
    return vim.api.nvim_win_get_number(0)
end

local file_symbols = {
    modified = "-> unsaved!", -- Text to show when the file is modified.
    readonly = "[read only]", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "<no filename>", -- Text to show for unnamed buffers.
    newfile = " (new)", -- Text to show for new created file before first writting
}

opts = {
    options = {
        icons_enabled = true,
        theme = "auto", -- supplied by theme
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false, -- one line per nvim or one line per nvim window
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = {
            { "mode", fmt = trunc(80, 1, nil, true) },
        },
        lualine_b = {
            "branch",
            "diff",
        },
        lualine_c = {
            {
                "diagnostics",
                sources = {
                    "nvim_lsp",
                },
            },
            {
                "filename",
                file_status = true, -- Displays file status (readonly status, modified status)
                newfile_status = true, -- Display new file status (new file means no write after created)
                path = 3, -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory

                shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                -- for other components. (terrible name, any suggestions?)
                symbols = file_symbols,
            },
            "searchcount",
        },
        lualine_x = {},
        lualine_y = { "filetype" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = { get_winnr },
        lualine_b = {
            {
                "diagnostics",
                sources = {
                    "nvim_lsp",
                },
            },
        },
        lualine_c = {
            {
                "filename",
                file_status = true, -- Displays file status (readonly status, modified status)
                newfile_status = true, -- Display new file status (new file means no write after created)
                path = 3, -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory

                shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                -- for other components. (terrible name, any suggestions?)
                symbols = file_symbols,
            },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = { "windows" },
        lualine_y = { "buffers" },
        lualine_z = { "tabs" },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}

return {
    "nvim-lualine/lualine.nvim",
    opts = opts,
    config = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "puttehi/nvim-puttehi-dark", -- Includes theme. See colorscheme.lua
    },
}
