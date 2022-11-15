local opt = vim.opt

opt.number = true
opt.fillchars = "eob: "

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true -- highlight the current cursor line

opt.termguicolors = true
opt.signcolumn = "yes"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

vim.cmd([[set hidden]])
vim.cmd([[set noswapfile]])
vim.cmd([[set nobackup]])
vim.cmd([[set undodir=~/.vim/undodir]])
vim.cmd([[set undofile]])
vim.cmd([[set scrolloff=15]])
opt.background = "dark"
