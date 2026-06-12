return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			ignore_filetypes = { "TelescopePrompt", "oil", "lua", "help", "markdown", "text", "codecompanion" },
			color = { suggestion_color = "#6c7086" }, -- muted ghost text (catppuccin mocha surface2)
		})
	end,
}
