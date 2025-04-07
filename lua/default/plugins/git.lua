return {
	{
		"trevorhauter/gitportal.nvim",
		enabled = true,
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>gp", require("gitportal").open_file_in_browser)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		enabled = true,
		config = function()
			require("gitsigns").setup({
				numhl = false,
			})

			vim.keymap.set("n", "<leader>gl", require("gitsigns").blame)
			vim.keymap.set("n", "<leader>gll", require("gitsigns").blame_line)
			vim.keymap.set("n", "<leader>ghh", require("gitsigns").setqflist)
			vim.keymap.set("n", "<leader>ghr", require("gitsigns").reset_hunk)
			vim.keymap.set("n", "<leader>ghp", require("gitsigns").preview_hunk_inline)
		end,
	},
}
