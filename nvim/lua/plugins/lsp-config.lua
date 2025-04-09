return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"folke/neodev.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy" },
		},
		config = function()
			-- require("java").setup()
			local lspconfig = require("lspconfig")
			local mason = require("mason")
			local neodev = require("neodev")

			-- Load custom keymaps
			require("user.keymaps").map_lsp_keybinds()

			neodev.setup()

			-- Setup mason
			mason.setup({ ui = { border = "rounded" } })

			-- Custom diagnostic handler to filter specific error codes
			for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
				local default_diagnostic_handler = vim.lsp.handlers[method]
				vim.lsp.handlers[method] = function(err, result, context, config)
					if err ~= nil and (err.code == -32802 or err.code == -32603) then
						return
					end
					return default_diagnostic_handler(err, result, context, config)
				end
			end

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
				html = {},
				sqlls = {},
				texlab = {},
				jsonls = {},
				volar = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enabled = false },
						},
					},
				},
				ts_ls = {
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = "/home/sappchak/.nvm/versions/node/v22.5.1/lib/node_modules/@vue/typescript-plugin",
								languages = { "javascript", "typescript", "vue" },
							},
						},
					},
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
				pyright = {},
				-- jdtls = {},
				matlab_ls = {
					cmd = { "matlab-language-server", "--stdio" },
					settings = {
						installPath = "/usr/local/MATLAB/R2024b",
					},
					filetypes = { "matlab" },
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							imports = {
								group = {
									enable = true,
								},
							},
							completion = {
								postfix = {
									enable = false,
								},
							},
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
					virtual_text = false,
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
				vim.api.nvim_create_user_command("Format", function(args)
					local range = nil
					if args.count ~= -1 then
						local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
						range = {
							start = { args.line1, 0 },
							["end"] = { args.line2, end_line:len() },
						}
					end
					require("conform").format({ async = true, lsp_format = "fallback", range = range })
				end, { range = true })
			end

			-- Setup LSP servers
			local function setup_servers()
				for name, config in pairs(servers) do
					lspconfig[name].setup({
						autostart = config.autostart,
						cmd = config.cmd,
						capabilities = capabilities,
						filetypes = config.filetypes,
						init_options = config.init_options,
						handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
						on_attach = on_attach,
						settings = config.settings,
						root_dir = config.root_dir,
					})
				end
			end

			setup_servers()

			-- Diagnostic UI configuration
			vim.diagnostic.config({ float = { border = "rounded" } })

			-- Set default border for LSP windows
			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			default_format_opts = {
				async = true,
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				lua = { "stylua" },
				python = { "black" },
				cpp = { "clang_format" },
				c = { "clang_format" },
				csharp = { "csharpier" },
				sh = { "shfmt" },
				sql = { "sqlfmt" },
				markdown = { "prettier" },
			},
		},
	},
}
