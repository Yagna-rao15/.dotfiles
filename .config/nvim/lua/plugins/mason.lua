return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  opts = {
    ensure_installed = {
      -- LSP
      "lua-language-server",
      "typescript-language-server",
      "clangd",
      "pyright",
      "tailwindcss-language-server",
      "stylua",
      "dockerfile-language-server",
      "docker-compose-language-service",
      "cmakelang",
      "luacheck",

      -- Go
      "gopls",
      "goimports",
      "gofumpt",
      "gomodifytags",
      "impl",

      -- Markdown
      "markdownlint-cli2",
      "markdown-toc",

      -- Linters
      "eslint_d",
      "cmakelint",
      -- "ruff",
      -- "autopep8",
      -- "mypy",
      -- "flake8",
      "blake",
      "htmlhint",
      "stylelint",
      "shellcheck",
      "hadolint",
      "sqlfluff",
    },

    PATH = "skip",

    ui = {
      border = "none",
      icons = {
        package_pending = " ",
        package_installed = "󰄳 ",
        package_uninstalled = " 󰚌",
      },

      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
    },

    max_concurrent_installers = 10,
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
    if Nvchad then
      dofile(vim.g.base46_cache .. "mason")
    end
    require("mason").setup(opts)

    -- custom nvchad cmd to install all mason binaries listed
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end,
}

-- This is list of Mason:
-- 󰄳  autopep8
-- 󰄳  black
-- 󰄳  blackd-client
-- 󰄳  clangd
-- 󰄳  cmakelang
-- 󰄳  cmakelint
-- 󰄳  codelldb
-- 󰄳  docker-compose-language-service
-- 󰄳  dockerfile-language-server
-- 󰄳  eslint-lsp
-- 󰄳  eslint_d
-- 󰄳  flake8
-- 󰄳  gofumpt
-- 󰄳  goimports
-- 󰄳  golangci-lint
-- 󰄳  gomodifytags
-- 󰄳  gopls
-- 󰄳  hadolint
-- 󰄳  htmlhint
-- 󰄳  impl
-- 󰄳  lua-language-server
-- 󰄳  markdown-toc
-- 󰄳  markdownlint-cli2
-- 󰄳  mypy
-- 󰄳  pyright
-- 󰄳  ruff
-- 󰄳  shellcheck
-- 󰄳  sqlfluff
-- 󰄳  stylelint
-- 󰄳  stylua
-- 󰄳  tailwindcss-language-server
-- 󰄳  typescript-language-server
