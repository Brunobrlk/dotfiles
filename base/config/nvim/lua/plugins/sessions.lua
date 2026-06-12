-- return {
-- 	"rmagatti/auto-session",
-- 	lazy = false,
-- 	opts = {
-- 		allowed_dirs = {
-- 			"~/Development/Python/**",
-- 			"~/Development/Projects/**",
-- 			"~/.config/nvim/",
-- 			"~/.config/lvim/",
-- 			"~/Documents/Vault/",
-- 		},
-- 		session_lens = { picker = "telescope" },
-- 		close_filetypes_on_save = { "checkhealth", "neo-tree", "codecompanion" },
-- 		post_restore_cmds = { "Neotree reveal" },
-- 	},
-- }

return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
}
