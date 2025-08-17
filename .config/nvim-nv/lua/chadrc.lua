local M = {
  base46 = {
    theme = "ayu_dark",
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
  },

  ui = {
    statusline = {
      enabled = true,
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "block",
      order = nil,
      modules = nil,
    },
  },
}

return M
