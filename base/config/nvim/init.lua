require("keymaps")
require("options")
require("autocommands")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.ai"),
	require("plugins.bufferline"),
	require("plugins.colorscheme"),
	require("plugins.completion"),
	require("plugins.conform"),
	require("plugins.core"),
	require("plugins.dap"),
	require("plugins.flutter"),
	require("plugins.fold"),
	require("plugins.git"),
	require("plugins.illuminate"),
	require("plugins.lint"),
	require("plugins.lsp"),
	require("plugins.lualine"),
	require("plugins.markdown"),
	require("plugins.mason"),
	require("plugins.neotree"),
	require("plugins.noice"),
	require("plugins.pyvenv"),
	require("plugins.sessions"),
	require("plugins.telescope"),
	require("plugins.toggleterm"),
	require("plugins.treesitter"),
	require("plugins.whichkey"),
})
