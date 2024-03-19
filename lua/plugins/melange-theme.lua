return {
	"savq/melange-nvim",
	event = "VeryLazy",
	config = function()
		if vim.g.colors_name == "melange" then
			vim.cmd([[colorscheme melange]])
		end
	end,
}
