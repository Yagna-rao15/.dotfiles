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
        local path = vim.fn.fnamemodify(bufname, ":~")
        -- local filename = vim.fn.fnamemodify(bufname, ":t")
        if path == "" then
          path = "[No Name]"
        end

        local ext = vim.fn.fnamemodify(bufname, ":e")
        local icon, icon_color = devicon.get_icon(path, ext, { default = true })

        local modified = vim.bo[props.buf].modified

        return {
          { " ", icon, " ", guifg = icon_color },
          { path, guifg = "#696969", gui = "italic" },
          modified and { " [+]", guifg = "#ff9e64" } or "",
          " ",
        }
      end,
    }
  end,
}
