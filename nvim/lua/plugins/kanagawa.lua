return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = true, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors) -- add/modify highlights
				return {
					SignColumn = { bg = "NONE" },
					LineNr = { bg = "NONE" },
					GitSignsAdd = { bg = "NONE" }, -- Git signs for added lines
					GitSignsChange = { bg = "NONE" }, -- Git signs for changed lines
					GitSignsDelete = { bg = "NONE" }, -- Git signs for deleted lines
					DiagnosticSignWarn = { bg = "NONE" }, -- Warning signs
					DiagnosticSignError = { bg = "NONE" }, -- Error signs
					DiagnosticSignInfo = { bg = "NONE" }, -- Info signs
					DiagnosticSignHint = { bg = "NONE" }, -- Hint signs
				}
			end,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})

		-- setup must be called before loading
		if vim.g.colors_name == "kanagawa" then
			vim.cmd("colorscheme kanagawa")
		end
	end,
}
