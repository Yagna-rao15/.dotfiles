return {
  "3rd/image.nvim",
  dependencies = { "vhyrro/luarocks.nvim" },
  build = false,
  version = "1.1.0",
  opts = {
    processor = "magick_cli",
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        floating_windows = false, -- if true, images will be rendered in floating markdown windows
        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here

        -- resolve_image_path = function(document_path, image_path, fallback)
        --   -- document_path is the path to the file that contains the image
        --   -- image_path is the potentially relative path to the image. for
        --   -- markdown it's `![](this text)`
        --
        --   -- you can call the fallback function to get the default behavior
        --   return fallback(document_path, image_path)
        -- end,
      },
      html = {
        enabled = false,
      },
      css = {
        enabled = false,
      },
    },
    max_width = 100,
    max_height = 12,
    max_height_window_percentage = math.huge,
    max_width_window_percentage = math.huge,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,
    tmux_show_only_in_active_window = false,
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
  },
  config = function(opts)
    require("image").setup(opts)
  end,
}
