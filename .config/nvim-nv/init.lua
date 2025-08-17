require "keymaps"
require "options"
require "autocmds"

Nvchad = false
if Nvchad then
  vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
end

require "config.lazy"

if Nvchad then
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
  dofile(vim.g.base46_cache .. "syntax")

  if require("chadrc").ui.statusline.enabled then
    vim.o.statusline = "%!v:lua.require('config." .. require("chadrc").ui.statusline.theme .. "')()"
  end
end

-- TODO: Statusline customize and theme modifications
