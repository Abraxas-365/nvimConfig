local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd
au("TextYankPost", {
  group = ag("yank_highlight", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})

-- Customize the color of LSP error signs in the gutter
vim.cmd([[
highlight DiagnosticError guifg=#f55037 guibg=NONE
highlight DiagnosticSignError guifg=#f55037 guibg=NONE
highlight DiagnosticFloatingError guifg=#f55037 guibg=NONE
highlight DiagnosticVirtualTextError guifg=#f55037 guibg=NONE
highlight RedrawDebugRecompose ctermbg=196 guibg=#f55037
highlight NvimInternalError guifg=#f55037 guibg=NONE
highlight lualine_b_diagnostics_error_normal guifg=#f55037
highlight lualine_b_diagnostics_error_insert guifg=#f55037 guibg=#504945
highlight lualine_b_diagnostics_error_visual  guifg=#f55037 guibg=#504945
highlight lualine_b_diagnostics_error_replace guifg=#f55037 guibg=#504945
highlight lualine_b_diagnostics_error_command guifg=#f55037 guibg=#504945
highlight lualine_b_diagnostics_error_terminal guifg=#f55037 guibg=#504945
highlight lualine_b_diagnostics_error_inactive guifg=#f55037 guibg=#3c3836
highlight markdownH1 guifg=#fb4934
highlight markdownH2 guifg=#fabd2f
highlight markdownH3 guifg=#b8bb26
highlight markdownH4 guifg=#83a598
highlight markdownH5 guifg=#d3869b
highlight markdownH6 guifg=#8ec07c
]])

local function setLightSolarized()
  -- Set the background to light
  vim.opt.background = "light"
  -- Set the colorscheme to solarized
  vim.cmd("colorscheme solarized")
end
_G.setLightSolarized = setLightSolarized

vim.api.nvim_set_keymap(
  "n",
  "<leader>ml",
  ":lua setLightSolarized()<CR>",
  { noremap = true, silent = true }
)
