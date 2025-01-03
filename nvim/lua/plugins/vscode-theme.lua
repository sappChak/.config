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
				-- vscLineNumber = "#FFFFFF",
				-- vscBlue = "#FFFFFF",
				-- vscAccentBlue = "#FFFFFF",
			},
			-- Override highlight groups (see ./lua/vscode/theme.lua)
			group_overrides = {
				Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
			},
		})
		if vim.g.colors_name == "vscode" then
			vim.cmd([[colorscheme vscode]])
		end
	end,
}
