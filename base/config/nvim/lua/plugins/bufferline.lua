return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			mode = "buffers",
			separator_style = { "│", "│" },
			always_show_bufferline = true,
			show_buffer_close_icons = true,
			max_name_length = 30,
			max_prefix_length = 30,
			tab_size = 20,
			show_close_icon = true,
			color_icons = true,
			diagnostics = "nvim_lsp",
			persist_buffer_sort = false,
			minimum_padding = 1,
			maximum_padding = 3,
			maximum_length = 15,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Explorer",
					text_align = "center",
					separator = true,
				},
			},
			highlights = {
				buffer_selected = {
					bold = true,
					italic = false,
				},
			},
		},
	},
}
