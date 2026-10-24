return {
	{
		"benlubas/molten-nvim",
		enabled = true,
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_wrap_output = true
			vim.g.molten_output_win_max_height = 50
			vim.g.molten_virt_lines_off_by_1 = true

			vim.keymap.set(
				"n",
				"<leader>ii",
				":MoltenInit<CR>",
				{ desc = "start kernel", silent = true }
			)

			vim.api.nvim_create_autocmd("User", {
				pattern = "MoltenInitPost",
				callback = function()
					vim.keymap.set(
						"n",
						"<leader>io",
						":noautocmd MoltenEnterOutput<CR>",
						{ desc = "open output window", silent = true }
					)
					vim.keymap.set(
						"n",
						"<leader>ih",
						":MoltenHideOutput<CR>",
						{ desc = "close output window", silent = true }
					)
					vim.keymap.set(
						"n",
						"<leader>id",
						":MoltenDelete<CR>",
						{ desc = "delete Molten cell", silent = true }
					)
					vim.keymap.set(
						"n",
						"<leader>ix",
						":MoltenOpenInBrowser<CR>",
						{ desc = "open output in browser", silent = true }
					)
				end,
			})
		end,
	},
	{
		"3rd/image.nvim",
		enabled = true,
		opts = {
			backend = "kitty",
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{
		"GCBallesteros/jupytext.nvim",
		enabled = true,
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		},
	},
	{
		"quarto-dev/quarto-nvim",
		enabled = true,
		dependencies = { "jmbuhr/otter.nvim" },
		config = function()
			require("quarto").setup({
				lspFeatures = {
					languages = { "python" },
					chunks = "all",
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				keymap = {
					hover = "H",
					definition = "gd",
					rename = "<leader>rn",
					references = "gr",
					format = "<leader>rf",
				},
				codeRunner = {
					enabled = true,
					default_method = "molten",
				},
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MoltenInitPost",
				callback = function()
					local runner = require("quarto.runner")
					vim.keymap.set(
						"n",
						"<leader>rc",
						runner.run_cell,
						{ desc = "run cell", silent = true }
					)
					vim.keymap.set(
						"n",
						"<leader>rl",
						runner.run_line,
						{ desc = "run line", silent = true }
					)
					vim.keymap.set(
						"v",
						"<leader>r",
						runner.run_range,
						{ desc = "run visual range", silent = true }
					)
					vim.keymap.set(
						"n",
						"<leader>ra",
						runner.run_above,
						{ desc = "run cell and above", silent = true }
					)
					vim.keymap.set("n", "<leader>rA", function()
						runner.run_all(true)
					end, {
						desc = "run all cells of all languages",
						silent = true,
					})
				end,
			})
		end,
	},
}
