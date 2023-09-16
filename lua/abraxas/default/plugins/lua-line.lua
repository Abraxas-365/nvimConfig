return {

  "nvim-lualine/lualine.nvim",
  config = function()
    -- import lualine plugin safely
    -- p
    -- p
    --
    local status, lualine = pcall(require, "lualine")
    if not status then
      return
    end

    -- get lualine nightfly theme
    local nord = require("lualine.themes.gruvbox")

    local custom_fname = require("lualine.components.filename"):extend()
    local highlight = require("lualine.highlight")
    local default_status_colors = { saved = "#92BE82", modified = "#F45037" }

    function custom_fname:init(options)
      custom_fname.super.init(self, options)
      self.status_colors = {
        saved = highlight.create_component_highlight_group(
          { fg = default_status_colors.saved },
          "filename_status_saved",
          self.options
        ),
        modified = highlight.create_component_highlight_group(
          { fg = default_status_colors.modified },
          "filename_status_modified",
          self.options
        ),
      }
      if self.options.color == nil then
        self.options.color = ""
      end
    end

    function custom_fname:update_status()
      local data = custom_fname.super.update_status(self)
      data = highlight.component_format_highlight(
        vim.bo.modified and self.status_colors.modified or self.status_colors.saved
      ) .. data
      return data
    end

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        icons_enabled = true,
        theme = nord,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diagnostics",
        },
        lualine_c = { { custom_fname, path = 1 } },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
