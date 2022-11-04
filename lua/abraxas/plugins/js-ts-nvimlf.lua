vim.cmd([[
augroup FileTypeSpecificAutocommands
    autocmd!
autocmd FileType typescript  setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript  setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup end
    ]])
