return {
  "hkupty/iron.nvim",
  config = function(_, _)
    local iron = require "iron.core"
    local view = require "iron.view"
    local common = require "iron.fts.common"

    iron.setup {
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = { command = { "zsh" } },
          python = { command = { "python" } or { "ipython", "--no-autoindent" } },
        },

        repl_filetype = function(bufnr, ft)
          return ft
        end,

        -- repl_open_cmd = require("iron.view").right(60),
        repl_open_cmd = view.split.vertical.rightbelow "%40",
      },

      keymaps = {
        send_motion = "<space>rc",
        visual_send = "<space>rc",
        send_file = "<space>rF",
        send_line = "<space>rl",
        -- send_mark = "<space>rm",
        -- mark_motion = "<space>rmc",
        -- mark_visual = "<space>rmc",
        -- remove_mark = "<space>rmd",
        cr = "<space>r<cr>",
        interrupt = "<space>r<space>",
        exit = "<space>rq",
        clear = "<space>rx",
        send_paragraph = "<space>rp",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
    vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
    vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
    vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
  end,
}
