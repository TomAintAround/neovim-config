return {
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"b0o/schemastore.nvim",
				ft = "json",
			},
			"mfussenegger/nvim-jdtls",
			"stevearc/conform.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			local languages = {
				{
					extensions = { "ino" },
					lsp = "arduino_language_server",
					lspExec = "arduino-language-server",
				},
				{
					extensions = { "python" },
					lsp = "basedpyright",
					lspExec = "basedpyright",
					lspSettings = {
						settings = {
							basedpyright = {
								analysis = {
									typeCheckingMode = "standard",
								},
							},
						},
					},
					formatters = { "black" },
				},
				{
					extensions = { "bash", "sh" },
					lsp = "bashls",
					lspExec = "bash-language-server",
				},
				{
					extensions = { "c", "h", "cpp", "hpp" },
					lsp = "clangd",
					lspExec = "clangd",
				},
				{
					extensions = { "cmake" },
					lsp = "cmake",
					lspExec = "cmake-language-server",
					formatters = { "cmake-format" },
				},
				{
					extensions = { "css", "scss" },
					lsp = "cssls",
					lspExec = "vscode-css-language-server",
					formatters = { "prettierd" },
				},
				{
					extensions = { "fish" },
					lsp = "fish_lsp",
					lspExec = "fish-lsp",
				},
				{
					extensions = { "html" },
					lsp = "html",
					lspExec = "vscode-html-language-server",
					formatters = { "prettierd" },
				},
				{
					extensions = {
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
					},
					lsp = "eslint",
					lspExec = "vscode-eslint-language-server",
					formatters = { "prettierd" },
				},
				{
					extensions = { "java" },
					lsp = "jdtls",
					lspExec = "jdtls",
					lspSettings = {
						init_options = {
							bundles = {
								vim.fn.getenv("XDG_STATE_HOME")
									.. "/home-manager/modules/neovim/debuggers/com.microsoft.java.debug.plugin.jar",
							},
						},
					},
				},
				{
					extensions = { "json" },
					lsp = "jsonls",
					lspExec = "vscode-json-language-server",
					lspSettings = {
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					},
					formatters = { "jq" },
				},
				{
					extensions = { "lua" },
					lsp = "lua_ls",
					lspExec = "lua-language-server",
					formatters = { "stylua" },
				},
				{
					extensions = { "markdown" },
					lsp = "marksman",
					lspExec = "marksman",
				},
				{
					extensions = { "nix" },
					lsp = "nixd",
					lspExec = "nixd",
					lspSettings = {
						settings = {
							nixpkgs = {
								expr = "import (builtins.getFlake \"/etc/nixos\").inputs.nixpkgs { }",
							},
							options = {
								nixos = {
									expr = {
										"(builtins.getFlake \"/etc/nixos\").nixosConfigurations.tomm@desktop.options",
										"(builtins.getFlake \"/etc/nixos\").nixosConfigurations.tomm@laptop.options",
									},
								},
								home_manager = {
									expr = {
										"(builtins.getFlake \"$XDG_CONFIG_HOME/home-manager\").homeConfigurations.tomm@desktop.options",
										"(builtins.getFlake \"$XDG_CONFIG_HOME/home-manager\").homeConfigurations.tomm@laptop.options",
									},
								},
							},
						},
					},
					formatters = { "alejandra" },
				},
				{
					extensions = { "toml" },
					lsp = "taplo",
					lspExec = "taplo",
				},
				{
					extensions = { "xml" },
					lsp = "lemminx",
					lspExec = "lemminx",
					formatters = { "xmllint" },
				},
				{
					extensions = { "yaml", "yml" },
					lsp = "yamlls",
					lspExec = "yaml-language-server",
					formatters = { "prettierd" },
				},
			}

			for _, language in pairs(languages) do
				if vim.fn.executable(language.lspExec) == 1 then
					vim.lsp.config(language.lsp, language.lspSettings or {})
					vim.lsp.enable(language.lsp)
				end
			end

			local conformSetup = {
				formatters_by_ft = {},
				default_format_opts = {
					lsp_format = "fallback",
				},
				format_on_save = {
					lsp_format = "fallback",
					timeout_ms = 500,
				},
				format_after_save = {
					lsp_format = "fallback",
				},
				log_level = vim.log.levels.ERROR,
				notify_on_error = true,
				notify_no_formatters = true,
			}
			for _, language in pairs(languages) do
				for _, extension in pairs(language.extensions) do
					conformSetup.formatters_by_ft[extension] = language.formatters
						or {}
				end
			end
			require("conform").setup(conformSetup)

			require("fidget").setup({})
		end,
	},
}
