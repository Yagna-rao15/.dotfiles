return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- Better than "User FilePost" for these modules
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring", -- Only needed for mini.comment
    },
  },

  -- Uncomment and configure these as needed:

  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- Better than "User FilePost" for these modules
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("ts_context_commentstring").setup {
        enable_autocmd = false, -- Disable autocmd, we'll handle it manually
        languages = {
          -- Add custom commentstring for specific contexts
          css = "/* %s */",
          scss = "/* %s */",
          html = "<!-- %s -->",
          vue = "<!-- %s -->",
          svelte = "<!-- %s -->",
          astro = "<!-- %s -->",
        },
      }

      require("mini.comment").setup {
        -- Options which control module behavior
        options = {
          -- Function to compute custom commentstring
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring {
              key = "commentstring",
            } or vim.bo.commentstring
          end,
          -- Whether to ignore blank lines
          ignore_blank_line = false,
          -- Whether to recognize indentation
          start_of_line = false,
          -- Whether to ensure single space after comment start
          pad_comment_parts = true,
        },
        -- Module mappings
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = "gc",
          -- Toggle comment on current line
          comment_line = "gcc",
          -- Toggle comment on visual selection
          comment_visual = "gc",
          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          textobject = "gc",
        },
        -- Hook functions to be executed at certain stage of commenting
        hooks = {
          -- Before successful commenting. Does nothing by default.
          pre = function() end,
          -- After successful commenting. Does nothing by default.
          post = function() end,
        },
      }
    end,
  },

  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- Better than "User FilePost" for these modules
    config = function()
      require("mini.ai").setup {
        n_lines = 500, -- Search up to 500 lines for text objects
        custom_textobjects = {
          -- Code blocks (for markdown, etc.)
          c = require("mini.ai").gen_spec.treesitter {
            a = "@code_block.outer",
            i = "@code_block.inner",
          },
          -- Function definitions
          f = require("mini.ai").gen_spec.treesitter {
            a = "@function.outer",
            i = "@function.inner",
          },
          -- Class definitions
          C = require("mini.ai").gen_spec.treesitter {
            a = "@class.outer",
            i = "@class.inner",
          },
          -- Arguments/parameters
          a = require("mini.ai").gen_spec.treesitter {
            a = "@parameter.outer",
            i = "@parameter.inner",
          },
          -- Conditional statements
          o = require("mini.ai").gen_spec.treesitter {
            a = "@conditional.outer",
            i = "@conditional.inner",
          },
          -- Loops
          l = require("mini.ai").gen_spec.treesitter {
            a = "@loop.outer",
            i = "@loop.inner",
          },
          -- Comments
          ["/"] = require("mini.ai").gen_spec.treesitter {
            a = "@comment.outer",
            i = "@comment.inner",
          },
          -- Entire buffer
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line "$",
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
        -- Mappings for text objects
        mappings = {
          around = "a",
          inside = "i",
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",
          goto_left = "g[",
          goto_right = "g]",
        },
        -- Search method for text objects
        search_method = "cover_or_next",
        -- Silent mode
        silent = false,
      }
    end,
  },

  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- Better than "User FilePost" for these modules
    config = function()
      require("mini.surround").setup {
        -- Add custom surroundings
        custom_surroundings = {
          -- Lua string interpolation
          ["$"] = {
            input = { "%$%b()", "^.().*().$" },
            output = { left = "$(", right = ")" },
          },
          -- Markdown code blocks
          ["c"] = {
            input = { "```().-```", "^.().*().$" },
            output = { left = "```\n", right = "\n```" },
          },
          -- HTML/XML tags
          ["t"] = {
            input = { "<%b<>", "^<().*()>$" },
            output = function()
              local tag = vim.fn.input "Tag: "
              if tag == "" then
                return nil
              end
              return { left = "<" .. tag .. ">", right = "</" .. tag .. ">" }
            end,
          },
        },
        -- Highlight duration (in ms)
        highlight_duration = 500,
        -- Module mappings
        mappings = {
          add = "sa", -- Add surrounding in Normal and Visual modes
          delete = "sd", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "sr", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
        },
        -- Number of lines to search
        n_lines = 20,
        -- Whether to respect selection type
        respect_selection_type = false,
        -- How to search for surrounding
        search_method = "cover",
        -- Whether to disable in certain filetypes
        silent = false,
      }
    end,
  },

  {
    "echasnovski/mini.pairs",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" }, -- Better than "User FilePost" for these modules
    config = function()
      require("mini.pairs").setup {
        -- In which modes to enable
        modes = {
          insert = true,
          command = true,
          terminal = false,
        },
        -- Global pairs
        pairs = {
          ["("] = { close = ")", neigh_pattern = "[^\\]." },
          ["["] = { close = "]", neigh_pattern = "[^\\]." },
          ["{"] = { close = "}", neigh_pattern = "[^\\]." },
          ['"'] = { close = '"', neigh_pattern = "[^\\].", register = { cr = false } },
          ["'"] = { close = "'", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ["`"] = { close = "`", neigh_pattern = "[^\\].", register = { cr = false } },
        },
        -- Skip auto-pairing when next character matches pattern
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- Skip auto-pairing in treesitter nodes
        skip_ts = { "string", "comment" },
        -- Skip when cursor is at unbalanced pair
        skip_unbalanced = true,
        -- Markdown-specific behavior
        markdown = true,
      }
    end,
  },

  -- {
  --   "echasnovski/mini.bufremove",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.bufremove").setup()
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.cursorword",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.cursorword").setup()
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.indentscope",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.indentscope").setup {
  --       symbol = "│",
  --       options = { try_as_border = true },
  --     }
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.move",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.move").setup {
  --       mappings = {
  --         -- Move visual selection in Visual mode
  --         left = "<M-h>",
  --         right = "<M-l>",
  --         down = "<M-j>",
  --         up = "<M-k>",
  --         -- Move current line in Normal mode
  --         line_left = "<M-h>",
  --         line_right = "<M-l>",
  --         line_down = "<M-j>",
  --         line_up = "<M-k>",
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.splitjoin",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.splitjoin").setup()
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.starter",
  --   config = function()
  --     require("mini.starter").setup()
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.statusline",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.statusline").setup { use_icons = true }
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.tabline",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.tabline").setup()
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.trailspace",
  --   event = "VeryLazy",
  --   config = function()
  --     require("mini.trailspace").setup()
  --   end,
  -- },
}
