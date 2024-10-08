return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"nvimtools/none-ls.nvim",
			"folke/neodev.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy" },
		},
		config = function()
			require("java").setup()
			local null_ls = require("null-ls")
			local lspconfig = require("lspconfig")
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local neodev = require("neodev")

			-- Load custom keymaps
			require("user.keymaps").map_lsp_keybinds()

			-- Setup neodev before lspconfig
			neodev.setup()

			-- Setup mason
			mason.setup({ ui = { border = "rounded" } })

			-- Auto install LSP servers
			mason_lspconfig.setup({ automatic_installation = { exclude = { "gleam" } } })

			lspconfig.matlab_ls.setup({
				cmd = { "matlab-language-server", "--stdio" },
				settings = {
					installPath = "/usr/local/MATLAB/R2024b",
				},
				filetypes = { "matlab" },
				root_dir = function(fname)
					-- Look for a `.git` folder or a specific MATLAB-related file/folder as the project root
					local util = require("lspconfig/util")
					return util.find_git_ancestor(fname)
						or util.path.dirname(fname) -- Current file directory
						or vim.loop.os_homedir() -- Fallback to the home directory
				end,
			})

			-- Diagnostics filtering for tsserver
			local function filter_tsserver_diagnostics(_, result, ctx, config)
				local ignored_messages = {
					"'_Assertion' is declared but never used.",
					"'__Assertion' is declared but never used.",
					"The signature '(data: string): string' of 'atob' is deprecated.",
					"The signature '(data: string): string' of 'btoa' is deprecated.",
				}
				result.diagnostics = vim.tbl_filter(function(diagnostic)
					return not vim.tbl_contains(ignored_messages, diagnostic.message)
				end, result.diagnostics)
				vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
			end

			-- LSP server configurations
			local servers = {
				bashls = {},
				clangd = { cmd = { "clangd", "--offset-encoding=utf-16" } },
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enabled = false },
						},
					},
				},
				ts_ls = {
					settings = {
						maxTsServerMemory = 12288,
						typescript = {
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayEnumMemberValueHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							},
						},
					},
					handlers = {
						["textDocument/publishDiagnostics"] = vim.lsp.with(filter_tsserver_diagnostics, {}),
					},
				},
				jdtls = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							procMacro = { enable = true },
							cargo = { allFeatures = true },
							imports = { group = { enable = false } },
							completion = { postfix = { enable = false } },
						},
					},
				},
				dockerls = {},
				docker_compose_language_service = { filetypes = { "yaml.docker-compose" } },
			}

			-- LSP handlers configuration
			local default_handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
				["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = true,
					signs = true,
					underline = false,
				}),
			}

			-- Setup capabilities with nvim-cmp
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Common on_attach function
			local function on_attach(_, buffer_number)
				-- Map LSP keybinds
				require("user.keymaps").map_lsp_keybinds(buffer_number)

				-- Create `:Format` command for formatting the current buffer
				vim.api.nvim_buf_create_user_command(buffer_number, "Format", function()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name ~= "ts_ls" or not null_ls.is_registered("prettier")
						end,
					})
				end, { desc = "LSP: Format current buffer with LSP" })
			end

			-- Setup LSP servers
			local function setup_servers()
				for name, config in pairs(servers) do
					lspconfig[name].setup({
						capabilities = capabilities,
						filetypes = config.filetypes,
						handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
						on_attach = on_attach,
						settings = config.settings,
					})
				end
			end

			setup_servers()

			-- require("lspconfig").jdtls.setup({})

			-- Configure null-ls for linting, formatting, diagnostics, and code actions
			null_ls.setup({
				border = "rounded",
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.csharpier,
				},
			})

			-- Diagnostic UI configuration
			vim.diagnostic.config({ float = { border = "rounded" } })

			-- Set default border for LSP windows
			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},
}
