-- utils.root_has_file(".prettierrc")
-- utils.root_has_file(".prettierrc")
-- utils.root_has_file(".prettierrc")
return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    -- import null-ls plugin safely
    local setup, null_ls = pcall(require, "null-ls")
    if not setup then
      return
    end

    vim.diagnostic.config({
      virtual_text = false,
      underline = false, -- add this line to remove underlines
    })
    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- configure null_ls
    null_ls.setup({
      -- setup formatters & linters
      sources = {
        formatting.prettier.with({
          condition = function(utils)
            return
              -- utils.root_has_file(".prettierrc")
              utils.root_has_file(".prettierrc.js")
                or utils.root_has_file("prettier.config.js")
                or utils.root_has_file(".prettierrc.json")
                or utils.root_has_file(".prettierrc.yaml")
                or utils.root_has_file(".prettierrc.yml")
                or utils.root_has_file(".prettierrc.toml")
            -- or utils.root_has_file("package.json")
          end,
          filetypes = {
            "html",
            "json",
            "svelte",
            "markdown",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        }),

        -- null_ls.builtins.diagnostics.xo.with({
        --   command = "./node_modules/.bin/xo",
        -- }),
        -- null_ls.builtins.code_actions.xo,

        formatting.phpcsfixer.with({ exta_args = { "--rules", "@Symfony" } }), --php foter
        formatting.stylua, -- lua formatter
        diagnostics.flake8,
        null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "80" } }),
        diagnostics.eslint_d.with({ -- js/ts linter
          -- only enable eslint if root has .eslintrc.js
          condition = function(utils)
            return utils.root_has_file(".eslintrc.js")
          end,
        }),
      },
      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end,
}
