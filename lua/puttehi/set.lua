vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.title = true
vim.opt.showcmd = true
vim.opt.smartcase = true -- Do not ignore case with capitals

vim.opt.scrolloff = 4
vim.opt.signcolumn = "auto"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 10

--vim.opt.colorcolumn = "120"
vim.opt.cursorline = true

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current

vim.opt.timeoutlen = 300 -- The time before a key sequence should complete, affects which-key as well
