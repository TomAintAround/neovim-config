return {
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup()
			vim.keymap.set(
				"n",
				"<leader>nd",
				vim.cmd.Neogen,
				{ desc = "Generate documentation" }
			)
		end,
	},
}
