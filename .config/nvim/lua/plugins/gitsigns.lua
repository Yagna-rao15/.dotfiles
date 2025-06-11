return {
  "lewis6991/gitsigns.nvim",
  event = "User FilePost",
  opts = function()
    return {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
      signs_staged = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
    }
  end,
  config = function(_, opts)
    if Nvchad then
      dofile(vim.g.base46_cache .. "git")
    end
    require("gitsigns").setup(opts)
  end,
}
