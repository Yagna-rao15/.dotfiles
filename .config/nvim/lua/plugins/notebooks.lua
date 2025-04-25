return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim", "vhyrro/luarocks.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_python_path = "/usr/bin/python3"
      vim.g.molten_jupyter_kernel = "python3"
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    -- ft = { "python", "r", "julia", "markdown" },
    config = function()
      local init = function()
        local quarto_cfg = require("quarto.config").config
        quarto_cfg.codeRunner.default_method = "molten"
        vim.cmd [[MoltenInit]]
      end
      local deinit = function()
        local quarto_cfg = require("quarto.config").config
        quarto_cfg.codeRunner.default_method = "slime"
        vim.cmd [[MoltenDeinit]]
      end
      vim.keymap.set("n", "<localleader>mi", init, { silent = true, desc = "Initialize molten" })
      vim.keymap.set("n", "<localleader>md", deinit, { silent = true, desc = "Stop molten" })
      vim.keymap.set("n", "<localleader>mp", ":MoltenImagePopup<CR>", { silent = true, desc = "molten image popup" })
      vim.keymap.set("n", "<localleader>mb", ":MoltenOpenInBrowser<CR>", { silent = true, desc = "open in browser" })
      vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
      vim.keymap.set("n", "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>", { silent = true })
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { "r", "python", "rust" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        hover = "K",
        definition = "gd",
        rename = "<leader>rn",
        references = "gr",
        format = "<leader>gf",
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    config = function(opts)
      require("quarto").setup(opts)
      local runner = require "quarto.runner"
      vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })
    end,
  },

  {
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup {
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      }
    end,
  },
}
