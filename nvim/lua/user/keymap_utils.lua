-- Module M
local M = {}

-- Function to bind keys with options
-- @param op: operation mode
-- @param outer_opts: options for the operation mode
local function bind(op, outer_opts)
	-- Extend the outer_opts with default values
	outer_opts = vim.tbl_extend("force", { noremap = true, silent = true }, outer_opts or {})

	-- Return a function that binds a key to an action
	return function(lhs, rhs, opts)
		-- Extend the opts with outer_opts
		opts = vim.tbl_extend("force", outer_opts, opts or {})
		-- Set the keymap
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

-- Map a key to an action
M.map = bind("")
-- Map a key to an action in normal mode without remapping
M.nmap = bind("n", { noremap = false })
-- Map a key to an action in normal mode with remapping
M.nnoremap = bind("n")
-- Map a key to an action in visual mode with remapping
M.vnoremap = bind("v")
-- Map a key to an action in select mode with remapping
M.xnoremap = bind("x")
-- Map a key to an action in insert mode with remapping
M.inoremap = bind("i")
-- Map a key to an action in terminal mode with remapping
M.tnoremap = bind("t")

-- Return the module
return M
