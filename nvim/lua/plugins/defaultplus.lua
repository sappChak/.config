return {
	"ChristianChiarulli/defaultplus",
	config = function()
		if vim.g.colors_name == "defaultplus" then
			vim.cmd([[colorscheme defaultplus]])
		end
	end,
}
