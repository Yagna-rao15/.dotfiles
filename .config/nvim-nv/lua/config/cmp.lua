local M = {}

M.utils = {
  -- Returns the current column number
  column = function()
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col
  end,

  -- Replace terminal codes
  rhs = function(keys)
    return vim.api.nvim_replace_termcodes(keys, true, true, true)
  end,

  -- Custom shift width calculation
  shift_width = function()
    if vim.o.softtabstop <= 0 then
      return vim.fn.shiftwidth()
    else
      return vim.o.softtabstop
    end
  end,
}

M.conditions = {
  -- Check if cursor is in a luasnip snippet
  in_snippet = function()
    local has_luasnip, luasnip = pcall(require, "luasnip")
    if not has_luasnip then
      return false
    end

    local session = require "luasnip.session"
    local node = session.current_nodes[vim.api.nvim_get_current_buf()]
    if not node then
      return false
    end

    local snippet = node.parent.snippet
    local snip_begin_pos, snip_end_pos = snippet.mark:pos_begin_end()
    local pos = vim.api.nvim_win_get_cursor(0)
    return pos[1] - 1 >= snip_begin_pos[1] and pos[1] - 1 <= snip_end_pos[1]
  end,

  -- Check if cursor is in whitespace
  in_whitespace = function()
    local col = M.utils.column()
    return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match "%s"
  end,

  -- Check if cursor is in leading indentation
  in_leading_indent = function()
    local col = M.utils.column()
    local line = vim.api.nvim_get_current_line()
    local prefix = line:sub(1, col)
    return prefix:find "^%s*$"
  end,
}

M.smart_input = {
  -- Smart backspace functionality
  smart_bs = function(dedent)
    local keys = nil
    if vim.o.expandtab then
      keys = dedent and M.utils.rhs "<C-D>" or M.utils.rhs "<BS>"
    else
      local col = M.utils.column()
      local line = vim.api.nvim_get_current_line()
      local prefix = line:sub(1, col)

      if M.conditions.in_leading_indent() then
        keys = M.utils.rhs "<BS>"
      else
        local previous_char = prefix:sub(#prefix, #prefix)
        if previous_char ~= " " then
          keys = M.utils.rhs "<BS>"
        else
          keys = M.utils.rhs "<C-\\><C-o>:set expandtab<CR><BS><C-\\><C-o>:set noexpandtab<CR>"
        end
      end
    end
    vim.api.nvim_feedkeys(keys, "nt", true)
  end,

  -- Smart tab functionality
  smart_tab = function()
    local keys = nil
    if vim.o.expandtab then
      keys = "<Tab>"
    else
      local col = M.utils.column()
      local line = vim.api.nvim_get_current_line()
      local prefix = line:sub(1, col)
      local in_leading_indent = prefix:find "^%s*$"

      if in_leading_indent then
        keys = "<Tab>"
      else
        local sw = M.utils.shift_width()
        local previous_char = prefix:sub(#prefix, #prefix)
        local previous_column = #prefix - #previous_char + 1
        local current_column = vim.fn.virtcol { vim.fn.line ".", previous_column } + 1
        local remainder = (current_column - 1) % sw
        local move = remainder == 0 and sw or sw - remainder
        keys = (" "):rep(move)
      end
    end
    vim.api.nvim_feedkeys(M.utils.rhs(keys), "nt", true)
  end,
}

-- CMP helper functions
M.cmp_helpers = {
  -- Select next item with fallback
  select_next_item = function(fallback)
    local cmp = require "cmp"
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end,

  -- Select previous item with fallback
  select_prev_item = function(fallback)
    local cmp = require "cmp"
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end,

  -- Smart confirm with behavior selection
  confirm = function(entry)
    local cmp = require "cmp"
    local behavior = cmp.ConfirmBehavior.Replace

    if entry then
      local completion_item = entry.completion_item
      local newText = ""

      if completion_item.textEdit then
        newText = completion_item.textEdit.newText
      elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
        newText = completion_item.insertText
      else
        newText = completion_item.word or completion_item.label or ""
      end

      -- Check character differences after cursor
      local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col

      -- Use Insert behavior if suffix doesn't match
      if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
        behavior = cmp.ConfirmBehavior.Insert
      end
    end

    cmp.confirm { select = true, behavior = behavior }
  end,
}

-- LSP kind icons
M.lsp_kinds = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Operator = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

-- Ghost text toggle function
M.setup_ghost_text = function()
  local cmp = require "cmp"
  local config = require "cmp.config"

  local toggle_ghost_text = function()
    if vim.api.nvim_get_mode().mode ~= "i" then
      return
    end

    local cursor_column = vim.fn.col "."
    local current_line_contents = vim.fn.getline "."
    local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

    local should_enable_ghost_text = character_after_cursor == "" or vim.fn.match(character_after_cursor, [[\k]]) == -1

    local current = config.get().experimental.ghost_text
    if current ~= should_enable_ghost_text then
      config.set_global {
        experimental = {
          ghost_text = should_enable_ghost_text,
        },
      }
    end
  end

  vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
    callback = toggle_ghost_text,
  })
end

return M
