return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
			{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
		},
		opts = {
			debug = false, -- Enable debugging
			show_help = false, -- Show help actions
			window = {
				-- layout = "float",
				layout = "vertical",
			},
			auto_follow_cursor = false, -- Don't follow the cursor after getting response
			prompts = {
				Commit = {
					prompt = "Write commit message for the change with commitizen convention",
					selection = "gitdiff",
				},
				CommitStaged = {
					prompt = "Write commit message for the change with commitizen convention",
					selection = "gitdiff",
				},
				Swagger = {
					prompt = "Effectively document this controller with Swagger",
					selection = "visual",
				},

				Endpoint = {
					prompt = "Generate a new NestJS endpoint handler for the specified service method with Swagger specs.",
					selection = "clipboard",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			-- Use unnamed register for the selection
			opts.selection = select.unnamed

			-- Override the git prompts message
			opts.prompts.Commit = {
				prompt = "Write commit message for the change with commitizen convention",
				selection = select.gitdiff,
			}
			opts.prompts.CommitStaged = {
				prompt = "Write commit message for the change with commitizen convention",
				selection = function(source)
					return select.gitdiff(source, true)
				end,
			}

			opts.prompts.Refactor = {
				prompt = [[
I need to refactor the following code to improve its readability, maintainability, and efficiency. Please follow these best practices:

1. **Code Organization**: Ensure the code is well-structured and modular. Break down large functions into smaller, reusable functions. Group related functions together and use classes if necessary.

2. **Naming Conventions**: Use descriptive and consistent naming conventions for variables, functions, and classes. Avoid single-letter names unless they are commonly understood (e.g., `i` for loop indices).

3. **Error Handling**: Implement proper error handling using try-except blocks where appropriate. Ensure the code gracefully handles potential errors and edge cases.

4. **Performance**: Optimize any inefficient code. Avoid unnecessary computations and redundant operations. Use appropriate data structures for the task.

5. **Readability**: Ensure the code follows PEP 8 (or the relevant style guide) for formatting and indentation. Make sure the code is easy to read and understand.

Here is the original code:
]],
				selection = select.visual,
			}

			opts.prompts.Swagger = {
				prompt = "Effectively document this controller with Swagger",
				selection = select.visual,
			}

			opts.prompts.Endpoint = {
				prompt = "Generate a new NestJS endpoint handler for the specified service method with Swagger specs.",
				selection = select.clipboard,
			}

			chat.setup(opts)

			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = "*", range = true })
		end,
		event = "VeryLazy",
		keys = {
			-- Show help actions with telescope
			{
				"<leader>cch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
			-- Code related commands
			{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
			{ "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
			{ "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
			{ "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
			-- Chat with Copilot in visual mode
			{
				"<leader>ccv",
				":CopilotChatVisual",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{
				"<leader>ccx",
				":CopilotChatInline<cr>",
				mode = "x",
				desc = "CopilotChat - Inline chat",
			},
			-- Custom input for CopilotChat
			{
				"<leader>cci",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						vim.cmd("CopilotChat " .. input)
					end
				end,
				desc = "CopilotChat - Ask input",
			},
			-- Generate commit message based on the git diff
			{
				"<leader>ccm",
				"<cmd>CopilotChatCommit<cr>",
				desc = "CopilotChat - Generate commit message for all changes",
			},
			{
				"<leader>ccM",
				"<cmd>CopilotChatCommitStaged<cr>",
				desc = "CopilotChat - Generate commit message for staged changes",
			},
			-- Quick chat with Copilot
			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CopilotChatBuffer " .. input)
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			-- Debug
			{ "<leader>ccd", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
			-- Fix the issue with diagnostic
			{ "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
			-- Clear buffer and chat history
			{
				"<leader>ccl",
				"<cmd>CopilotChatReset<cr>",
				desc = "CopilotChat - Clear buffer and chat history",
			},
			-- Toggle Copilot Chat Vsplit
			{ "<leader>ccv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle Vsplit" },
		},
	},
}
