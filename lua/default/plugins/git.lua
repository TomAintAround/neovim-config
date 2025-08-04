return {
	{
		"trevorhauter/gitportal.nvim",
		enabled = true,
		config = function()
			vim.keymap.set(
				{ "n", "v" },
				"gp",
				require("gitportal").open_file_in_browser,
				{ desc = "Open text selected in Github" }
			)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		enabled = true,
		config = function()
			require("gitsigns").setup({
				numhl = false,
			})

			vim.keymap.set(
				"n",
				"gl",
				require("gitsigns").blame,
				{ desc = "Open git blame panel" }
			)
			vim.keymap.set(
				"n",
				"gll",
				require("gitsigns").blame_line,
				{ desc = "See git blame inline" }
			)
			vim.keymap.set(
				"n",
				"ghh",
				require("gitsigns").setqflist,
				{ desc = "See all git hunks in QuickFix" }
			)
			vim.keymap.set(
				"n",
				"ghr",
				require("gitsigns").reset_hunk,
				{ desc = "Reset hunk" }
			)
			vim.keymap.set(
				"n",
				"ghp",
				require("gitsigns").preview_hunk_inline,
				{ desc = "Preview changes made in hunk" }
			)
		end,
	},
}
