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
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
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
				program = function() -- Ask the user what executable wants to debug
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
				initCommands = function() -- add rust types support (optional)
					-- Find out where to look for the pretty printer Python module
					local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

					local script_import = 'command script import "'
					    .. rustc_sysroot
					    .. '/lib/rustlib/etc/lldb_lookup.py"'
					local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

					local commands = {}
					local file = io.open(commands_file, "r")
					if file then
						for line in file:lines() do
							table.insert(commands, line)
						end
						file:close()
					end
					table.insert(commands, 1, script_import)

					return commands
				end,
			},
		}
		-- dap.adapters["pwa-node"] = {
		-- 	type = "server",
		-- 	host = "127.0.0.1",
		-- 	port = 8123,
		-- 	executable = {
		-- 		command = "js-debug-adapter",
		-- 	},
		-- }
		-- dap.configurations.typescript = {
		-- 	{
		-- 		type = "pwa-node",
		-- 		request = "launch",
		-- 		name = "Launch file",
		-- 		program = "${file}",
		-- 		cwd = "${workspaceFolder}",
		-- 		runtimeExecutable = "node",
		-- 	},
		-- 	{
		-- 		type = "pwa-node",
		-- 		request = "attach",
		-- 		name = "Attach",
		-- 		processId = require("dap.utils").pick_process,
		-- 		cwd = vim.fn.getcwd(),
		-- 		sourceMaps = true,
		-- 	},
		-- }

		vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>")
		-- vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
		-- vim.keymap.set("n", "<leader>dn", "<cmd>lua require('dap').step_over()<CR>")
		-- vim.keymap.set("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>")
		-- vim.keymap.set("n", "<leader>do", "<cmd>lua require('dap').step_out()<CR>")
		-- vim.keymap.set("n", "<leader>dl", "<cmd>lua require('dap').repl.open()<CR>")
		-- vim.keymap.set("n", "<leader>ds", "<cmd>lua require('dap').stop()<CR>")
		-- Use F5 to start the debugger
		vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').continue()<CR>")
		-- Use F10 to step over
		vim.keymap.set("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>")
		vim.keymap.set("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>")
		vim.keymap.set("n", "<F12>", "<cmd>lua require('dap').step_out()<CR>")
		vim.keymap.set("n", "<F9>", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
		vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>")
		vim.keymap.set("n", "<F2>", "<cmd>lua require('dap').close(); require('dapui').close()<CR>")
	end,
}
