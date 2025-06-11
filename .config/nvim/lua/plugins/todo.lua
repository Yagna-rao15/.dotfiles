return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    signs = false,
    highlight = {
      keyword = "bg",
      after = "fg",
    },
    keywords = {
      FIX = {
        icon = " ",
        color = "#FF5C57",
        alt = { "FIXME", "BUG", "ISSUE" },
      },
      TODO = {
        icon = " ",
        color = "#38BDF8",
      },
      HACK = {
        icon = " ",
        color = "#FBBF24",
      },
      WARN = {
        icon = " ",
        color = "#F97316",
        alt = { "WARNING", "XXX", "IMP" },
      },
      PERF = {
        icon = " ",
        color = "#22C55E",
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },
      NOTE = {
        icon = " ",
        color = "#38BDF8",
        alt = { "INFO" },
      },
      TEST = {
        icon = " ",
        color = "#C084FC",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },
    merge_keywords = true,
  },
}

-- FIX:
-- TODO:
-- HACK:
-- WARN:
-- PERF:
-- NOTE:
-- TEST:
