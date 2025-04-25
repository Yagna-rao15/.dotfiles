return {
  "nvim-lua/plenary.nvim",
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  -- {
  --   "nvchad/ui",
  --   config = function()
  --     require "nvchad"
  --   end,
  -- },
  -- "nvchad/volt",
}
