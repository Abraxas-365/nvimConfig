vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre *.go lua vim.lsp.buf.format()
augroup END
]])
