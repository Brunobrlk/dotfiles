return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		local function set_markdown_emphasis_highlights()
			local red = require("catppuccin.palettes").get_palette("macchiato").red

			vim.api.nvim_set_hl(0, "htmlBold", { fg = red, bold = true })
			vim.api.nvim_set_hl(0, "htmlItalic", { fg = red, italic = true })
			vim.api.nvim_set_hl(0, "markdownBold", { fg = red, bold = true })
			vim.api.nvim_set_hl(0, "markdownItalic", { fg = red, italic = true })
		end

		require("catppuccin").setup({
			flavour = "macchiato",
			transparent_background = false,
			default_integrations = true,
			float = {
				transparent = false,
			},
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "catppuccin*",
			callback = set_markdown_emphasis_highlights,
		})

		vim.api.nvim_create_autocmd({ "FileType", "Syntax" }, {
			pattern = "markdown",
			callback = set_markdown_emphasis_highlights,
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
