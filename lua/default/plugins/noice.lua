return {
	{
		"folke/noice.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			---@diagnostic disable-next-line
			require("noice").setup({
				routes = {
					{
						view = "notify",
						filter = { event = "msg_showmode" },
					},
					{
						view = "mini",
						filter = {
							event = "msg_showcmd",
							any = {
								{ find = "[mq]$" },
							},
						},
					},
				},
			})
			vim.api.nvim_create_autocmd("RecordingLeave", {
				callback = function()
					-- Display a message when macro recording stops
					print("Macro recording stopped")
				end,
			})
		end,
	},
}
