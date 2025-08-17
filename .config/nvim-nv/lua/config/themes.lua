local fzf = require "fzf-lua"

local function reload_theme(name)
  require("chadrc").base46.theme = name
  require("base46").load_all_highlights()
end

local function theme_picker()
  local themes = require("config.utils").list_themes()
  local current_theme = require("chadrc").base46.theme
  local previewed_theme = current_theme

  if not themes or vim.tbl_isempty(themes) then
    vim.notify("No themes found!", vim.log.levels.ERROR)
    return
  end

  fzf.fzf_exec(themes, {
    prompt = "󱥚  NvChad Theme > ",
    previewer = "builtin",
    winopts = {
      height = 0.5,
      width = 0.4,
      row = 0.3,
      col = 0.5,
      border = "rounded",
      title = " Choose your theme ",
      title_pos = "center",
      preview = {
        hidden = true,
        layout = "vertical",
        vertical = "down:40%",
      },
    },

    preview_cb = function(entry)
      if entry and entry ~= previewed_theme then
        reload_theme(entry)
        previewed_theme = entry
      end
    end,

    actions = {
      ["default"] = function(selected)
        local theme = selected[1]
        if not theme then
          return
        end

        package.loaded.chadrc = nil
        local old_theme = string.format('"%s"', current_theme)
        local new_theme = string.format('"%s"', theme)
        require("config.utils").replace_word(old_theme, new_theme)
        reload_theme(theme)
      end,
    },

    cb_on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        reload_theme(current_theme)
      end
    end,

    keymap = {
      builtin = {
        ["<C-p>"] = "toggle-preview",
        ["<C-c>"] = "abort",
      },
    },
  })
end

return {
  themes = theme_picker,
}
