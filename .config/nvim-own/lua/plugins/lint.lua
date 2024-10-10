return {
  "mfussenegger/nvim-lint",
  event = "User FilePost",
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "eslint" },
      markdown = { "vale" },
    }
  end,
}
