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
]])
