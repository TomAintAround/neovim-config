return { {
	"nvim-telescope/telescope.nvim",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				fzf = {},
			},
		})
		require("telescope").load_extension("fzf")

		vim.keymap.set("n", "<leader>ff", require("telescope.builtin").fd)
		vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics)
		vim.keymap.set("n", "<leader>fg", require("telescope.builtin").grep_string)
		vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
		vim.keymap.set("n", "<leader>gc", require("telescope.builtin").git_commits)
		vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches)
		vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status)
	end
} }
