return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "User FilePost",
    config = function()
      require("mini.ai").setup { n_lines = 500 }
      require("mini.surround").setup()
      require("mini.pairs").setup {
        opts = {
          modes = { insert = true, command = true, terminal = false },
          skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
          skip_ts = { "string" },
          skip_unbalanced = true,
          markdown = true,
        }
      }
   end,
  },
}
