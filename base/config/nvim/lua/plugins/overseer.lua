return {
	"stevearc/overseer.nvim",
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {
		dap = true, -- Patch nvim-dap to support preLaunchTask and postDebugTask
		output = {
			use_terminal = true, -- Use a terminal buffer to display output. If false, a normal buffer is used
			preserve_output = false, -- If true, don't clear the buffer when a task restarts
		},
		task_list = {
			direction = "bottom", -- "left", "right", or "bottom"
			-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a single value or a list of mixed integer/float types.
			max_width = { 100, 0.2 }, -- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
			min_width = { 40, 0.1 }, -- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
			max_height = { 40, 0.4 },
			min_height = 25,
			separator = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━", -- String that separates tasks
			child_indent = { "┃ ", "┣━", "┗━" }, -- Indentation for child tasks
			keymaps = {
				["<C-k>"] = false,
				["<C-j>"] = false,
			},
		},
		actions = {}, -- Custom actions for tasks. See :help overseer-actions
		-- Configure the floating window used for task templates that require input
		-- and the floating window used for editing tasks
		form = {
			zindex = 40,
			-- Dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_X and max_X can be a single value or a list of mixed integer/float types.
			min_width = 80,
			max_width = 0.9,
			min_height = 10,
			max_height = 0.9,
			border = nil,
			-- Set any window options here (e.g. winhighlight)
			win_opts = {},
		},
		-- Configuration for task floating output windows
		task_win = {
			-- How much space to leave around the floating window
			padding = 2,
			border = nil,
			-- Set any window options here (e.g. winhighlight)
			win_opts = {},
		},
	},
}
