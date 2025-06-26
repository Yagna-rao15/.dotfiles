require "keymaps"
require "options"
require "autocmds"
require("game").setup()

Nvchad = true
if Nvchad then
  vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
end

require "config.lazy"

if Nvchad then
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
  dofile(vim.g.base46_cache .. "syntax")

  if require("nvconfig").ui.statusline.enabled then
    vim.o.statusline = "%!v:lua.require('config." .. require("nvconfig").ui.statusline.theme .. "')()"
  end
end
