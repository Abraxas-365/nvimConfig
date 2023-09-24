return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- dependency for better sorting performance
  config = function()
    local telescope_setup, telescope = pcall(require, "telescope")
    if not telescope_setup then
      return
    end

    -- import telescope actions safely
    local actions_setup, actions = pcall(require, "telescope.actions")
    if not actions_setup then
      return
    end
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = true,
        },
      },
    })

    -- configure telescope
    telescope.setup({

      pickers = {

        current_buffer_tags = { fname_width = 100 },

        jumplist = { fname_width = 100 },

        loclist = { fname_width = 100 },

        lsp_definitions = { fname_width = 100 },

        lsp_document_symbols = { fname_width = 100 },

        lsp_dynamic_workspace_symbols = { fname_width = 100 },

        lsp_implementations = { fname_width = 100 },

        lsp_incoming_calls = { fname_width = 100 },

        lsp_outgoing_calls = { fname_width = 100 },

        lsp_references = { fname_width = 100 },

        lsp_type_definitions = { fname_width = 100 },

        lsp_workspace_symbols = { fname_width = 100 },

        quickfix = { fname_width = 100 },

        tags = { fname_width = 100 },
      },
      -- configure custom mappings
      defaults = {

        file_ignore_patterns = { "node_modules", "dist", "static" },
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

    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_cursor({
            hidden = true,
            no_ignore = true,
            previewer = false,
            prompt_title = "",
            preview_title = "",
            results_title = "",
            layout_config = { prompt_position = "top" },
          }),
        },
      },
    })

    require("telescope").setup({
      extensions = {
        quicknote = {
          defaultScope = "CWD",
        },
      },
    })

    require("telescope").load_extension("quicknote")
    keymap.set("n", "<leader>nsw", "<cmd>Telescope quicknote<Cr>") -- toggle full
    keymap.set("n", "<leader>nsg", "<cmd>Telescope quicknote scope=Global<Cr>") -- toggle full
    keymap.set("n", "<leader>nsf", "<cmd>Telescope quicknote scope=CurrentBuffer<Cr>") -- toggle full
    require("telescope").load_extension("ui-select")
  end,
}
