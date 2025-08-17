return {
  {
    "nvim-lua/plenary.nvim",
    {
      "nvchad/base46",
      lazy = true,
      build = function()
        -- require("base46").load_all_highlights()
      end,
    },
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- File finding
      { "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" } },
      { "<leader>fa", "<cmd>FzfLua files cwd=~<cr>", { desc = "Find files (home)" } },
      { "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "Find recent files" } },
      { "<leader>fn", "<cmd>FzfLua files cwd=~/Obsidian/<CR>", { desc = "Find notes" } },

      -- Search and grep
      { "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" } },
      { "<leader>fg", "<cmd>FzfLua grep_cword<CR>", { desc = "Grep word under cursor" } },

      -- Buffer and navigation
      { "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" } },
      { "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find marks" } },
      { "<leader>fj", "<cmd>FzfLua jumps<CR>", { desc = "Find jumps" } },
      { "<leader>fr", "<cmd>FzfLua registers<CR>", { desc = "Find registers" } },

      -- Help and documentation
      { "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "Find help" } },
      { "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Find keymaps" } },
      { "<leader>fc", "<cmd>FzfLua commands<CR>", { desc = "Find commands" } },

      -- Git integration
      { "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Git commits" } },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Git status" } },
      { "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" } },
    },

    opts = {
      winopts = {
        preview = {
          border = "single",
          title = true,
          scrollbar = false,
        },
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "none",
        fullscreen = false,
      },
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "󰍵" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "│" },
        },
        signs_staged = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "󰍵" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "│" },
        },
      }
    end,
    config = function(_, opts)
      if Nvchad then
        dofile(vim.g.base46_cache .. "git")
      end
      require("gitsigns").setup(opts)
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      -- Attaches to every FileType mode
      require("colorizer").setup()

      -- Attach to certain Filetypes, add special configuration for `html`
      -- Use `background` for everything else.
      require("colorizer").setup {
        "css",
        "javascript",
        html = {
          mode = "foreground",
        },
      }

      -- Use the `default_options` as the second parameter, which uses
      -- `foreground` for every mode. This is the inverse of the previous
      -- setup configuration.
      require("colorizer").setup({
        "css",
        "javascript",
        html = { mode = "background" },
      }, { mode = "foreground" })

      -- Use the `default_options` as the second parameter, which uses
      -- `foreground` for every mode. This is the inverse of the previous
      -- setup configuration.
      require("colorizer").setup {
        "*", -- Highlight all files, but customize some others.
        css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
        html = { names = false }, -- Disable parsing "names" like Blue or Gray
      }

      -- Exclude some filetypes from highlighting by using `!`
      require("colorizer").setup {
        "*", -- Highlight all files, but customize some others.
        "!vim", -- Exclude vim from highlighting.
        -- Exclusion Only makes sense if '*' is specified!
      }
    end,
  },
}
