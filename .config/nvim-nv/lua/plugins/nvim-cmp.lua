local M = require "config.cmp"

return {
  {
    "hrsh7th/nvim-cmp",
    branch = "main",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "roobert/tailwindcss-colorizer-cmp.nvim",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-cmdline",
    },

    config = function()
      local cmp = require "cmp"
      local has_luasnip, luasnip = pcall(require, "luasnip")
      local lspkind = require "lspkind"
      local colorizer = require("tailwindcss-colorizer-cmp").formatter

      -- Load NvChad theme if available
      if vim.g.base46_cache then
        dofile(vim.g.base46_cache .. "cmp")
      end

      cmp.setup {
        enabled = function()
          local disabled = false
          disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
          disabled = disabled or (vim.fn.reg_recording() ~= "")
          disabled = disabled or (vim.fn.reg_executing() ~= "")
          disabled = disabled or require("cmp.config.context").in_treesitter_capture "comment"
          return not disabled
        end,
        experimental = {
          ghost_text = false,
        },

        completion = {
          completeopt = "menu,menuone,noinsert",
        },

        window = {
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          },
          completion = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
          },
        },

        snippet = {
          expand = function(args)
            if has_luasnip then
              luasnip.lsp_expand(args.body)
            end
          end,
        },

        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          -- { name = "nvim_lsp_document_symbol" },
          -- { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "lazydev" },
          { name = "buffer" },
          { name = "path" },
          { name = "calc" },
          { name = "tailwindcss-colorizer-cmp" },
          { name = "cmdline" },
        },

        formatting = {
          format = function(entry, vim_item)
            -- Add custom LSP kind icons
            vim_item.kind = string.format("%s %s", M.lsp_kinds[vim_item.kind] or "", vim_item.kind)

            -- Add menu tags
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
              path = "[Path]",
              ["tailwindcss-colorizer-cmp"] = "[TW]",
            })[entry.source.name]

            -- Apply lspkind formatting
            vim_item = lspkind.cmp_format {
              maxwidth = 25,
              ellipsis_char = "...",
            }(entry, vim_item)

            -- Apply colorizer for LSP entries
            if entry.source.name == "nvim_lsp" then
              vim_item = colorizer(entry, vim_item)
            end

            return vim_item
          end,
        },

        mapping = cmp.mapping.preset.insert {
          -- Backspace handling
          ["<BS>"] = cmp.mapping(function()
            M.smart_input.smart_bs()
          end, { "i", "s" }),

          -- Close completion
          ["<C-e>"] = cmp.mapping.abort(),

          -- Close documentation
          ["<C-d>"] = cmp.mapping(function()
            cmp.close_docs()
          end, { "i", "s" }),

          -- Scroll documentation
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),

          -- Navigation
          ["<C-j>"] = cmp.mapping(M.cmp_helpers.select_next_item),
          ["<C-k>"] = cmp.mapping(M.cmp_helpers.select_prev_item),
          ["<C-n>"] = cmp.mapping(M.cmp_helpers.select_next_item),
          ["<C-p>"] = cmp.mapping(M.cmp_helpers.select_prev_item),
          ["<Down>"] = cmp.mapping(M.cmp_helpers.select_next_item),
          ["<Up>"] = cmp.mapping(M.cmp_helpers.select_prev_item),

          -- Confirm selection
          ["<C-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              M.cmp_helpers.confirm(entry)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              M.cmp_helpers.confirm(entry)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Shift-Tab handling
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif has_luasnip and M.conditions.in_snippet() and luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif M.conditions.in_leading_indent() then
              M.smart_input.smart_bs(true)
            elseif M.conditions.in_whitespace() then
              M.smart_input.smart_bs()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Tab handling
          ["<Tab>"] = cmp.mapping(function(_)
            if cmp.visible() then
              local entries = cmp.get_entries()
              if #entries == 1 then
                M.cmp_helpers.confirm(entries[1])
              else
                cmp.select_next_item()
              end
            elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif M.conditions.in_whitespace() then
              M.smart_input.smart_tab()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
        },
      }

      -- Setup ghost text functionality
      M.setup_ghost_text()
    end,
  },

  -- LuaSnip configuration
  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    build = "make install_jsregexp",
    opts = {
      enable_autosnippets = true,
      region_check_events = "InsertEnter",
      delete_check_events = "InsertLeave",
      history = true,
      updateevents = "TextChanged,TextChangedI",
    },
    config = function(_, opts)
      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/snippets/" }
      local luasnip = require "luasnip"
      luasnip.config.set_config(opts)
      vim.keymap.set({ "i" }, "<C-e>", function()
        luasnip.expand()
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-J>", function()
        luasnip.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-K>", function()
        luasnip.jump(-1)
      end, { silent = true })

      -- Load VSCode style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load custom snippets if config exists
      local config_ok, _ = pcall(require, "config.luasnip")
      if not config_ok then
        vim.notify("config.luasnip not found, skipping custom snippets", vim.log.levels.INFO)
      end
    end,
  },
}
