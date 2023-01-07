-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- All formatter configurations are opt-in
  filetype = {
     -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

--vim.keymap.set('n','<leader>f', ':Format<CR>')
--vim.keymap.set('n','<leader>F', ':FormatWrite<CR>')
