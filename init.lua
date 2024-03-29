-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require("vim-options")
require("lazy").setup("plugins")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

local function telescope_live_grep_open_files()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end
vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>se", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = "LSP: " .. desc
--     end
--     vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
--   nmap("<C-l>", vim.lsp.buf.code_action, "[C]ode [A]ction")
--
--   nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
--   nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--   nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
--   nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
--   nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
--   nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
--   vim.keymap.set("n", "gr", function()
--     require("telescope.builtin").lsp_references()
--   end, { noremap = true, silent = true })
--
--   -- See `:help K` for why this keymap
--   nmap("K", vim.lsp.buf.hover, "Hover Documentation")
--   nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
--
--   -- Lesser used LSP functionality
--   nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--   nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
--   nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
--   nmap("<leader>wl", function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, "[W]orkspace [L]ist Folders")
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
--     vim.lsp.buf.format()
--   end, { desc = "Format current buffer with LSP" })
-- end
--
-- -- document existing key chains
-- require("which-key").register({
--   ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
--   ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
--   ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
--   ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
--   ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
--   ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
--   ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
--   ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
-- })
-- -- register which-key VISUAL mode
-- -- required for visual <leader>hs (hunk stage) to work
-- require("which-key").register({
--   ["<leader>"] = { name = "VISUAL <leader>" },
--   ["<leader>h"] = { "Git [H]unk" },
-- }, { mode = "v" })
--
