vim.g.mapleader = " "

local keymap = vim.keymap
vim.o.foldenable = true

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
keymap.set("n", "zR", require("ufo").openAllFolds)
keymap.set("n", "zM", require("ufo").closeAllFolds)
keymap.set("n", "<leader>fs", ":w<CR>")
keymap.set("n", "<leader>,<CR>", "<C-^>")
--random
-- keymap.set("n", "x", '"_x"') --copiar linea y pegarla

vim.api.nvim_set_keymap(
  "n",
  "<leader>fh",
  "vi{:! prettier --parser html --stdin-filepath<CR>vi{>",
  { noremap = true }
)
--mias
keymap.set("n", "<leader>mdl", "Vyp") --copiar linea y pegarla
keymap.set("v", "<leader>mdl", "y}p") --copiar linea y pegarla
keymap.set("n", "gnf", "]m")
keymap.set("n", "gef", "]M")
keymap.set("n", "gpf", "[m")
keymap.set("v", "gnf", "]m")
keymap.set("v", "gef", "]M")
keymap.set("v", "gpf", "[m")
--window

keymap.set("n", "<leader>wv", "<C-w>v") --split vertical
keymap.set("n", "<leader>wc", ":close<CR>") --cerrar
keymap.set("n", "<leader>ws", "<C-w>s") --split horizontal
keymap.set("n", "<leader>ww", ":MaximizerToggle<CR>") -- toggle full
keymap.set("n", "<leader>wl", "<C-w>l") -- toggle full
keymap.set("n", "<leader>wh", "<C-w>h") -- toggle full
keymap.set("n", "<leader>wj", "<C-w>j") -- toggle full
keymap.set("n", "<leader>wk", "<C-w>k") -- toggle full
keymap.set("n", "<leader>x", ":x<CR>", { silent = true }) -- toggle full

--buffer
keymap.set("n", "<leader>bk", ":bd!<CR>", { silent = true }) -- toggle full
keymap.set("n", "<leader>bq", ":q!<CR>", { silent = true }) -- toggle full

-- keymap.set("n", "<leader>,<CR>", "<C-^>")
keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true })
keymap.set("n", "<leader>bp", ":bprev<CR>", { silent = true })

--open

keymap.set("n", "<leader>op", ":NvimTreeToggle<CR>") -- toggle full
keymap.set("n", "<leader>fop", ":NvimTreeFindFile<CR>")

--telescope

--Git
keymap.set("n", "<leader>gw", "<cmd>Gwrite<Cr>") -- toggle full
keymap.set("n", "<leader>gc", "<cmd>G commit<Cr>") -- toggle full
keymap.set("n", "<leader>gt", "<cmd>diffget //2<Cr>") -- toggle full
keymap.set("n", "<leader>gy", "<cmd>diffget //3<Cr>") -- toggle full
keymap.set("n", "<leader>gv", "<cmd>Gvdiffsplit!<Cr>") -- toggle full
keymap.set("n", "<leader>gs", vim.cmd.Git)

keymap.set("n", "<esc>", ":noh<CR><esc>", { silent = true })
keymap.set("n", "<leader>wo", ":only<CR>", { silent = true })

keymap.set("t", "<esc>", [[<C-\><C-n>]])

keymap.set("n", "<C-s>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { silent = true }) -- toggle full
