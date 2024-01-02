-- Set numbers
vim.opt.nu = true

-- Use relative line numbers
vim.opt.relativenumber = true

-- 4 character tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Use the language to determine the indent level of the next line
vim.opt.smartindent = true

-- Let undotree have access to long-running undos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Don't stay highlighted after searching
vim.opt.hlsearch = false

-- Highlights as you search
vim.opt.incsearch = true

-- Use terminal colors
vim.opt.termguicolors = true

-- Always keep 8 characters as you scroll
vim.opt.scrolloff = 8

-- Show the sign column for gitsigns
vim.opt.signcolumn = "yes"

-- Fast upatetime
vim.opt.updatetime = 50

-- Show a color column at 120 characters
vim.opt.colorcolumn = "120"
