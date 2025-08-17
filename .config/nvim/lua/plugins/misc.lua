return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        function()
          vim.cmd.UndotreeToggle()
          vim.cmd.UndotreeFocus()
        end,
        { desc = "Toggle undo tree" },
      },
    },
  },
  { "tpope/vim-fugitive" },
  { "windwp/nvim-ts-autotag", event = "User FilePost", opts = {} },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      -- your configuration comes here
      global_keymaps = true,
    },
  },
  -- {
  --   "numToStr/Comment.nvim",
  --   keys = {
  --     { "gcc", mode = "n", desc = "Comment toggle current line" },
  --     { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
  --     { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
  --     { "gbc", mode = "n", desc = "Comment toggle current block" },
  --     { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
  --     { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
  --   },
  --   config = function(_, opts)
  --     require("Comment").setup(opts)
  --
  --     vim.api.nvim_create_autocmd("BufEnter", {
  --       callback = function()
  --         vim.opt.formatoptions:remove { "c", "r" }
  --       end,
  --     })
  --   end,
  -- },

  {
    "ThePrimeagen/vim-be-good",
    config = function(_, opts) end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function(_, opts)
      if NvChad then
        dofile(vim.g.base46_cache .. "devicons")
      end
      require("nvim-web-devicons").setup(opts)
    end,
  },
  -- {
  --   "folke/ts-comments.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    event = "User FilePost",
    opts = {
      indentLine_enabled = 1,
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = true,
      show_first_indent_level = true,
      show_current_context = false,
      show_current_context_start = false,
    },
    config = function(_, opts)
      if Nvchad then
        dofile(vim.g.base46_cache .. "blankline")
      end
      require("indent_blankline").setup(opts)
    end,
  },

  -- {
  --   "alexghergh/nvim-tmux-navigation",
  --   lazy = false,
  -- },

  -- {
  --   "nvzone/typr",
  --   cmd = "TyprStats",
  --   dependencies = "nvzone/volt",
  --   opts = {},
  -- },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 80,
        backdrop = 0,
        options = {
          number = false,
          relativenumber = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
      },
    },
  },
  "nvchad/volt",

  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
    config = function(_, opts)
      require("clangd_extensions").setup(opts)
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    {
      "NvChad/nvim-colorizer.lua",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = {},
      config = function()
        local nvchadcolorizer = require "colorizer"
        local tailwindcolorizer = require "tailwindcss-colorizer-cmp"

        nvchadcolorizer.setup {
          user_default_options = {
            tailwind = true,
          },
          filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
        }

        tailwindcolorizer.setup {
          color_square_width = 2,
        }

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
          callback = function()
            vim.cmd "ColorizerAttachToBuffer"
          end,
        })
      end,
    },
  },
}
