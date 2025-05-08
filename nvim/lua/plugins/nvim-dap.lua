return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}
		dap.configurations.c = {
			{
				name = "Launch C debugger",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		-- C++
		dap.configurations.cpp = dap.configurations.c

		-- Rust
		dap.configurations.rust = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					-- Prompt the user to input the path to the executable with default path set to target/debug
					local default_path = vim.fn.getcwd() .. "/target/debug/"
					local executable_path = vim.fn.input("Path to executable: ", default_path, "file")
					return executable_path
				end,
				cwd = "${workspaceFolder}", -- Current working directory (optional)
				stopOnEntry = false, -- Set to true to break at entry point
				args = function()
					-- Prompt for arguments
					local input = vim.fn.input("Program arguments: ")
					return vim.split(input, " ") -- Split arguments by space
				end,
				-- Additional options for the codelldb adapter
				setupCommands = {
					{
						text = "-exec-file",
						description = "Set up executable",
						ignoreFailures = false,
					},
				},
				runInTerminal = true, -- Optional: Run in integrated terminal for better input/output handling
			},
		}

		vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>")
		-- Use F5 to start the debugger
		vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').continue()<CR>")
		-- Use F10 to step over
		vim.keymap.set("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>")
		vim.keymap.set("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>")
		vim.keymap.set("n", "<F12>", "<cmd>lua require('dap').step_out()<CR>")
		vim.keymap.set("n", "<F9>", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
		vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>")
		vim.keymap.set("n", "<F2>", "<cmd>lua require('dap').close(); require('dapui').close()<CR>")
		-- vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
	end,
}
