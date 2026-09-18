return {
	"anurag3301/nvim-platformio.lua",
	dependencies = {
		"akinsho/toggleterm.nvim",
		"folke/which-key.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cond = function()
		local cwd = vim.fn.getcwd()
		local platformio_root = vim.fs.root(cwd, { "platformio.ini" })

		if platformio_root then
			vim.g.platformioRootDir = platformio_root
			return true
		end

		local lazy_plugin_dir = vim.fn.stdpath("data") .. "/lazy/nvim-platformio.lua"
		if (vim.uv or vim.loop).fs_stat(lazy_plugin_dir) == nil then
			vim.g.platformioRootDir = cwd
			return true
		end

		return false
	end,
	config = function()
		local platformio = require("platformio")

		platformio.setup({
			lsp = "clangd",
			clangd_source = "compiledb",
			picker_backend = "telescope",
			menu_name = "PlatformIO",
            menu_bindings = {},
			debug = false,
		})
	end,
}
