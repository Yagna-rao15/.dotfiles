return {
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    opts = {},
    config = function(_, opts)
      require "config.lsp"
    end,
  },
}
