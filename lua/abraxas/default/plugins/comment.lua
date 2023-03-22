local setup, comment = pcall(require, "Comment")
if not setup then
	return
end

-- enable comment
comment.setup({
 toggler = {
     line = '<leader>mcl',
     block = '<leader>mcb',
        },

opleader = {
            line = '<leader>mcl',
        },
})

