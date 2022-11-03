
-- Example config in lua
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true


-- Load the colorscheme

vim.cmd([[ 
augroup user_colors
  autocmd!
  autocmd ColorScheme nord hi Normal ctermbg=NONE guibg=NONE
augroup END
]])
local status, _ = pcall(vim.cmd, "colorscheme nord")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
