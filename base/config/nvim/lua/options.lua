local opt = vim.opt
local g = vim.g

-- General
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.fileencoding = "utf-8" -- File encoding
opt.backspace = "indent,eol,start" -- Allow backspace over anything
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- UI Options
opt.conceallevel = 2 -- Hide special characters (e.g., Markdown formatting)
opt.laststatus = 3 -- Always show the status line (nvim-lualine)
opt.pumheight = 10 -- Completion pop-up menu height

-- Folding
opt.foldnestmax = 1 -- Maximum nesting of folds

-- Search
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Incremental search

-- Performance
opt.loadplugins = true
opt.display = "lastline"

opt.number = true -- Show line numbers
opt.relativenumber = false -- Show relative line numbers
opt.cursorline = true -- Highlight current line
opt.scrolloff = 8 -- Lines above/below cursor to keep visible
opt.sidescrolloff = 8 -- Columns left/right of cursor to keep visible

-- Wrapping
opt.wrap = true -- Wrap long lines
opt.linebreak = true

-- Mouse
opt.mouse = "a"

-- Colors
g.have_nerd_font = true
opt.termguicolors = true
opt.signcolumn = "yes" -- Always show the sign column (for LSP, gitigns, etc.)

-- Clipboard
opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- Identation
opt.tabstop = 4 -- A tab character consumes 4 spaces
opt.shiftwidth = 4 -- Amount of space to indent in (e.g., for autoindent, <<, >>)
opt.expandtab = true -- Use spaces instead of tabs
opt.softtabstop = 4
opt.smartindent = false -- Smart indent
opt.autoindent = true -- Auto indent new lines

-- Searching
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive search if uppercase letters are used

-- Splits
opt.splitbelow = true -- New splits open below current window
opt.splitright = true -- New vertical splits open to the right

-- Undo/Backup
opt.undofile = true -- Enable persistent undo
opt.swapfile = false -- Don't use swapfiles
opt.backup = false
opt.writebackup = false

-- Performance
opt.updatetime = 250 -- Faster completion (ms to wait for cursor hold)
opt.timeoutlen = 400 -- Duration for key sequence to complete
opt.redrawtime = 1500

-- cmp
opt.completeopt = { "menu", "menuone", "noselect" }

-- whitespace format
opt.list = true
opt.listchars = {
	tab = "»·",
	trail = "·",
	extends = "→",
	precedes = "←",
	nbsp = "␣",
}

opt.confirm = true -- confirm before closing unsaved buffers
opt.hidden = true -- Allow unsaved buffers to be hidden
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don't show -- INSERT -- etc. in the command line. statusline handles it
opt.showcmd = false
