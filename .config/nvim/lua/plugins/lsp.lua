return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  config = function()
    -- 🔧 Configure lua_ls globals before LSP setup
    if vim.g.loaded_lsp_config == nil then
      vim.g.loaded_lsp_config = true
      -- Ensure vim is recognized as a global
      vim.cmd [[
        autocmd FileType lua setlocal iskeyword+=.
      ]]
    end

    -- ✨ Diagnostic UI config
    vim.diagnostic.config {
      virtual_text = {
        prefix = "●", -- or "" to disable
        spacing = 2,
      },
      float = false, -- disable floating windows
      signs = true,
      underline = true,
    }

    -- 🔁 Diagnostic navigation helpers
    local diagnostic_goto = function(next, severity)
      local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
      return function()
        go { severity = severity and vim.diagnostic.severity[severity] or nil }
      end
    end

    -- 🌐 LSP capabilities (with nvim-cmp support)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
      },
    }

    capabilities.workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    }

    -- 🔧 Common on_attach function
    local on_attach = function(_, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- LSP keymaps
      map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
      map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "gr", vim.lsp.buf.references, "Find References")
      map("n", "K", vim.lsp.buf.hover, "Hover Docs")
      map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
      end, "Format")

      -- Diagnostics
      map("n", "<leader>d", vim.diagnostic.open_float, "Show Diagnostic")
      map("n", "]d", diagnostic_goto(true), "Next Diagnostic")
      map("n", "[d", diagnostic_goto(false), "Prev Diagnostic")
      map("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
      map("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
      map("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
      map("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")
      map("n", "<leader>q", vim.diagnostic.setloclist, "Quickfix List")
    end

    -- 🔧 Setup mason
    require("mason").setup()

    -- Setup mason-lspconfig with automatic installation
    require("mason-lspconfig").setup {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "clangd",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
        "gopls",
        "html",
        "marksman",
        "tailwindcss",
        "stylelint_lsp",
        "ts_ls", -- Updated from tsserver
      },
      automatic_installation = true,
    }

    -- Manual LSP setup to ensure our settings are applied
    local lspconfig = require "lspconfig"

    -- Setup lua_ls with proper configuration
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = {
              "vim",
              "use",
              "describe",
              "it",
              "before_each",
              "after_each",
              "packer_plugins",
              "MiniTest",
              "jit",
              "bit",
            },
            disable = { "lowercase-global", "undefined-global" },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
          format = { enable = false },
          hint = { enable = true },
        },
      },
    }

    -- Setup other LSPs manually
    local servers = {
      "pyright",
      "dockerls",
      "docker_compose_language_service",
      "eslint",
      "html",
      "marksman",
      "tailwindcss",
      "stylelint_lsp",
    }

    -- Setup basic servers
    for _, server in ipairs(servers) do
      lspconfig[server].setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end

    -- TypeScript/JavaScript LSP (updated to ts_ls)
    lspconfig.ts_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      commands = {
        OrganizeImports = {
          function()
            vim.lsp.buf.code_action {
              context = {
                only = { "source.organizeImports" },
                diagnostics = {},
              },
            }
          end,
          description = "Organize Imports",
        },
      },
    }

    -- C/C++
    lspconfig.clangd.setup {
      capabilities = vim.tbl_deep_extend("force", capabilities, {
        offsetEncoding = { "utf-16" },
      }),
      on_attach = on_attach,
    }

    -- Go
    lspconfig.gopls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          gofumpt = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
        },
      },
    }
  end,
}
