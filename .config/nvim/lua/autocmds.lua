local augroup = vim.api.nvim_create_augroup("UserConfig", {})
local autocmd = vim.api.nvim_create_autocmd
local user_command = vim.api.nvim_create_user_command

-- Highlight yanked text
autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup,
  callback = function()
    vim.highlight.on_yank { timeout = 150 }
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

-- Auto format using LSP on save
autocmd("BufWritePre", {
  pattern = "*",
  group = augroup,
  callback = function(args)
    local clients = vim.lsp.get_clients { bufnr = args.buf }
    if #clients > 0 then
      vim.lsp.buf.format { bufnr = args.buf }
    end
  end,
})

-- Create missing directories before saving files
autocmd("BufWritePre", {
  pattern = "*",
  group = augroup,
  callback = function()
    local dir = vim.fn.expand "<afile>:p:h"
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Spellcheck & wrap for writing formats
autocmd("FileType", {
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  group = augroup,
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Don't conceal JSON syntax
autocmd("FileType", {
  pattern = { "json", "jsonc", "json5" },
  group = augroup,
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Close terminal buffers on exit
autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- LSP codelens refresh
autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  group = augroup,
  callback = function()
    if vim.lsp.codelens then
      vim.lsp.codelens.refresh()
    end
  end,
})

-- Set working directory to current file
user_command("Setwd", function()
  vim.cmd("cd " .. vim.fn.expand "%:p:h")
end, {})

-- Optional Zen Mode (requires `zen-mode.nvim`)
user_command("ZenMode", function()
  local ft = vim.bo.filetype
  if ft ~= "markdown" then
    vim.notify("ZenMode is only for Markdown files ✍️", vim.log.levels.WARN)
    return
  end

  local o = vim.opt
  local bufnr = vim.api.nvim_get_current_buf()

  if not vim.g.markdown_zen_enabled then
    require("zen-mode").open()
    o.wrap = true
    o.linebreak = true
    o.breakindent = true
    o.colorcolumn = ""
    o.number = false
    o.relativenumber = false
    o.textwidth = 80

    -- gj/gk smart navigation
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, unpack(opts) })
    vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, unpack(opts) })

    vim.g.markdown_zen_enabled = true
    vim.notify "ZenMode enabled 🎧"
  else
    require("zen-mode").close()
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

-- LSP Related autocmd
autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method "textDocument/completion" then
      vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end)
    end
  end,
})
