return {

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
  "wbthomason/packer.nvim",
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

  --explorer
  --icons
  "ryanoasis/vim-devicons",
  "kyazdani42/nvim-web-devicons",

  --status line

  "hrsh7th/cmp-buffer", -- source for text in buffer
  "hrsh7th/cmp-path", -- source for file system paths
  -- snippets
  "L3MON4D3/LuaSnip", -- snippet engine
  "saadparwaiz1/cmp_luasnip", -- for autocompletion
  "rafamadriz/friendly-snippets", -- useful snippets
  -- managing & installing lsp servers, linters & formatters

  -- configuring lsp servers
  "hrsh7th/cmp-nvim-lsp", -- for autocompletion
  "jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
  "onsails/lspkind.nvim", -- vs-code like icons for autocompletion

  -- formatting & linting
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
