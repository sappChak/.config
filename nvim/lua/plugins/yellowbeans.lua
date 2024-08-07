return {
	"gremble0/yellowbeans.nvim",
	config = function()
		if vim.g.colors_name == "yellowbeans" then
			vim.cmd("colorscheme yellowbeans")
		end
	end,
}
