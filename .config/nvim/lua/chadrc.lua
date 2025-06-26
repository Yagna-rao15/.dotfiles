-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {
  base46 = {
    theme = "ayu_dark", -- or whatever theme you prefer
    hl_add = {},
    hl_override = {
      ZenBg = {
        bg = "NONE", -- remove grey background
      },
      Comment = { italic = true },
      ["@comment"] = { italic = true },
    },
    integrations = {},
    changed_themes = {},
    theme_toggle = { "onedark", "one_light" },
  },
}

return M
