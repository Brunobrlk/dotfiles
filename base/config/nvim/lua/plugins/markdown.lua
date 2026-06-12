return {
	{
		"bullets-vim/bullets.vim",
		ft = "markdown",
		config = function()
			vim.g.bullets_enable_in_empty_buffers = 0
			vim.g.bullets_checkbox_markers = " ---x"
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = ":call mkdp#util#install()",
		init = function()
			vim.cmd("let g:mkdp_theme = 'light'")
			vim.cmd("let g:mkdp_auto_close = 0")
			vim.cmd("let g:mkdp_combine_preview = 1")
			vim.cmd("let g:mkdp_combine_preview_auto_refresh = 1")
			vim.cmd([[
                function OpenMarkdownPreview (url)
                    execute "silent ! brave-browser --new-window --start-fullscreen " . a:url
                endfunction
                let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]])

			vim.cmd([[let g:mkdp_preview_options = {
                \ 'mkit': {},
                \ 'katex': {},
                \ 'uml': {},
                \ 'maid': {},
                \ 'disable_sync_scroll': 0,
                \ 'sync_scroll_type': 'middle',
                \ 'hide_yaml_meta': 1,
                \ 'sequence_diagrams': {},
                \ 'flowchart_diagrams': {},
                \ 'content_editable': v:false,
                \ 'disable_filename': 1
                \ }]])
		end,
	},
}
