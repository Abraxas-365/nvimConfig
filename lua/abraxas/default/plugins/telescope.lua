-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {

    file_ignore_patterns = { "node_modules", "dist" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})

telescope.load_extension("fzf")

local keymap = vim.keymap
keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<Cr>") -- toggle full
keymap.set("n", "<leader>;", "<cmd>Telescope oldfiles<Cr>") -- toggle full
keymap.set("n", "<leader>:", "<cmd>Telescope commands<Cr>") -- toggle full
keymap.set("n", "<leader>.", "<cmd>Telescope buffers<Cr>") --  buffers
keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<Cr>") -- toggle full

local plenary = require("plenary.path")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local dropdown = themes.get_dropdown({
  hidden = true,
  no_ignore = true,
  previewer = false,
  prompt_title = "",
  preview_title = "",
  results_title = "",
  layout_config = { prompt_position = "top" },
})

-- File browser always relative to buffer
local opts_file_browser = vim.tbl_extend("force", dropdown, {
  path = "%:p:h",
})

-- Set current folder as prompt title
local with_title = function(opts, extra)
  extra = extra or {}
  local path = opts.cwd or opts.path or extra.cwd or extra.path or nil
  local title = ""
  local buf_path = vim.fn.expand("%:p:h")
  local cwd = vim.fn.getcwd()
  if path ~= nil and buf_path ~= cwd then
    title = plenary:new(buf_path):make_relative(cwd)
  else
    title = vim.fn.fnamemodify(cwd, ":t")
  end

  return vim.tbl_extend("force", opts, {
    prompt_title = title,
  }, extra or {})
end

vim.api.nvim_create_augroup("startup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = "startup",
  pattern = "*",
  callback = function()
    -- Open file browser if argument is a folder
    local arg = vim.api.nvim_eval("argv(0)")
    if arg and (vim.fn.isdirectory(arg) ~= 0 or arg == "") then
      vim.defer_fn(function()
        builtin.find_files(with_title(dropdown))
      end, 10)
    end
  end,
})
