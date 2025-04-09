return {
	"blazkowolf/gruber-darker.nvim",
	config = function()
		require("gruber-darker").setup({
			bold = false,
			invert = {
				signs = false,
				tabline = false,
				visual = false,
			},
			italic = {
				strings = false,
				comments = true,
				operators = false,
				folds = true,
			},
			undercurl = false,
			underline = false,
		})
		if vim.g.colors_name == "gruber-darker" then
			vim.cmd([[colorscheme gruber-darker]])
		end
	end,
}
