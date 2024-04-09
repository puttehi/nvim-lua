-- Disable GUI cursor styling
vim.opt.guicursor = ''

-- Show line number column
vim.opt.nu = true
-- Show sign column if there are signs
vim.opt.signcolumn = 'auto'

-- Use 4 spaces for tabs in every occasion
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indent automatically (e.g. after opening a function etc.)
vim.opt.smartindent = true

-- Wrap text instead of overflowing to reduce horizontal scrolling
vim.opt.wrap = true

-- Use swap files to store unsaved buffers (e.g. in case of crashes or :qa!)
vim.opt.swapfile = true

-- See :h backup-table (this is an explicit default)
vim.opt.backup = false
vim.opt.writebackup = true

-- Save undo (<C-U>/<C-R>) history
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Highlight search term
vim.opt.hlsearch = true
-- Ignore search case (/ foo -> [Ff]oo)
vim.opt.ignorecase = true
-- ...but not when a capital letter is present (/ foo -> [Ff]oo, / Foo -> [F]oo)
vim.opt.smartcase = true
-- Show matched pattern in buffer while typing it in search (/)
vim.opt.incsearch = true

-- Enable full color space
vim.opt.termguicolors = true

-- Set window title to titlestring (see :h titlestring)
vim.opt.title = true

-- Show command dimensions (lines x columns)
vim.opt.showcmd = true

-- Always show 4 lines on the top and bottom when moving up/down
vim.opt.scrolloff = 4

-- Allow filenames to have "@" for commands like gf
vim.opt.isfname:append '@-@'

-- Write swap file after this many ms of idling
vim.opt.updatetime = 10

--vim.opt.colorcolumn = "120"

-- Highlight the line background where the cursor currently is
vim.opt.cursorline = true

-- Put new windows below current
vim.opt.splitbelow = true
-- Put new windows right of current
vim.opt.splitright = true

-- The time before a key sequence like g...f should complete
-- NOTE: Affects which-key cheatsheet as well (when does which-key pop up)
vim.opt.timeoutlen = 300
