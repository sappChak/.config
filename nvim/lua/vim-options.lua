-- Enable cursor line
vim.opt.cursorline = true

-- Set GUI cursor to empty
vim.opt.guicursor = ""

-- Set background to dark
vim.o.background = "dark"

-- Set global leader key to space
vim.g.mapleader = " "

-- Set local leader key to space
vim.g.maplocalleader = " "

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Set color scheme to rose-pine OR vscode OR melange OR mellifluous
-- vim.g.colors_name = "rose-pine"
vim.g.colors_name = "rose-pine"

-- Disable swap file
vim.o.swapfile = false

-- Set last status line to always display
vim.opt.laststatus = 2

-- Set local shift width to 2
vim.opt_local.shiftwidth = 2

-- Set command line height to 1
vim.opt.cmdheight = 1

-- Enable hidden buffers
vim.opt.hidden = true

-- Show matching brackets
vim.opt.showmatch = true

-- Set scroll offset to 10
vim.o.scrolloff = 10

-- Set conceal level to 1
vim.opt.conceallevel = 1

-- Enable auto indent
vim.o.autoindent = true

-- Enable smart indent
vim.o.smartindent = true

-- Set tabs to have 2 spaces
vim.o.expandtab = true

-- Disable highlight on search
vim.o.hlsearch = false

-- Enable line numbers
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable relative line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- Set clipboard to unnamedplus
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Set completeopt for better completion experience
vim.opt.completeopt = { "menuone", "noselect" }

-- Enable persistent undo history
vim.opt.undofile = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- Set case-insensitive searching unless \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Set timeout length
vim.o.timeoutlen = 300

-- Enable split below
vim.opt.splitbelow = true

-- Enable split right
vim.opt.splitright = true

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = true

-- Set maximum width of text to 80 characters
vim.opt.textwidth = 80

-- Set offset_encoding to utf-8
vim.opt.encoding = "utf-8"
