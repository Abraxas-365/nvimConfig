return {

  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("gruvbox").setup({
  --       terminal_colors = true, -- add neovim terminal colors
  --       undercurl = true,
  --       underline = true,
  --       bold = true,
  --       italic = {
  --         strings = true,
  --         emphasis = true,
  --         comments = true,
  --         operators = false,
  --         folds = true,
  --       },
  --       strikethrough = true,
  --       invert_selection = false,
  --       invert_signs = false,
  --       invert_tabline = false,
  --       invert_intend_guides = false,
  --       inverse = true, -- invert background for search, diffs, statuslines and errors
  --       contrast = "soft", -- can be "hard", "soft" or empty string
  --       palette_overrides = {},
  --       overrides = {},
  --       dim_inactive = false,
  --       transparent_mode = false,
  --     })
  --
  --     vim.o.background = "dark" -- or "light" for light mode
  --     vim.cmd([[colorscheme gruvbox]])
  --     vim.cmd("colorscheme gruvbox")
  --   end,
  -- },
  {
    "morhetz/gruvbox",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd("let g:gruvbox_contrast_light = 'soft'")
      vim.cmd([[
augroup user_colors
  autocmd!
  autocmd ColorScheme gruvbox hi Normal ctermbg=NONE guibg=NONE
augroup END
]])

      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    config = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-c>",
        ["Find Subword Under"] = "<C-c>",
      }
    end,
  },
  "nvim-lua/plenary.nvim",

  "nvim-telescope/telescope-ui-select.nvim",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
  },

  "szw/vim-maximizer",

  --wrap with simbol
  "tpope/vim-surround",
  -- comments
  {
    "numToStr/Comment.nvim",
    config = function()
      local setup, comment = pcall(require, "Comment")
      if not setup then
        return
      end

      -- enable comment
      comment.setup({
        toggler = {
          line = "<leader>mcl",
          block = "<leader>mcb",
        },

        opleader = {
          line = "<leader>mcl",
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-tree/nvim-tree.lua" },
  },

  "ryanoasis/vim-devicons",
  "kyazdani42/nvim-web-devicons",

  {
    "RutaTang/quicknote.nvim",
    config = function()
      require("quicknote").setup({
        mode = "portable", -- "portable" | "resident", default to "portable"
        sign = "N", -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
        -- You can change it to whatever you want (eg. some nerd fonts icon), 'N' is default
        filetype = "md",
        git_branch_recognizable = true, -- If true, quicknote will separate notes by git branch
        -- But it should only be used with resident mode,  it has not effect used with portable mode
      })
      local keymap = vim.keymap
      keymap.set("n", "<leader>nl", "<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<Cr>")
      keymap.set("n", "<leader>ng", "<cmd>:lua require('quicknote').NewNoteAtGlobal()<Cr>")
      keymap.set("n", "<leader>nw", "<cmd>:lua require('quicknote').NewNoteAtCWD()<Cr>")
      keymap.set("n", "<leader>nol", "<cmd>:lua require('quicknote').OpenNoteAtCurrentLine()<Cr>")
      keymap.set("n", "<leader>nog", "<cmd>:lua require('quicknote').OpenNoteAtGlobal()<Cr>")
      keymap.set("n", "<leader>now", "<cmd>:lua require('quicknote').OpenNoteAtCWD()<Cr>")
      keymap.set("n", "<leader>ndl", "<cmd>:lua require('quicknote').DeleteNoteAtCurrentLine()<Cr>")
      keymap.set("n", "<leader>ndg", "<cmd>:lua require('quicknote').DeleteNoteAtGlobal()<Cr>")
      keymap.set("n", "<leader>ndw", "<cmd>:lua require('quicknote').DeleteNoteAtCWD()<Cr>")
      keymap.set("n", "<leader>nt", "<cmd>:lua require('quicknote').ToggleNoteSigns()<Cr>")
      keymap.set(
        "n",
        "<leader>nsa",
        "<cmd>:lua require('quicknote').ListNotesForAFileOrWDInCWD()<Cr>"
      )
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      -- import gitsigns plugin safely
      local setup, gitsigns = pcall(require, "gitsigns")
      if not setup then
        return
      end

      -- configure/enable gitsigns
      gitsigns.setup()
    end,
  }, -- show line modifications on left hand side
  "tpope/vim-fugitive", -- show line modifications on left hand side

  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
}
