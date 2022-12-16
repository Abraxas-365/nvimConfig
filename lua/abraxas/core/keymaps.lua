vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>fs", ":w<CR>")

--random
-- keymap.set("n", "x", '"_x"') --copiar linea y pegarla

--mias
keymap.set("n", "<leader>mdl", "Vyp") --copiar linea y pegarla
keymap.set("v", "<leader>mdl", "y}p") --copiar linea y pegarla

--window

keymap.set("n", "<leader>wv", "<C-w>v") --split vertical
keymap.set("n", "<leader>wc", ":close<CR>") --cerrar
keymap.set("n", "<leader>ws", "<C-w>s") --split horizontal
keymap.set("n", "<leader>wf", ":MaximizerToggle<CR>") -- toggle full
keymap.set("n", "<leader>wl", "<C-w>l") -- toggle full
keymap.set("n", "<leader>wh", "<C-w>h") -- toggle full
keymap.set("n", "<leader>wj", "<C-w>j") -- toggle full
keymap.set("n", "<leader>wk", "<C-w>k") -- toggle full

--buffer
keymap.set("n", "<leader>bk", ":bd!<CR>") -- toggle full
keymap.set("n", "<leader>bq", ":q!<CR>") -- toggle full

-- keymap.set("n", "<leader>,<CR>", "<C-^>")
keymap.set("n", "<leader>bn", ":bnext<CR>")
keymap.set("n", "<leader>bp", ":bprev<CR>")

--open

keymap.set("t", "<leader>ot", ":ToggleTerm size=15  direction=horizontal<CR>")
keymap.set("n", "<leader>ot", ":ToggleTerm size=15  direction=horizontal<CR>")
keymap.set("n", "<leader>op", ":NvimTreeToggle<CR>") -- toggle full

--telescope

keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<Cr>") -- toggle full
keymap.set("n", "<leader>,", "<cmd>Telescope oldfiles<Cr>") -- toggle full
keymap.set("n", "<leader>:", "<cmd>Telescope commands<Cr>") -- toggle full
keymap.set("n", "<leader>.", "<cmd>Telescope buffers<Cr>") --  buffers
keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<Cr>") -- toggle full

keymap.set("n", "<esc>", ":noh<CR><esc>")

keymap.set("t", "<esc>", [[<C-\><C-n>]])
