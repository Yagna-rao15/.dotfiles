local map = vim.keymap.set

vim.g.mapleader = " " -- Space as leader
vim.g.maplocalleader = "\\" -- Backslash as local leader

-- Better command mode access
map("n", ";", ":", { desc = "Enter command mode" })
map("n", ":", ";", { desc = "Repeat last f/F/t/T" }) -- Swap ; and :

-- Delete without copying
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete and copy to system clipboard" })
map("n", "<leader>dd", "_dd", { desc = "Delete line without copying" })
map("v", "<leader>d", "_d", { desc = "Delete selection without copying" })

-- Better undo break-points (create undo points at punctuation)
map("i", ",", ",<c-g>u", { desc = "Undo break-point" })
map("i", ".", ".<c-g>u", { desc = "Undo break-point" })
map("i", ";", ";<c-g>u", { desc = "Undo break-point" })
map("i", "!", "!<c-g>u", { desc = "Undo break-point" })
map("i", "?", "?<c-g>u", { desc = "Undo break-point" })

-- Better text objects and motions
map("n", "H", "^", { desc = "Go to first non-blank character" })
map("n", "L", "$", { desc = "Go to end of line" })
map("v", "H", "^", { desc = "Go to first non-blank character" })
map("v", "L", "$", { desc = "Go to end of line" })

-- Better search centering
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "*", "*zzzv", { desc = "Search word under cursor (centered)" })
map("n", "#", "#zzzv", { desc = "Search word under cursor backwards (centered)" })

-- Clear search highlights
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })

-- Better page scrolling (keep cursor centered)
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page (centered)" })
map("n", "<C-f>", "<C-f>zz", { desc = "Scroll down full page (centered)" })
map("n", "<C-b>", "<C-b>zz", { desc = "Scroll up full page (centered)" })

-- Jump list navigation
map("n", "<C-o>", "<C-o>zz", { desc = "Jump back (centered)" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump forward (centered)" })

-- Keep visual selection when indenting
map("v", ">", ">gv", { desc = "Indent and keep selection" })
map("v", "<", "<gv", { desc = "Outdent and keep selection" })
map("v", "=", "=gv", { desc = "Format and keep selection" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment line", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment selection", remap = true })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- -- Window navigation
map("n", "<C-h>", "<cmd>lua require('config.window').cycle_window_left()<CR>", { desc = "Go to left window" })
map("n", "<C-l>", "<cmd>lua require('config.window').cycle_window_right()<CR>", { desc = "Go to right window" })
map("n", "<C-j>", "<cmd>lua require('config.window').cycle_window_down()<CR>", { desc = "Go to lower window" })
map("n", "<C-k>", "<cmd>lua require('config.window').cycle_window_up()<CR>", { desc = "Go to upper window" })

-- -- Alternative window navigation (fallback)
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })

-- Buffer navigation
map("n", "<C-n>", ":bn<CR>", { desc = "Next buffer", noremap = true })
map("n", "<C-p>", ":bp<CR>", { desc = "Previous buffer", noremap = true })
map("n", "[b", ":bp<CR>", { desc = "Previous buffer" })
map("n", "]b", ":bn<CR>", { desc = "Next buffer" })

-- Buffer management
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })
map("n", "<leader>x", "<cmd>bdelete!<CR>", { desc = "Close buffer" })

-- File operations
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy entire file" })

-- File explorer
map("n", "<leader>pp", vim.cmd.Ex, { desc = "Open file explorer" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Terminal management
map("n", "<leader>t", "<cmd>terminal<CR>", { desc = "Open terminal" })
map("n", "<leader>ht", "<cmd>split<CR><cmd>terminal<CR>", { desc = "Horizontal terminal" })
map("n", "<leader>vt", "<cmd>vsplit<CR><cmd>terminal<CR>", { desc = "Vertical terminal" })
map("t", "<leader>x", "<C-\\><C-N>", { desc = "Exit terminal mode" })
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Terminal left window" })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Terminal down window" })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Terminal up window" })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Terminal right window" })

-- Line wrap toggle
map("n", "<leader>lw", "<cmd>:set wrap!<CR>", { desc = "Toggle line wrap" })

-- Quick fix and location list
map("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
map("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })
map("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close location list" })
map("n", "]l", "<cmd>lnext<CR>", { desc = "Next location item" })
map("n", "[l", "<cmd>lprev<CR>", { desc = "Previous location item" })

-- Better increment/decrement
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("v", "+", "g<C-a>", { desc = "Increment numbers (visual)" })
map("v", "-", "g<C-x>", { desc = "Decrement numbers (visual)" })

-- Spell checking
map("n", "<leader>s", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })
map("n", "]s", "]s", { desc = "Next spelling error" })
map("n", "[s", "[s", { desc = "Previous spelling error" })
map("n", "z=", "z=", { desc = "Spelling suggestions" })
map("n", "zg", "zg", { desc = "Add word to dictionary" })

-- Fold management
-- map("n", "zR", "zR", { desc = "Open all folds" })
-- map("n", "zM", "zM", { desc = "Close all folds" })
-- map("n", "za", "za", { desc = "Toggle fold" })
-- map("n", "zo", "zo", { desc = "Open fold" })
-- map("n", "zc", "zc", { desc = "Close fold" })

-- Center cursor on various motions
map("n", "}", "}zz", { desc = "Next paragraph and center" })
map("n", "{", "{zz", { desc = "Previous paragraph and center" })

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Select all" })
