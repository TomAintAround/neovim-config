return {
	{
		"mfussenegger/nvim-dap",
		enabled = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			---@diagnostic disable-next-line: missing-fields
			require("nvim-dap-virtual-text").setup({
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if
						name:match("secret")
						or name:match("api")
						or value:match("secret")
						or value:match("api")
					then
						return "*****"
					end

					if #variable.value > 15 then
						return " "
							.. string.sub(variable.value, 1, 15)
							.. "... "
					end

					return " " .. variable.value
				end,
			})
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dap.adapters = {
				cppdbg = {
					id = "cppdbg",
					type = "executable",
					command = vim.fn.getenv("XDG_STATE_HOME")
						.. "/nvim/debuggers/OpenDebugAD7",
				},
				["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = {
							vim.fn.getenv("XDG_STATE_HOME")
								.. "/nvim/debuggers/dapDebugServer.js",
							"${port}",
						},
					},
				},
			}
			dap.configurations = {
				c = {
					{
						name = "Launch file",
						type = "cppdbg",
						request = "launch",
						program = function()
							return vim.fn.input(
								"Path to executable: ",
								vim.fn.getcwd() .. "/",
								"file"
							)
						end,
						cwd = "${workspaceFolder}",
						stopAtEntry = true,
					},
					{
						name = "Attach to gdbserver :1234",
						type = "cppdbg",
						request = "launch",
						MIMode = "gdb",
						miDebuggerServerAddress = "localhost:1234",
						miDebuggerPath = vim.fn.exepath("gdb"),
						cwd = "${workspaceFolder}",
						program = function()
							return vim.fn.input(
								"Path to executable: ",
								vim.fn.getcwd() .. "/",
								"file"
							)
						end,
					},
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.rust = dap.configurations.c
			local jsBasedLanguages = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			}
			for _, language in pairs(jsBasedLanguages) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
					},
				}
			end
			require("dap-python").setup()

			vim.keymap.set("n", "<F5>", function()
				require("dap").restart()
			end, { desc = "Restart debugger" })
			vim.keymap.set("n", "<F6>", function()
				require("dap").continue()
			end, { desc = "Start/continue debugger" })
			vim.keymap.set("n", "<F7>", function()
				require("dap").terminate()
			end, { desc = "Stop debugger" })
			vim.keymap.set("n", "<F9>", function()
				require("dap").step_over()
			end, { desc = "Step over in debugger" })
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_back()
			end, { desc = "Step back in debugger" })
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end, { desc = "Step into in debugger" })
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end, { desc = "Step out in debugger" })
			vim.keymap.set("n", "<Leader>db", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").set_breakpoint(
					nil,
					nil,
					vim.fn.input("Log point message: ")
				)
			end, { desc = "Set breakpoint with message" })
		end,
	},
}
