return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		columns = {
			"icon",
			-- "permissions",
			-- "size",
			-- "mtime",
		},
		float = {
			padding = 1,
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = false,
			is_always_hidden = function(name, _)
				return name == ".. " or name == ".git"
			end,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
