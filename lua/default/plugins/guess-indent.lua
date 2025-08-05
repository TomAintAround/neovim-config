return {
	{
		"NMAC427/guess-indent.nvim",
		enabled = true,
		config = function()
			local guessIndent = require("guess-indent")
			guessIndent.setup({})
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
				group = vim.api.nvim_create_augroup("Indent", { clear = true }),
				callback = function()
					guessIndent.set_from_buffer()
				end,
			})
		end,
	},
}
