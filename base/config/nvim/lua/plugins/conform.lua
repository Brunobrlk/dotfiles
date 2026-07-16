return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				kotlin = { "ktlint" },
				python = { "ruff" },
				sh = { "shfmt" },
				lua = { "stylua" },
				dart = { "dart_format" },
				xml = { "xmlformatter" },

				json = { "prettier" },
				markdown = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				yaml = { "prettier" },
			},
		})
	end,
}
