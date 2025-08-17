return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      -- lua = { "luacheck" },
      -- python = { "flake8", "ruff", "mypy" },
      javascript = { "eslint_d" },
      cmake = { "cmakelint" },
      typescript = { "eslint_d" },
      go = { "gomodifytags", "impl" },
      html = { "htmlhint" },
      css = { "stylelint" },
      sh = { "shellcheck" },
      fish = { "fish" },
      dockerfile = { "hadolint" },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ["*"] = { "typos" },
      -- Use the "_" filetype to run linters on filetypes without specific linters configured.
      -- ["_"] = { "generic-linter" },
    },
  },
  config = function(_, opts)
    local M = {}
    sql_ft = sql_ft or {}
    for _, ft in ipairs(sql_ft) do
      opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
      table.insert(opts.linters_by_ft[ft], "sqlfluff")
    end

    local lint = require "lint"
    lint.linters_by_ft = opts.linters_by_ft

    -- Debounce function to avoid redundant linting.
    function M.debounce(ms, fn)
      local timer = vim.loop.new_timer()
      return function(...)
        local args = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(args))
        end)
      end
    end

    -- Custom linting logic.
    function M.lint()
      local filetype = vim.bo.filetype
      local ctx = {
        filename = vim.api.nvim_buf_get_name(0),
        dirname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h"),
      }

      -- Resolve linters based on filetype.
      local linters = vim.list_extend({}, lint.linters_by_ft[filetype] or {})

      -- Add fallback linters.
      if #linters == 0 then
        linters = vim.list_extend(linters, lint.linters_by_ft["_"] or {})
      end

      -- Add global linters.
      linters = vim.list_extend(linters, lint.linters_by_ft["*"] or {})

      -- Filter valid linters based on conditions.
      linters = vim.tbl_filter(function(linter_name)
        local linter = lint.linters[linter_name]
        if not linter then
          vim.notify("Linter not found: " .. linter_name, vim.log.levels.WARN)
          return false
        end
        return not (linter.condition and not linter.condition(ctx))
      end, linters)

      -- Run the linters.
      if #linters > 0 then
        lint.try_lint(linters)
      end
    end

    -- Set up autocmd for linting events.
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })
  end,
}
