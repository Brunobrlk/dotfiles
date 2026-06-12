return {
	"tpope/vim-repeat",
	"numToStr/Comment.nvim",
	{ "nvim-mini/mini.bufremove", version = "*" },
	{ "kylechui/nvim-surround", version = "^4.0.0", event = "VeryLazy" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{
		"nvim-mini/mini.move",
		opts = {
			mappings = { -- Disable: Handle inside keymaps.lua
				left = "",
				right = "",
				down = "",
				up = "",
				line_left = "",
				line_right = "",
				line_down = "",
				line_up = "",
			},
		},
	},
	{
		"lambdalisue/suda.vim", -- Read/Write files with sudo
		lazy = false,
		init = function()
			vim.g.suda_smart_edit = 1
			vim.g["suda#noninteractive"] = 1
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏",
			},
			whitespace = {
				remove_blankline_trail = false,
			},
			scope = {
				enabled = false,
			},
			-- exclude = { filetypes = { "help", "terminal", "markdown", "TelescopePrompt", "whichkey", "lspinfo", "Trouble", "Outline",
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
	},
}
