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
			padding = 2,
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
			is_always_hidden = function(name, _)
				return name == ".. " or name == ".git"
			end,
		},
		timeout = {
			create = 500,
			delete = 500,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
