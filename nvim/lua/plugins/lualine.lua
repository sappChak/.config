return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			blue = "#80a0ff",
			cyan = "#79dac8",
			black = "#080808",
			white = "#c6c6c6",
			red = "#ff5189",
			violet = "#d183e8",
			green = "#a9b665",
			grey = "#303030",
		}

		local my_theme = {
			normal = {
				a = { fg = colors.white, bg = "NONE" },
				b = { fg = colors.white, bg = "NONE" },
				c = { fg = colors.white },
			},

			insert = { a = { fg = colors.green, bg = "NONE" } },
			visual = { a = { fg = colors.cyan, bg = "NONE" } },
			replace = { a = { fg = colors.red, bg = "NONE" } },

			inactive = {
				a = { fg = colors.white, bg = "NONE" },
				b = { fg = colors.white, bg = "NONE" },
				c = { fg = colors.white, bg = "NONE" },
			},
		}

		require("lualine").setup({
			options = {
				theme = my_theme,
				component_separators = "|",
				-- section_separators = { "", "" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
