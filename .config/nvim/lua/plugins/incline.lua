return {
  "b0o/incline.nvim",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local devicon = require "nvim-web-devicons"
    local incline = require "incline"

    incline.setup {
      hide = {
        only_win = false,
      },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local ext = vim.fn.fnamemodify(bufname, ":e")

        -- If unnamed buffer
        if bufname == "" then
          local icon, icon_color = devicon.get_icon("txt", "txt", { default = true })
          return {
            { " ", icon, " ", guifg = icon_color },
            { "[No Name]", guifg = "#888888", gui = "italic" },
            " ",
          }
        end

        -- Otherwise, show grandparent/parent/filename
        local parts = vim.split(bufname, "/")
        local filename = parts[#parts] or ""
        local parent = parts[#parts - 1] or ""
        local grandparent = parts[#parts - 2] or ""

        local short_path = string.format("%s/%s", grandparent, parent)
        local icon, icon_color = devicon.get_icon(filename, ext, { default = true })
        local modified = vim.bo[props.buf].modified

        return {
          { " ", icon, " ", guifg = icon_color },
          { short_path .. "/" .. filename, guifg = "#aaaaaa", gui = "italic" },
          modified and { " [+]", guifg = "#ff9e64" } or "",
          " ",
        }
      end,
    }
  end,
}
