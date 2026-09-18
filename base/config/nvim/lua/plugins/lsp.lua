return {
	"neovim/nvim-lspconfig",
	dependencies = { "b0o/schemastore.nvim", "saghen/blink.cmp" },
	config = function()
		vim.diagnostic.config({ -- See :help vim.diagnostic.Opts
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				priority = 5,
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			} or {},
			virtual_text = {
				severity = { min = vim.diagnostic.severity.ERROR },
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--query-driver=/home/brunobrlk/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20260121/xtensa-esp-elf/bin/xtensa-esp32s3-elf-g++",
				"--background-index",
			},
		})

		vim.lsp.enable({
			"clangd",
			"neocmake",
			"jdtls",
			"kotlin_language_server",
			-- "kotlin_lsp",
			"groovyls",
			"vimls",
			"jsonls",
			"yamlls",
			"lua_ls",
			"bashls",
			"pyright",
		})
	end,
}
