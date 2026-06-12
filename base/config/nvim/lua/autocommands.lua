-- local vault = vim.fn.expand("~/Documents/Vault")

-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	callback = function(args)
-- 		if vim.bo.buftype == "terminal" then
-- 			local optl = vim.opt_local
--
-- 			optl.number = false
-- 			optl.relativenumber = false
-- 			optl.signcolumn = "no"
-- 			optl.winfixwidth = true
-- 			return
-- 		end
-- 		local cwd = vim.fs.normalize(vim.fn.getcwd())
--
-- 		if cwd:find(vault, 1, true) == 1 then
-- 			vim.fn.jobstart({ "rclone", "sync", "google-drive:notes", vault, "--update" }, { detach = true })
-- 		end
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("VimLeavePre", {
-- 	callback = function()
-- 		local cwd = vim.fs.normalize(vim.fn.getcwd())
--
-- 		if cwd:find(vault, 1, true) == 1 then
-- 			vim.fn.jobstart(
-- 				{ "rclone", "sync", vault, "google-drive:notes", "--update" },
-- 				{ detach = false }
-- 			)
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		local bufnr = event.buf
		require("keymaps").setup_lsp_keymaps(bufnr, client)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(event)
		require("keymaps").setup_language_keymaps(event.buf)

		if event.match == "codecompanion" then
			local optl = vim.opt_local

			optl.number = false
			optl.relativenumber = false
			optl.signcolumn = "no"
			optl.winfixwidth = true
		end
	end,
})

vim.api.nvim_create_user_command("DiagInfo", function()
	vim.diagnostic.open_float({
		source = true,
	})
end, {})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.schedule(function()
			if vim.fn.argc() == 0 then
				require("persistence").load()
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceLoadPost",
	callback = function()
		require("neo-tree.command").execute({
			action = "show",
			source = "filesystem",
			position = "left",
			reveal = true,
			reveal_force_cwd = true, -- change cwd without asking if needed
		})
	end,
})
