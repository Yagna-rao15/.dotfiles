local opt = vim.opt
local g = vim.g

-- Status and mode display
opt.laststatus = 3 -- global statusline
opt.showmode = true -- show mode in command line
opt.ruler = true -- don't show ruler which is line and col no. in bottom right
opt.cmdheight = 1 -- command line height: 0- hide command line when not used
g.netrw_banner = 0 -- netrw banner mode

-- Cursor and visual elements
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
opt.cursorline = false -- highlight current line
opt.cursorcolumn = false -- highlight current column
-- opt.colorcolumn = "80" -- highlight column at 80 chars
opt.signcolumn = "yes" -- always show sign column
opt.termguicolors = true -- enable 24-bit RGB colors

-- Line numbers
opt.number = true -- show line numbers
opt.relativenumber = true -- use relative line numbers
opt.numberwidth = 2 -- width of number column

-- Visual whitespace and special characters
opt.list = true -- show invisible characters
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  extends = "⟩", -- character for line continuation
  precedes = "⟨", -- character for line continuation (left)
  -- eol = "↴", -- end of line character
}

-- Folding
-- opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", }
-- opt.foldlevel = 99
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
-- opt.foldtext = ""
-- opt.foldopen = "mark,percent,quickfix,search,tag,undo"

-- Concealing
-- opt.conceallevel = 2
-- opt.concealcursor = "niv" -- conceal in normal, insert, visual modes

-- Popup menu
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10 -- maximum items in popup menu
opt.pumblend = 10 -- popup menu transparency

-- Indentation settings
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- number of spaces for each indent
opt.tabstop = 2 -- number of spaces for tab character
opt.softtabstop = 2 -- number of spaces for tab in insert mode
opt.autoindent = true -- copy indent from current line
opt.smartindent = true -- smart autoindenting
opt.breakindent = true -- wrapped lines continue visually indented
opt.shiftround = true -- round indent to multiple of shiftwidth

-- Text wrapping and formatting
opt.wrap = true -- don't wrap lines by default
opt.linebreak = true -- wrap at word boundaries
opt.showbreak = "↪ " -- string to show at start of wrapped lines
opt.virtualedit = "block" -- allow cursor beyond end of line in visual block

-- Text width and formatting
opt.textwidth = 80 -- maximum line length
opt.formatoptions = "jcroqlnt" -- format options

-- Search behavior
opt.ignorecase = true -- ignore case in search
opt.smartcase = true -- override ignorecase if search has uppercase
opt.incsearch = true -- show search matches as you type
opt.hlsearch = true -- highlight search matches
opt.inccommand = "split" -- show substitution preview

-- Navigation and scrolling
opt.scrolloff = 5 -- keep 5 lines above/below cursor
opt.sidescrolloff = 8 -- keep 8 columns left/right of cursor
opt.smoothscroll = true -- smooth scrolling (nvim 0.10+)

-- Line movement
opt.whichwrap:append "<>[]hl" -- allow h,l,arrows to move across lines
opt.backspace = { "start", "eol", "indent" } -- backspace behavior

-- Window splitting
opt.splitbelow = true -- horizontal splits below current
opt.splitright = true -- vertical splits to the right
opt.equalalways = false -- don't resize windows automatically
opt.winborder = "rounded"

-- Buffer behavior
opt.hidden = true -- allow hidden buffers
-- opt.confirm = true -- ask for confirmation instead of failing
opt.autoread = true -- automatically read file changes
opt.autowrite = true -- automatically write file before commands

-- Backup and swap files
opt.backup = false -- don't create backup files
opt.swapfile = false -- don't create swap files
opt.undofile = true -- enable persistent undo
opt.undolevels = 10000 -- maximum number of undos

-- File encoding and format
-- opt.fileencoding = "utf-8" -- file encoding
-- opt.fileformats = "unix,dos,mac" -- file format detection order

-- Timing settings
opt.updatetime = 50 -- faster completion and diagnostics
opt.timeoutlen = 400 -- time to wait for mapped sequence
opt.ttimeoutlen = 100 -- time to wait for key code sequence

-- Performance optimizations
opt.lazyredraw = true -- don't redraw during macros
opt.synmaxcol = 300 -- max column for syntax highlighting
-- opt.regexpengine = 1 -- use old regex engine (sometimes faster)

opt.mouse = "a" -- enable mouse in all modes
opt.clipboard:append "unnamedplus" -- use system clipboard

-- Plugin and feature flags
g.have_nerd_font = true -- indicate nerd font is available
g.editorconfig = true -- enable editorconfig support
g.markdown_recommended_style = 0 -- disable markdown style recommendations

-- Disable unused providers (performance)
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- Mason binary path
local is_windows = vim.fn.has "win32" ~= 0
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- Window and session management
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
opt.viewoptions = "cursor,folds,slash,unix"

-- Completion and wildmenu
opt.wildmode = "longest:full,full" -- command line completion mode
opt.wildignore:append { "*.o", "*.obj", ".git", "node_modules", "*.pyc" }
opt.wildignorecase = true -- ignore case in file completion

-- Diff options
opt.diffopt:append "linematch:60" -- better diff algorithm
opt.diffopt:append "algorithm:histogram"

-- Grep and external tools
opt.grepprg = "rg --vimgrep --smart-case --follow"
opt.grepformat = "%f:%l:%c:%m"

-- Spelling
-- opt.spell = true
-- opt.spelllang = "en_us"
-- opt.spellfile = vim.fn.stdpath "config" .. "/spell/en.utf-8.add"
