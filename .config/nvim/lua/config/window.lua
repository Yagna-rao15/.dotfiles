-- lua/my_keymaps.lua (or similar file)
local M = {}

local function tbl_indexof(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
  return nil
end

local function cycle_window(direction)
  local current_win = vim.api.nvim_get_current_win()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local wins = vim.api.nvim_tabpage_list_wins(current_tab)
  local current_win_index = tbl_indexof(wins, current_win)

  if current_win_index then
    local next_win_index
    if direction == "left" then
      next_win_index = current_win_index - 1
      if next_win_index < 1 then
        next_win_index = #wins
      end
    elseif direction == "right" then
      next_win_index = current_win_index + 1
      if next_win_index > #wins then
        next_win_index = 1
      end
    elseif direction == "down" then
      local grid = vim.api.nvim_win_get_position(current_win)
      local current_row = grid[1]
      local next_row = 1000000
      local next_win = current_win
      for _, win in ipairs(wins) do
        local winGrid = vim.api.nvim_win_get_position(win)
        local winRow = winGrid[1]
        if winRow > current_row and winRow < next_row then
          next_row = winRow
          next_win = win
        end
      end
      if next_win == current_win then
        next_row = -1
        for _, win in ipairs(wins) do
          local winGrid = vim.api.nvim_win_get_position(win)
          local winRow = winGrid[1]
          if winRow < current_row and winRow > next_row then
            next_row = winRow
            next_win = win
          end
        end
      end
      if next_win ~= current_win then
        vim.api.nvim_set_current_win(next_win)
        return
      end
    elseif direction == "up" then
      local grid = vim.api.nvim_win_get_position(current_win)
      local current_row = grid[1]
      local next_row = -1
      local next_win = current_win
      for _, win in ipairs(wins) do
        local winGrid = vim.api.nvim_win_get_position(win)
        local winRow = winGrid[1]
        if winRow < current_row and winRow > next_row then
          next_row = winRow
          next_win = win
        end
      end
      if next_win == current_win then
        next_row = 1000000
        for _, win in ipairs(wins) do
          local winGrid = vim.api.nvim_win_get_position(win)
          local winRow = winGrid[1]
          if winRow > current_row and winRow < next_row then
            next_row = winRow
            next_win = win
          end
        end
      end
      if next_win ~= current_win then
        vim.api.nvim_set_current_win(next_win)
        return
      end
    end

    if next_win_index then
      vim.api.nvim_set_current_win(wins[next_win_index])
    end
  end
end

M.cycle_window_left = function()
  cycle_window "left"
end

M.cycle_window_right = function()
  cycle_window "right"
end

M.cycle_window_down = function()
  cycle_window "down"
end

M.cycle_window_up = function()
  cycle_window "up"
end

return M
