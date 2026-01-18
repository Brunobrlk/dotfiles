-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true   -- LunarVim default

-- Cursor & scrolling
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Wrapping
vim.opt.wrap = false
vim.opt.linebreak = true

-- Mouse
vim.opt.mouse = "a"

-- Colors
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Identation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Undo/Backup
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.redrawtime = 1500

-- cmp
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- whitespace format
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

vim.opt.confirm = true         -- confirm before closing unsaved buffers
vim.opt.hidden = true          -- allow background buffers
vim.opt.cmdheight = 1
vim.opt.showmode = false       -- statusline handles it
vim.opt.showcmd = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
