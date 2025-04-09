return {
	"Mofiqul/vscode.nvim",
	config = function()
		local c = require("vscode.colors").get_colors()
		require("vscode").setup({
			-- Alternatively set style in setup
			-- style = 'light',

			-- Enable transparent background
			transparent = true,

			-- Enable italic comment
			italic_comments = true,

			-- Underline `@markup.link.*` variants
			underline_links = true,

			-- Disable nvim-tree background color
			disable_nvimtree_bg = true,

			-- Override colors (see ./lua/vscode/colors.lua)
			color_overrides = {
				-- Use the official Dark+ values:
				vscBackground = "#1e1e1e", -- Editor background
				vscForeground = "#d4d4d4", -- Editor foreground
				vscSelection = "#264f78", -- Selection background
				-- vscLineNumber = "#858585", -- Line numbers
				vscCursor = "#aeafad", -- Cursor color
				-- Accent colors (adjust these if you prefer different hues)
				vscAccentBlue = "#569cd6",
				vscAccentGreen = "#6a9955",
				vscAccentRed = "#f44747",
				vscAccentYellow = "#d7ba7d",
				vscAccentPurple = "#c586c0",
				vscAccentCyan = "#4ec9b0",
			},
			-- Additionally, override specific highlight groups so that functions,
			-- keywords, strings, etc. have exactly the same colors as in VSCode.
			group_overrides = {
				Cursor = { fg = "#1e1e1e", bg = "#aeafad", bold = true },
				Comment = { fg = "#6a9955", italic = true },
				Keyword = { fg = "#569cd6" },
				String = { fg = "#ce9178" },
				Function = { fg = "#dcdcaa" },
				Identifier = { fg = "#9cdcfe" },
				-- (Add or adjust more groups as needed.)
			},
		})
		if vim.g.colors_name == "vscode" then
			vim.cmd([[colorscheme vscode]])
		end
	end,
}
