return {
	{
		"rcarriga/nvim-notify",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		enabled = true,
		config = function()
			vim.notify = require("notify")
		end,
	},
}
