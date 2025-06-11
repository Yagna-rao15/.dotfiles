return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    vim.diagnostic.config {
      float = { border = "rounded" },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Capabilities of nvim cmp
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
    end

    -- Optional: Blink (or other cmp) integration
    -- local has_blink, blink = pcall(require, "blink.cmp")
    -- if has_blink then
    --   capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
    -- end

    -- Add completion and workspace capabilities
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }
    capabilities.workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    }

    ---@diagnostic disable-next-line: unused-local
    local on_attach = function(client, bufnr)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
      map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "gr", vim.lsp.buf.references, "Find References")
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
      end, "Format Buffer")
      -- map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
      -- map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
      map("n", "<leader>e", vim.diagnostic.open_float, "Line Diagnostic")
      map("n", "<leader>q", vim.diagnostic.setloclist, "Quickfix Diagnostics")
    end

    require("mason").setup()

    require("mason-lspconfig").setup {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
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
      },
      handlers = {
        function(server)
          require("lspconfig")[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                  },
                },
                telemetry = { enable = false },
              },
            },
          }
        end,

        ["ts_ls"] = function()
          require("lspconfig").tsserver.setup {
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
        end,

        ["clangd"] = function()
          require("lspconfig").clangd.setup {
            capabilities = vim.tbl_deep_extend("force", capabilities, {
              offsetEncoding = { "utf-16" },
            }),
            on_attach = on_attach,
          }
        end,

        ["gopls"] = function()
          require("lspconfig").gopls.setup {
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
      },
    }
  end,
}
