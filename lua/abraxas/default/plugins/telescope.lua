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

    require("telescope").load_extension("ui-select")
  end,
}
