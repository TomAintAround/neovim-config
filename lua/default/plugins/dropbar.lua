return {{
	'Bekaboo/dropbar.nvim',
	enabled = true,
	dependencies = {
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make'
	},
	config = function()
		local dropbar_api = require('dropbar.api')
		vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
	end
}}
