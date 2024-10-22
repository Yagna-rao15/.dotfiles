require "core.keymaps"
require "core.options"

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
require "config.lazy"

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "syntax")

-- if require("nvconfig").ui.statusline.enabled then
--   vim.o.statusline = "%!v:lua.require('config." .. require("nvconfig").ui.statusline.theme .. "')()"
-- end

-- vim.cmd "colorscheme ayudark"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
