return {
	{
		"arzg/vim-colors-xcode",
		config = function()
			if vim.g.colors_name == "xcode" then
				vim.cmd([[colorscheme xcodedarkhc]])
			end
		end,
	},
	{
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				-- dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = false,
					italic = false,
					transparency = true,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},

				highlight_groups = {
					-- Comment = { fg = "foam" },
					-- VertSplit = { fg = "muted", bg = "muted" },
				},

				before_highlight = function(group, highlight, palette)
					-- Disable all undercurls
					-- if highlight.undercurl then
					--     highlight.undercurl = false
					-- end
					--
					-- Change palette colour
					-- if highlight.fg == palette.pine then
					--     highlight.fg = palette.foam
					-- end
				end,
			})
			if vim.g.colors_name == "rose-pine" then
				vim.cmd("colorscheme rose-pine")
			end
		end,
	},
	{
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
	},
	{
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
	},
}
