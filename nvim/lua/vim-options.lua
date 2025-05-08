-- Set global leader key to space
vim.g.mapleader = " "

-- Enable cursor line
-- Highlights the line where the cursor is located, making it easier to track the cursor's position.
vim.opt.cursorline = false

-- Set encoding to UTF-8
-- Ensures that files are read and written using UTF-8 encoding.
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Set GUI cursor to empty
-- Disables the GUI cursor, which can be useful for a consistent look across different environments.
vim.opt.guicursor = ""

-- Set background to dark
-- Optimizes colors for a dark background, improving readability and reducing eye strain.
vim.o.background = "dark"

-- Set last status line to always display
-- Ensures that the status line is always visible, providing useful information about the current file and mode.
vim.opt.laststatus = 3

-- Disable line wrapping
-- Prevents lines from wrapping, which can be useful for code readability.
vim.opt.wrap = false

-- Use spaces instead of tabs
-- Converts tabs to spaces, which is a common practice in many coding standards.
vim.opt.expandtab = true

-- Set command height to 0
-- Reduces the height of the command line area, providing more space for editing.
vim.opt.cmdheight = 0

-- Disable backup files
-- Prevents the creation of backup files, which can save disk space and reduce clutter.
vim.opt.backup = false

-- Set local leader key to space
-- Similar to the global leader key, but for local mappings within a buffer.
vim.g.maplocalleader = " "

-- Enable 24-bit color
-- Allows for a wider range of colors in the terminal, improving the appearance of the editor.
vim.opt.termguicolors = true

-- Set color scheme to vscode
vim.g.colors_name = "gruber-darker"

-- Disable swap file
-- Prevents the creation of swap files, which can save disk space and reduce clutter.
vim.o.swapfile = false

-- Set last status line to always display
-- Ensures that the status line is always visible, providing useful information about the current file and mode.
vim.opt.laststatus = 2

-- Set local shift width to 2
-- Defines the number of spaces to use for each step of (auto)indent.
vim.opt_local.shiftwidth = 2

-- Set command line height to 1
-- Increases the height of the command line area, providing more space for command input.
-- vim.opt.cmdheight = 1

-- Enable hidden buffers
-- Allows buffers to be hidden without being saved, which can improve workflow efficiency.
vim.opt.hidden = true

-- Show matching brackets
-- Highlights matching brackets when the cursor is over them, making it easier to identify code blocks.
vim.opt.showmatch = true

-- Set scroll offset to 10
-- Keeps 10 lines visible above and below the cursor, improving context visibility.
vim.o.scrolloff = 10

-- Set conceal level to 1
-- Controls the visibility of concealed text, which can be useful for certain file types.
vim.opt.conceallevel = 1

-- Enable auto indent
-- Automatically indents new lines to match the indentation of the previous line.
vim.o.autoindent = true

-- Enable smart indent
-- Makes indentation smarter, based on the syntax of the code.
vim.o.smartindent = true

-- Set tabs to have 2 spaces
-- Defines the number of spaces to use for each tab character.
vim.o.expandtab = true

-- Disable highlight on search
-- Prevents search matches from being highlighted, which can reduce visual clutter.
vim.o.hlsearch = false

-- Enable line numbers
-- Displays line numbers in the editor, which can be useful for navigation and debugging.
vim.wo.number = true

-- Enable mouse mode
-- Allows the use of the mouse for navigation and selection within the editor.
vim.o.mouse = "a"

-- Enable relative line numbers
-- Displays line numbers relative to the current line, which can be useful for navigation.
vim.opt.nu = true
vim.opt.rnu = true

-- Set clipboard to unnamedplus
-- Uses the system clipboard for all yank, delete, change, and put operations.
vim.o.clipboard = "unnamedplus"

-- Enable break indent
-- Preserves indentation of wrapped lines, making them easier to read.
vim.o.breakindent = true

-- Set completeopt for better completion experience
-- Configures the behavior of the completion menu for a better user experience.
vim.opt.completeopt = { "menuone", "noselect" }

-- Enable persistent undo history
-- Saves undo history to a file, allowing undo operations to persist across sessions.
vim.opt.undofile = true

-- Enable the sign column to prevent the screen from jumping
-- Keeps the sign column visible, preventing the screen from shifting when signs are added or removed.
vim.opt.signcolumn = "yes"

-- Set case-insensitive searching unless \C or capital in search
-- Makes searches case-insensitive unless a capital letter or \C is used in the search pattern.
vim.o.ignorecase = true
vim.o.smartcase = true

-- more useful diffs (nvim -d)
-- by ignoring whitespace
-- vim.opt.diffopt:append('iwhite')
-- and using a smarter algorithm
-- https://vimways.org/2018/the-power-of-diff/
-- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
-- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
-- vim.opt.diffopt:append('algorithm:histogram')
-- vim.opt.diffopt:append('indent-heuristic')

-- Keep signcolumn on by default
-- Ensures that the sign column is always visible, preventing the screen from shifting.
vim.wo.signcolumn = "yes"

-- Decrease update time
-- Reduces the time Vim waits before triggering the CursorHold event, improving responsiveness.
vim.o.updatetime = 300

-- Set timeout length
-- Defines the time Vim waits for a mapped sequence to complete, improving responsiveness.
vim.o.timeoutlen = 300

-- Enable split below
-- Opens new horizontal splits below the current window, improving window management.
vim.opt.splitbelow = true

-- Enable split right
-- Opens new vertical splits to the right of the current window, improving window management.
vim.opt.splitright = true

-- Don't redraw while executing macros (good performance config)
-- Prevents screen redraws while executing macros, improving performance.
vim.opt.lazyredraw = true

-- Defines the maximum width of text before wrapping, which can improve readability.
vim.opt.textwidth = 90
