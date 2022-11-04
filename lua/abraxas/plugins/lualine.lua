-- import lualine plugin safely
-- p
-- p
--
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- get lualine nightfly theme
local nord = require("lualine.themes.nord")

-- local function current_signature()
--   if not pcall(require, "lsp_signature") then
--     return
--   end
--   local sig = require("lsp_signature").status_line(80)
--   return sig.label .. "🤙"
-- end
--
-- local function hover_and_print()
--   local window, offset_encoding = 0, nil
--   local params = require("vim.lsp.util").make_position_params(window, offset_encoding)
--   local function handler(err, result, ctx, config)
--     -- see :help lsp-handler
--     if err then
--       return
--     end
--     if result ~= nil then
--       local s = vim.inspect(result.contents.value)
--       -- print(string.match(s, "'\n'.*'\n'"))
--       print(s)
--       -- local words = {}
--       -- for word in s:gmatch("\n.*\n") do
--       --   table.insert(words, word)
--       -- end
--       -- print(words[1])
--     else
--       print(" ")
--     end
--   end
--   return vim.inspect(vim.lsp.buf_request(0, "textDocument/hover", params, handler))
-- end

local custom_fname = require("lualine.components.filename"):extend()
local highlight = require("lualine.highlight")
local default_status_colors = { saved = "#8CA47D", modified = "#BC636C" }

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
    lualine_b = { "branch", "diagnostics" },
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
