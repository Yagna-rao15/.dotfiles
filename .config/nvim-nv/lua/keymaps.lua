local map = vim.keymap.set

vim.g.mapleader = " " -- Space as leader
vim.g.maplocalleader = "\\" -- Backslash as local leader

-- Better command mode access
map("n", ";", ":", { desc = "Enter command mode" })
map("n", ":", ";", { desc = "Repeat last f/F/t/T" }) -- Swap ; and :

-- Better paste behavior
map("x", "p", "_dP", { desc = "Paste without cutting in visual mode" })
map("x", "P", "_dP", { desc = "Paste without cutting in visual mode" })

-- Delete without copying
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete and copy to system clipboard" })
map("n", "x", "_x", { desc = "Delete single char without copying" })
map("n", "X", "_X", { desc = "Delete char before cursor without copying" })
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

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Window navigation
map("n", "<M-h>", "<cmd>lua require('config.window').cycle_window_left()<CR>", { desc = "Go to left window" })
map("n", "<M-l>", "<cmd>lua require('config.window').cycle_window_right()<CR>", { desc = "Go to right window" })
map("n", "<M-j>", "<cmd>lua require('config.window').cycle_window_down()<CR>", { desc = "Go to lower window" })
map("n", "<M-k>", "<cmd>lua require('config.window').cycle_window_up()<CR>", { desc = "Go to upper window" })

-- Alternative window navigation (fallback)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })

-- Window resizingW
-- map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
-- map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

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

-- File finding
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd>FzfLua files cwd=~<cr>", { desc = "Find files (home)" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "Find recent files" })
map("n", "<leader>fn", "<cmd>FzfLua files cwd=~/Obsidian/<CR>", { desc = "Find notes" })

-- Search and grep
map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
-- map("n", "<leader>fg", "<cmd>FzfLua grep_cword<CR>", { desc = "Grep word under cursor" })

-- Buffer and navigation
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fm", "<cmd>FzfLua marks<CR>", { desc = "Find marks" })
map("n", "<leader>fj", "<cmd>FzfLua jumps<CR>", { desc = "Find jumps" })
map("n", "<leader>fr", "<cmd>FzfLua registers<CR>", { desc = "Find registers" })

-- Help and documentation
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "Find help" })
map("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Find keymaps" })
map("n", "<leader>fc", "<cmd>FzfLua commands<CR>", { desc = "Find commands" })

-- Git integration
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" })

-- Diagnostic navigation function
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

-- Diagnostic navigation
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Previous diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Previous error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Previous warning" })

-- LSP keymaps (usually set in lsp config, but here for reference)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })

-- Comment toggle (using Comment.nvim or similar)
map("n", "<leader>/", "gcc", { desc = "Toggle comment line", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment selection", remap = true })

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

-- Undo tree
map("n", "<leader>u", function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end, { desc = "Toggle undo tree" })

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

-- Todo Comment
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Jump to next todo" })
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Jump to prev todo" })

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

-- Open URL under cursor
map("n", "gx", "<cmd>!open <cWORD><CR>", { desc = "Open URL under cursor" })

-- Insert mode shortcuts
-- map("i", "<C-h>", "<Left>", { desc = "Move left in insert mode" })
-- map("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })
-- map("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
-- map("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })

-- Command mode shortcuts
-- map("c", "<C-h>", "<Left>", { desc = "Move left in command mode" })
-- map("c", "<C-l>", "<Right>", { desc = "Move right in command mode" })
-- map("c", "<C-j>", "<Down>", { desc = "Move down in command mode" })
-- map("c", "<C-k>", "<Up>", { desc = "Move up in command mode" })

--[[
Vim/Neovim conventions and best practices:

1. Use ] and [ for forward/backward navigation:
   - ]d / [d for diagnostics
   - ]b / [b for buffers
   - ]q / [q for quickfix
   - ]s / [s for spelling

2. Use g prefix for "go to" operations:
   - gd (go to definition)
   - gr (go to references)
   - gi (go to implementation)

3. Use z for view/folding operations:
   - zz (center line)
   - za (toggle fold)
   - zR (open all folds)

4. Use <leader> for custom operations, organize by category:
   - <leader>f* for finding/fuzzy operations
   - <leader>g* for git operations
   - <leader>b* for buffer operations
   - <leader>w* for window operations
   - <leader>t* for terminal operations

5. Use <C-*> for common operations across modes:
   - <C-s> for save
   - <C-hjkl> for navigation
   - <C-n>/<C-p> for next/previous (though ]/* is more Vim-like)

6. Keep insert mode mappings minimal - Vim philosophy favors normal mode
]]
