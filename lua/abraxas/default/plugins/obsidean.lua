local keymap = vim.keymap
return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },

    -- Add any additional options below as needed
  },
  config = function(_, opts)
    local obsidian = require("obsidian")
    obsidian.setup(opts)

    -- Optional: Set key mappings
    keymap.set("n", "<leader>on", ":ObsidianNew ", { silent = true })
    keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { silent = true })
    keymap.set("n", "<leader>ow", ":ObsidianWorkspace ", { silent = true })
    keymap.set("n", "<leader>oww", ":ObsidianWorkspace work<CR>", { silent = true })
    keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { silent = true })
  end,
}
