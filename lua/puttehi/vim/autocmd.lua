--[[
Show relative numbers in active window, show normal line numbers in inactive windows
]]
local window_event_augroup = vim.api.nvim_create_augroup('PuttehiWindowEvents', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  group = window_event_augroup,
  callback = function()
    vim.opt.rnu = true
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  group = window_event_augroup,
  callback = function()
    vim.opt.rnu = false
  end,
})

--[[
Highlight yanks momentarily to show what was selected
]]
local yank_augroup = vim.api.nvim_create_augroup('PuttehiHighlightYank', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_augroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

--[[
Remove trailing whitespace on write (:w)
]]
local trailing_ws_augroup = vim.api.nvim_create_augroup('PuttehiTrailingWhitespace', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = trailing_ws_augroup,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
