return {

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "soft",
        palette_overrides = {},
        overrides = {
          ["@variable"] = { fg = "#83A598" }, -- Treesitter variable group
          Identifier = { fg = "#83A598" }, -- General identifier group
          Variable = { fg = "#83A598" }, -- Specific variable group
        },
        dim_inactive = false,
        transparent_mode = true,
      })

      vim.cmd("colorscheme gruvbox")
    end,
  },

  {
    "maxmx03/solarized.nvim",
    priority = 1000,
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
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
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

  {
    "dhruvasagar/vim-table-mode",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
          -- Enable Table Mode
          vim.cmd("TableModeEnable")
        end,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ft = { "html", "svelte" },
    opts = {},
    config = function()
      require("ibl").setup({})
    end,
  },

  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
  },
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI" },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI" },
    dependencies = {
      "tpope/vim-dadbod",
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
      },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
    end,
  },
}
