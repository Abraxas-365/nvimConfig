vim.cmd([[
    autocmd!
autocmd BufNewFile,BufRead *.ts  | setlocal tabstop=2
autocmd BufNewFile,BufRead *.ts  | setlocal shiftwidth=2 
autocmd BufNewFile,BufRead *.ts  | setlocal softtabstop=2
    ]])

vim.cmd([[
    autocmd!
autocmd BufNewFile,BufRead *.tsx  | setlocal tabstop=2
autocmd BufNewFile,BufRead *.tsx  | setlocal shiftwidth=2 
autocmd BufNewFile,BufRead *.tsx  | setlocal softtabstop=2
    ]])

vim.cmd([[
    autocmd!
autocmd BufNewFile,BufRead *.js  | setlocal tabstop=2
autocmd BufNewFile,BufRead *.js  | setlocal shiftwidth=2 
autocmd BufNewFile,BufRead *.js  | setlocal softtabstop=2
    ]])

vim.cmd([[
    autocmd!
autocmd BufNewFile,BufRead *.jsx  | setlocal tabstop=2
autocmd BufNewFile,BufRead *.jsx  | setlocal shiftwidth=2 
autocmd BufNewFile,BufRead *.jsx  | setlocal softtabstop=2
    ]])
