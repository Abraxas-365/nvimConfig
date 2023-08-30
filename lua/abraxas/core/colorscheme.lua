vim.cmd("let g:gruvbox_contrast_light = 'soft'")
vim.cmd([[
augroup user_colors
  autocmd!
  autocmd ColorScheme gruvbox hi Normal ctermbg=NONE guibg=NONE
augroup END
]])

vim.cmd("colorscheme gruvbox")

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
vim.cmd [[
highlight DiagnosticError guifg=#f55037 guibg=NONE
highlight DiagnosticSignError guifg=#f55037 guibg=NONE
highlight DiagnosticFloatingError guifg=#f55037 guibg=NONE
highlight DiagnosticVirtualTextError guifg=#f55037 guibg=NONE
highlight RedrawDebugRecompose ctermbg=196 guibg=#f55037
]]
