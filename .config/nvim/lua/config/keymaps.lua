local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "//"

map("n", "<leader>pp", vim.cmd.Ex)
map("n", ";", ":")
map("n", "<leader>u", function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end)

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

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

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("v", ">", ">gv")
map("v", "<", "<gv")

-- buffers
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<tab>", "<cmd>bnext<CR>", { desc = "buffer goto next" })
map("n", "<S-tab>", "<cmd>bNext<CR>", { desc = "buffer goto prev" })
map("n", "<leader>x", "<cmd>bdelete!<CR>", { desc = "buffer close" })

-- windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- terminal
map("t", "<leader>x", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("n", "<leader>t", "<cmd>terminal<CR>", { desc = "terminal new horizontal term" })
map("n", "<leader>ht", "<cmd>split<CR><cmd>terminal<CR>", { desc = "terminal new horizontal term" })
map("n", "<leader>vt", "<cmd>vsplit<CR><cmd>terminal<CR>", { desc = "terminal new vertical window" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
