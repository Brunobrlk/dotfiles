return {
	"linux-cultist/venv-selector.nvim",
	ft = "python",
	opts = {
		name = { ".venv", "venv" },
		search_workspace = true,
		auto_refresh = true,
		options = {
			debug = false,
			on_telescope_result_callback = function(filename)
				-- This ensures the path is displayed nicely in Telescope
				return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
			end,
		},
	},
}
