return {
  "neovim/nvim-lspconfig",
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
      -- if client.name ~= "svelte" then
      --   lsp_signature.on_attach(signature_cfg, bufnr)
      -- end
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
      vim.keymap.set("i", "<C-b>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- show documentation for what is under cursor
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

    -- Define highlight group for hover window
    -- Define highlight group for hover window
    vim.cmd([[
      " highlight MyHoverWindow guibg=#1e222a guifg=#ffffff
      highlight FloatBorder guibg=#1e222a guifg=#ffffff
    ]])

    -- Apply the highlight group to the hover window
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
      winhighlight = "FloatBorder:FloatBorder",
    })
    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "templ" },
    })

    -- configure typescript server with plugin
    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.cmd([[
augroup FileTypeSpecificAutocommands
    autocmd!
autocmd FileType typescript  setlocal tabstop=2 shiftwidth=2 softtabstop=2
" autocmd FileType typescriptreact  setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript  setlocal tabstop=2 shiftwidth=2 softtabstop=2
" autocmd FileType javascriptreact  setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType svelte  setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup end
    ]])

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure tailwindcss server
    require("lspconfig").tailwindcss.setup({
      capabilities = Capabilities,
      -- There add every filetype you want tailwind to work on
      filetypes = {
        "css",
        "scss",
        "sass",
        "postcss",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "vue",
        "rust",
        "templ",
      },
      init_options = {
        -- There you can set languages to be considered as different ones by tailwind lsp I guess same as includeLanguages in VSCod
        userLanguages = {
          rust = "html",
          templ = "html",
        },
      },
      -- Here If any of files from list will exist tailwind lsp will activate.
      root_dir = require("lspconfig").util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.ts",
        "windi.config.ts"
      ),
    })

    -- golang
    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.cmd([[
augroup GoFormatAutogroup
  autocmd!
  autocmd BufWritePre *.go lua vim.lsp.buf.format()
augroup END
]])

    lspconfig.htmx.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "html", "templ" },
    })

    lspconfig["templ"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.api.nvim_create_autocmd(
      { "BufWritePre" },
      { pattern = { "*.templ" }, callback = vim.lsp.buf.format }
    )

    vim.cmd([[
augroup TemplFormatAutogroup
  autocmd!
  autocmd BufWritePre *.templ lua vim.lsp.buf.format()
augroup END
]])

    -- rust

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "rustup", "run", "stable", "rust-analyzer" },
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
    })

    vim.cmd([[
augroup RustFormatAutogroup
  autocmd!
  autocmd BufWritePre *.rs lua vim.lsp.buf.format()
augroup END
]])

    -- py
    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    --svelte
    lspconfig["svelte"].setup({
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

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      -- cmd = { "clangd", "--std=c++11" },
    })

    vim.cmd([[
augroup CFormatAutogroup
  autocmd!
  autocmd BufWritePre *.cpp lua vim.lsp.buf.format()
augroup END
]])

    --perl
    lspconfig.perlnavigator.setup({
      cmd = { "perlnavigator", "--stdio" }, -- Ensure this path is correct
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.cmd([[
augroup CFormatAutogroup
  autocmd!
  autocmd BufWritePre *.pl lua vim.lsp.buf.format()
augroup END
]])

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
