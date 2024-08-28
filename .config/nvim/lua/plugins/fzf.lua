return {
  "ibhagwan/fzf-lua",
  cmd = "Fzflua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    fzf_colors = true,
    fzf_opts = {
      ["--no-scrollbar"] = true,
    },
    defaults = {
      formatter = "path.dirname_first",
    },
    previewers = {
      builtin = {
        extensions = {
          ["png"] = img_previewer,
          ["jpg"] = img_previewer,
          ["jpeg"] = img_previewer,
          ["gif"] = img_previewer,
          ["webp"] = img_previewer,
        },
        ueberzug_scaler = "fit_contain",
      },
    },
    -- Custom LazyVim option to configure vim.ui.select
    ui_select = function(fzf_opts, items)
      return vim.tbl_deep_extend("force", fzf_opts, {
        prompt = " ",
        winopts = {
          title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
          title_pos = "center",
        },
      }, fzf_opts.kind == "codeaction" and {
        winopts = {
          layout = "vertical",
          -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
          height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
          width = 0.5,
          preview = {
            layout = "vertical",
            vertical = "down:15,border-top",
            hidden = "hidden",
          } or {
            layout = "vertical",
            vertical = "down:15,border-top",
          },
        },
      } or {
        winopts = {
          width = 0.5,
          height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
        },
      })
    end,
    winopts = {
      width = 0.8,
      height = 0.8,
      row = 0.5,
      col = 0.5,
      preview = {
        scrollchars = { "┃", "" },
      },
    },
    files = {
      cwd_prompt = false,
      actions = {
        -- ["alt-i"] = { actions.toggle_ignore },
        -- ["alt-h"] = { actions.toggle_hidden },
      },
    },
    grep = {
      actions = {
        -- ["alt-i"] = { actions.toggle_ignore },
        -- ["alt-h"] = { actions.toggle_hidden },
      },
    },
    lsp = {
      symbols = {
        symbol_hl = function(s)
          return "TroubleIcon" .. s
        end,
        symbol_fmt = function(s)
          return s:lower() .. "\t"
        end,
        child_prefix = false,
      },
      code_actions = {
        previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
      },
    },
  },
  config = function()
    require("fzf-lua").setup({})
  end
}
