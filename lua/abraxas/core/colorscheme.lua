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
