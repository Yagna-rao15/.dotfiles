require "config.keymaps"
require "config.options"

vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.loaded_python3_provider = nil

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
require "config.lazy"

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "syntax")

if require("nvconfig").ui.statusline.enabled then
  vim.o.statusline = "%!v:lua.require('config." .. require("nvconfig").ui.statusline.theme .. "')()"
end

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.g.netrw_banner = 0
vim.opt.wrap = false

vim.keymap.set("v", "<leader>r", function()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then
    return
  end

  local start_pos = vim.fn.getpos("'<")[2]
  local end_pos = vim.fn.getpos("'>")[2]
  local lines = vim.api.nvim_buf_get_lines(0, start_pos - 1, end_pos, false)
  local code = table.concat(lines, "\n")

  require("molten.api").evaluate_code(code)
end, { desc = "Molten evaluate selected block" })
