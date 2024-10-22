vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
local cmp = require "cmp"
local defaults = require "cmp.config.default"()
local auto_select = true
return {
  auto_brackets = {},
  completion = {
    completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
  },
  preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert {
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
  -- experimental = {
  --   ghost_text = {
  --     hl_group = "CmpGhostText",
  --   },
  -- },
  sorting = defaults.sorting,
}
