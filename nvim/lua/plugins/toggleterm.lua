return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		direction = "float",
		-- size = 30,
		open_mapping = [[<c-\>]],
		config = function()
			require("config.toggleterm").config()
		end,
	},
}
