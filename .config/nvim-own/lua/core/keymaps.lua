local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "//"

map("n", "<leader>pp", vim.cmd.Ex)
map("n", ";", ":")
map("n", "<leader>u", function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end)

-- fzf
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "FzfLua find files" })
map("n", "<leader>fa", "<cmd>FzfLua files cwd=~<cr>", { desc = "FzfLua find files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "FzfLua live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "FzfLua find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "FzfLua help page" })
map("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "FzfLua find marks" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "FzfLua find oldfiles" })
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "FzfLua git commits" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "FzfLua git status" })
--map("n", "<leader>ft", "<cmd>FzfLua terms<CR>", { desc = "FzfLua pick hidden term" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

-- tabs
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<tab>", "<cmd>bnext<CR>", { desc = "buffer goto next" })
map("n", "<S-tab>", "<cmd>bNext<CR>", { desc = "buffer goto prev" })
map("n", "<leader>x", "<cmd>bdelete!<CR>", { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- terminal
map("t", "<leader>x", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("n", "<leader>t", "<cmd>terminal<CR>", { desc = "terminal new horizontal term" })
map("n", "<leader>ht", "<cmd>terminal<CR>", { desc = "terminal new horizontal term" })
map("n", "<leader>vt", "<cmd>terminal<CR>", { desc = "terminal new vertical window" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })
