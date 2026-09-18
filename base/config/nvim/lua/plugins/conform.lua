return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
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
				cmake = { "gersemi", "cmake_format" },
				yaml = { "prettier" },
			},
		})
	end,
}
