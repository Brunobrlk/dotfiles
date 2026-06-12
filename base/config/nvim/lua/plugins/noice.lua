return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				timeout = 3000,
				render = "compact",
				stages = "fade_in_slide_out",
				top_down = false,
			},
		},
	},
	opts = {
		-- Views: popup, split, vsplit, notify, virtualtext, mini, notify_send, cmdline, cmdline_popup, cmdline_output, messages, hover, popupmenu
		presets = {
			long_message_to_split = true, -- long messages will be sent to a split
			lsp_doc_border = true, -- adds border to hover/signature
		},
		messages = {
			enabled = true,
			view = "notify",
			view_error = "notify",
			view_warn = "notify",
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		lsp = {
			override = { -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
			progress = {
				enabled = true,
			},
			hover = {
				enabled = true,
				view = nil, -- uses default popup
			},
			signature = {
				enabled = true, -- ❗ disable if using blink or lsp_signature
			},
			message = {
				enabled = true,
			},
		},
		views = {
			cmdline_popup = {
				position = {
					row = 5,
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = 8,
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
				},
			},
		},
	},
}
