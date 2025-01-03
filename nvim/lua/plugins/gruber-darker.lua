return {
	"blazkowolf/gruber-darker.nvim",
	config = function()
		require("gruber-darker").setup({
			opts = {
				bold = false,
				italic = {
					strings = false,
				},
			},
		})
		if vim.g.colors_name == "gruber-darker" then
			vim.cmd([[colorscheme gruber-darker]])
		end
	end,
}
