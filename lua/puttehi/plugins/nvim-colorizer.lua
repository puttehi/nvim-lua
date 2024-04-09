--[[
Colorizer highlights common color codings
]]

-- Plugin defaults: https://github.com/norcalli/nvim-colorizer.lua/blob/36c610a9717cc9ec426a07c8e6bf3b3abcb139d6/lua/colorizer.lua#L57
--[[
local DEFAULT_OPTIONS = {
	RGB      = true;         -- #RGB hex codes
	RRGGBB   = true;         -- #RRGGBB hex codes
	names    = true;         -- "Name" codes like Blue
	RRGGBBAA = false;        -- #RRGGBBAA hex codes
	rgb_fn   = false;        -- CSS rgb() and rgba() functions
	hsl_fn   = false;        -- CSS hsl() and hsla() functions
	css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode     = 'background'; -- Set the display mode.
}
]]

return {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function(_, _)
        require("colorizer").setup()
        -- TODO: For some reason lazy won't enable it like on packer so lets force attach
        vim.api.nvim_create_autocmd("BufEnter", {
            desc = "Enable nvim-colorizer when entering a buffer for the first time",
            group = vim.api.nvim_create_augroup("PuttehiNvimColorizerHack", { clear = true }),
            callback = function(event_args)
                require("colorizer").attach_to_buffer(event_args.buf)
            end,
        })
    end,
}
