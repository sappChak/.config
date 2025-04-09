return {
	"arzg/vim-colors-xcode",
	config = function()
		if vim.g.colors_name == "xcode" then
			vim.cmd([[colorscheme xcodedarkhc]])
		end
	end,
}
