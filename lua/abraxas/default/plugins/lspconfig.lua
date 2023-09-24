return {
  "neovim/nvim-lspconfig",
  dependencies = { "ray-x/lsp_signature.nvim", "jose-elias-alvarez/typescript.nvim" },
  config = function()
    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status then
      return
    end

    local typescript_setup, typescript = pcall(require, "typescript")
    if not typescript_setup then
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
    local lsp_signature = require("lsp_signature")
    local signature_cfg = {
      debug = false, -- set to true to enable debug logging
      log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
      -- default is  ~/.cache/nvim/lsp_signature.log
      verbose = false, -- show debug line number

      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 5, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      max_height = 2, -- max height of signature floating_window
      max_width = 80, -- max_width of signature floating_window
      noice = false, -- set to true if you using noice to render markdow
      wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap

      floating_window_off_x = 1, -- adjust float windows x position.
      floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

      close_timeout = 4000, -- close floating window after ms when laster parameter is entered
      fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = " ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      handler_opts = {
        border = "rounded", -- double, rounded, single, shadow, none
      },

      always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

      auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

      transparency = nil, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

      select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
      move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
    }
    local on_attach = function(client, bufnr)
      if client.name ~= "svelte" then
        lsp_signature.on_attach(signature_cfg, bufnr)
      end
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

      -- typescript specific keymaps (e.g. rename file and update imports)
      if client.name == "tsserver" then
        vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
        vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
        vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
      end
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

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure typescript server with plugin
    typescript.setup({
      server = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
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
      },
      init_options = {
        -- There you can set languages to be considered as different ones by tailwind lsp I guess same as includeLanguages in VSCod
        userLanguages = {
          rust = "html",
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
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre *.go lua vim.lsp.buf.format()
augroup END
]])
    -- rust

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "rustup", "run", "stable", "rust-analyzer" },
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

    -- solidity
    lspconfig["solidity"].setup({
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

    --php
    lspconfig["intelephense"].setup({
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
