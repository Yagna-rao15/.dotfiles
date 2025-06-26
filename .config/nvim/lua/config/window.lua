local M = {}

local function tbl_indexof(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end
  return nil
end

local function is_tmux()
  return os.getenv "TMUX" ~= nil
end

local function tmux_navigate(direction)
  local keys = {
    left = "L",
    right = "R",
    up = "U",
    down = "D",
  }
  local key = keys[direction]
  if key then
    -- Use tmux to switch pane
    os.execute("tmux select-pane -" .. key)
  end
end

local function cycle_window(direction)
  local current_win = vim.api.nvim_get_current_win()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local wins = vim.tbl_filter(function(win)
    local config = vim.api.nvim_win_get_config(win)
    local buf = vim.api.nvim_win_get_buf(win)
    return not config.relative
      or config.relative == "" -- not a floating win
        and vim.bo[buf].buftype == "" -- not terminal/prompt/etc
        and vim.bo[buf].buflisted -- only listed buffers
  end, vim.api.nvim_tabpage_list_wins(current_tab))

  local current_win_index = tbl_indexof(wins, current_win)

  if direction == "left" or direction == "right" then
    if current_win_index then
      local next_win_index
      if direction == "left" then
        next_win_index = current_win_index - 1
        if next_win_index < 1 then
          next_win_index = #wins
        end
      else
        next_win_index = current_win_index + 1
        if next_win_index > #wins then
          next_win_index = 1
        end
      end

      if wins[next_win_index] then
        vim.api.nvim_set_current_win(wins[next_win_index])
        return
      end
    end
  else
    local grid = vim.api.nvim_win_get_position(current_win)
    local current_row = grid[1]
    local next_row = direction == "down" and 1000000 or -1
    local next_win = current_win

    for _, win in ipairs(wins) do
      local winRow = vim.api.nvim_win_get_position(win)[1]
      if direction == "down" and winRow > current_row and winRow < next_row then
        next_row = winRow
        next_win = win
      elseif direction == "up" and winRow < current_row and winRow > next_row then
        next_row = winRow
        next_win = win
      end
    end

    if next_win ~= current_win then
      vim.api.nvim_set_current_win(next_win)
      return
    end
  end

  -- If we reach here, no suitable nvim window was found, fall back to tmux
  if is_tmux() then
    tmux_navigate(direction)
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
