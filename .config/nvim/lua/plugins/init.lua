return {
  { "mbbill/undotree" },
  { "tpope/vim-fugitive" },
  { "windwp/nvim-ts-autotag", event = "User FilePost", opts = {} },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)

      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          vim.opt.formatoptions:remove { "c", "r" }
        end,
      })
    end,
  },

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
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

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
      dofile(vim.g.base46_cache .. "blankline")
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
}
