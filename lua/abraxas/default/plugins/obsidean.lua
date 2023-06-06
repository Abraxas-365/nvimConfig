local setup, obsidean = pcall(require, "obsidian")
if not setup then
  return
end

obsidean.setup({
  dir = "~/.notes", -- no need to call 'vim.fn.expand' here

  -- Optional, if you keep notes in a specific subdirectory of your vault.
  notes_subdir = "Notes",

  -- Optional, if you keep daily notes in a separate directory.

  -- Optional, completion.
  completion = {
    nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
  },
  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    vim.fn.jobstart({ "open", url }) -- Mac OS
    -- vim.fn.jobstart({"xdg-open", url})  -- linux
  end,

  note_id_func = function(title)
    return title
  end,
})

local keymap = vim.keymap

keymap.set("n", "<leader>obl", ":ObsidianBacklinks<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>otd", ":ObsidianToday<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>oyd", ":ObsidianYesterday<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>on", ":ObsidianNew ", { noremap = true, silent = false })
keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>", { noremap = true, silent = true })
keymap.set("v", "<leader>ol", ":ObsidianLink<CR>", { noremap = true, silent = true })
keymap.set("v", "<leader>oln", ":ObsidianLinkNew<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>of", ":ObsidianFollowLink<CR>", { noremap = true, silent = true })
-- keymap.set("n", "<leader>ot", ":ObsidianTemplate<CR>", { noremap = true, silent = true })
