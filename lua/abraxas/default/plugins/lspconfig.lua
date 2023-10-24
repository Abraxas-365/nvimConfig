return {
  "neovim/nvim-lspconfig",
  dependencies = { "ray-x/lsp_signature.nvim", "jose-elias-alvarez/typescript.nvim" },
  config = function()
    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status then
      return
    end

    local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not cmp_nvim_lsp_status then
      return
    end
    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      -- keybind options
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- set keybinds
      vim.keymap.set("n", "<leader>dd", "<Cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show definition, references
      vim.keymap.set(
        "n",
        "<leader>dD",
        "<Cmd>Telescope diagnostics<CR>",
        { noremap = true, silent = true }
      ) -- show definition, references
      -- keymap.set("n", "gD", "<cmd>Telescope lsp_references theme=cursor<CR>", opts) -- show definition, references
      vim.keymap.set("n", "gD", ":lua require'telescope.builtin'.lsp_references()<CR>", opts) -- show definition, references
      vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
      vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      vim.keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- show  diagnostics for line
      vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts) -- show documentation for what is under cursor
      vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      vim.keymap.set("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

      -- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
    end

    local signs = { Warn = "", Hint = "", Error = "", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Configure diagnostics display
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        signs = true,
        update_in_insert = true,
        virtual_text = false, -- Disable virtual text
      })

    -- py
    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    --yaml
    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        yaml = {
          keyOrdering = false,
        },
      },
    })

    --json
    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      fd,
      on_attach = on_attach,
    })

    --docker
    lspconfig["dockerls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
} -- easily configure language servers
