return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ac"] = "@code_block.outer",
            ["ic"] = "@code_block.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = false,
          goto_next_start = {
            ["]c"] = "@code_block.outer",
          },
          goto_previous_start = {
            ["[c"] = "@code_block.outer",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
