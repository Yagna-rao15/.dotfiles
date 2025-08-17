local augroup = vim.api.nvim_create_augroup("UserConfig", {})
local autocmd = vim.api.nvim_create_autocmd
local user_command = vim.api.nvim_create_user_command

-- Highlight yanked text
autocmd("TextYankPost", {
  desc = "Highlight when yanking text block",
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Don't list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  group = augroup,
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Reload configuration on save
autocmd("BufWritePost", {
  pattern = vim.tbl_map(function(path)
    return vim.fs.normalize(vim.loop.fs_realpath(path))
  end, vim.fn.glob(vim.fn.stdpath "config" .. "/lua/custom/**/*.lua", true, true, true)),
  group = vim.api.nvim_create_augroup("ReloadNvChad", {}),
  callback = function(opts)
    local fp = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf)), ":r") --[[@as string]]
    local app_name = vim.env.NVIM_APPNAME and vim.env.NVIM_APPNAME or "nvim"
    local module = string.gsub(fp, "^.*/" .. app_name .. "/lua/", ""):gsub("/", ".")

    require("plenary.reload").reload_module "base46"
    require("plenary.reload").reload_module(module)
    require("plenary.reload").reload_module "custom.chadrc"
    require("lint").try_lint()
  end,
})

-- File handling and UI initialization
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_buf_get_option(args.buf, "buftype")

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- Auto-format on save
autocmd("BufWritePre", {
  pattern = "*",
  group = augroup,
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

-- Create directories when saving files
autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function()
    local file_path = vim.fn.expand "<afile>:p:h"
    if vim.fn.isdirectory(file_path) == 0 then
      vim.fn.mkdir(file_path, "p")
    end
  end,
})

-- Text wrapping and spell check for specific file types
autocmd("FileType", {
  group = augroup,
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for JSON files
autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Close terminal when exited
autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.state == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- LSP Codelens refresh
autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

-- Set working directory to current file's directory
user_command("Setwd", function()
  vim.cmd("cd " .. vim.fn.expand "%:p:h")
end, {})

-- Toggle flag
vim.g.markdown_zen_enabled = false

-- Custom :ZenMode command
user_command("ZenMode", function()
  local ft = vim.bo.filetype
  if ft ~= "markdown" then
    vim.notify("ZenMode is only for Markdown files ✍️", vim.log.levels.WARN)
    return
  end

  local o = vim.opt
  local bufnr = vim.api.nvim_get_current_buf()

  if not vim.g.markdown_zen_enabled then
    vim.cmd [[
      highlight NormalNC guibg=NONE ctermbg=NONE
      highlight NormalFloat guibg=NONE ctermbg=NONE
    ]]
    -- Enable Zen Mode
    require("zen-mode").open()

    -- Visual settings
    o.wrap = true
    o.linebreak = true
    o.breakindent = true
    o.colorcolumn = ""
    o.number = false
    o.relativenumber = false
    o.textwidth = 80
    vim.cmd "hi ZenBg guibg=NONE ctermbg=NONE"

    -- Smart j/k keymaps (buffer-local)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, unpack(opts) })
    vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, unpack(opts) })
    vim.keymap.set("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, unpack(opts) })
    vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, unpack(opts) })

    vim.g.markdown_zen_enabled = true
    vim.notify "ZenMode enabled 🎧"
  else
    -- Disable Zen Mode
    require("zen-mode").close()

    -- Reset settings
    o.wrap = false
    o.linebreak = false
    o.breakindent = false
    o.colorcolumn = "80"
    o.number = true
    o.relativenumber = true

    vim.g.markdown_zen_enabled = false
    vim.notify "ZenMode disabled 🧯"
  end
end, {})

user_command("ThemePicker", function()
  require("config.themes").themes()
end, {})
