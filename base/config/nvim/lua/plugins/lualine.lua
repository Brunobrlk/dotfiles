return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{ dir = "~/Development/projects/lualine-components.nvim" },
	},
	config = function()
		local avd = require("linecomp.avd")
		local companion = require("linecomp.codecompanion")
        local dev =  require("linecomp.dev")
        local companion_spinner =  require("linecomp.codecompanion_spinner")

		require("lualine").setup({
			options = {
				theme = "auto",
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_last_status = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{ dev.dev_indicator, color = { fg = "#000000", bg = "#A6E3A1", gui = "bold" } },
					"mode",
				},
				lualine_b = { "branch" },
				lualine_c = {
					"diff",
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
					"filetype",
					{
						function()
							local fidget = require("fidget.notification")
							local items = fidget.poll_notifications("fidget")
							if items and #items > 0 then
								return items[1].message
							end
							return ""
						end,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_x = {
					"searchcount",
					avd.android_model,
					"venv-selector",
					"encoding",
					{
						"lsp_status",
						icon = "",
						symbols = {
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							done = "✓",
							separator = " ",
						},
						ignore_lsp = {},
						show_name = true,
					},
				},
				lualine_z = { "progress", "location" },
				lualine_y = { companion_spinner, companion.codecompanion_tokens, companion.codecompanion_model },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
