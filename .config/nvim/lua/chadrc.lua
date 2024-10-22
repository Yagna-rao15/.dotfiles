-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {
  base46 = {
    theme = "ayu_dark", -- or whatever theme you prefer
    hl_add = {},
    hl_override = {
      -- -- Override or add the specific highlight groups here
      -- luaTSField = { fg = "#F07174" }, -- example override
      -- ["@tag.delimiter"] = { fg = "#95E6CB" },
      -- ["@function"] = { fg = "#FFA455" },
      -- ["@variable.parameter"] = { fg = "#CBA6F7" },
      -- ["@constructor"] = { fg = "#56c3f9" },
      -- ["@tag.attribute"] = { fg = "#FFA455" },

      Comment = { italic = true },
      ["@comment"] = { italic = true },
    },
    integrations = {},
    changed_themes = {},
    theme_toggle = { "onedark", "one_light" },
  },
}

return M
