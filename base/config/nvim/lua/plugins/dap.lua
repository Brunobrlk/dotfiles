return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
			config = function()
				require("dapui").setup()
			end,
		},
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		{
			"mfussenegger/nvim-dap-python",
			ft = "python",
			config = function()
				require("dap-python").setup(vim.fn.expand("~/opt/python-venvs/debugpy/bin/python"))
			end,
		},
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- UI lifecycle
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		-- Signs
		vim.fn.sign_define("DapBreakpoint", {
			text = "●",
			texthl = "DiagnosticError",
		})

		vim.fn.sign_define("DapStopped", {
			text = "▶",
			texthl = "DiagnosticWarn",
		})

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Run current file",
				program = "${file}",
			},

			-- Flask
			{
				type = "python",
				request = "launch",
				name = "Flask",
				module = "flask",
				env = {
					FLASK_APP = "app.py",
					FLASK_ENV = "development",
				},
				args = { "run" },
				justMyCode = false,
			},

			-- FastAPI (uvicorn)
			{
				type = "python",
				request = "launch",
				name = "FastAPI",
				module = "uvicorn",
				args = { "main:app", "--reload" },
				justMyCode = false,
			},
		}
	end,
}
