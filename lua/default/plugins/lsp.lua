return {{
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {{ path = "${3rd}/luv/library", words = { "vim%.uv" } }},
			},
		},
		{
			"b0o/schemastore.nvim",
			ft = "json",
		},
	},
	enabled = true,
	config = function()
		local languages = {
			{
				name = "arduino_language_server",
				lsp = "arduino-language-server",
				settings = {},
			},
			{
				name = "basedpyright",
				lsp = "basedpyright",
				settings = {},
			},
			{
				name = "bashls",
				lsp = "bash-language-server",
				settings = {},
			},
			{
				name = "clangd",
				lsp = "clangd",
				settings = {},
			},
			{
				name = "cssls",
				lsp = "vscode-css-language-server",
				settings = {},
			},
			{
				name = "fish_lsp",
				lsp = "fish-lsp",
				settings = {},
			},
			{
				name = "html",
				lsp = "vscode-html-language-server",
				settings = {},
			},
			{
				name = "jsonls",
				lsp = "vscode-json-language-server",
				settings = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
			},
			{
				name = "lua_ls",
				lsp = "lua-language-server",
				settings = {},
			},
			{
				name = "marksman",
				lsp = "marksman",
				settings = {},
			},
			{
				name = "nixd",
				lsp = "nixd",
				settings = {},
			},
			{
				name = "taplo",
				lsp = "taplo",
				settings = {},
			},
			{
				name = "yamlls",
				lsp = "yaml-language-server",
				settings = {},
			},
		}

		for _, language in pairs(languages) do
			if vim.fn.executable(language.lsp) == 1 then
				require("lspconfig")[language.name].setup(language.settings)
			end
		end
	end,
}}
