return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"ravitemer/mcphub.nvim",
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "codecompanion" } },
	},
	opts = { -- defaults: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
		adapters = {
			http = {
				opts = { show_presets = false },
				gemini = function() -- Model-dependent
					return require("codecompanion.adapters").extend("gemini", {
						env = { api_key = "GEMINI_API_KEY" },
						schema = {
							model = { default = "gemini-3-flash-preview" },
						},
					})
				end,
				ollama_remote = function() -- GPU time/week (No specific value)
					return require("codecompanion.adapters").extend("ollama", {
						env = {
							url = "https://ollama.com",
							api_key = "OLLAMA_API_KEY",
						},
						headers = { ["Authorization"] = "Bearer ${api_key}" },
						schema = {
							model = { default = "glm-5" },
						},
					})
				end,
				ollama_local = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = {
								default = "gemma4-custom:latest",
								choices = {
									"gemma4-custom:latest",
									"phi3:mini",
								},
							},
						},
					})
				end,
				ollama_remote_code = function()
					return require("codecompanion.adapters").extend("ollama", {
						env = {
							url = "https://ollama.com",
							api_key = "OLLAMA_API_KEY_CODE",
						},
						headers = { ["Authorization"] = "Bearer ${api_key}" },
						schema = {
							model = { default = "minimax-m2.7" }, -- glm-5, kimi2.5, MiniMaxM2.7(Faster, yet precise)
						},
					})
				end,
				openrouter = function() -- 50 reqs/day
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = "OPENROUTER_API_KEY",
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "minimax/minimax-m2.5:free",
								choices = {
									"google/gemma-4-31b-it:free",
									"minimax/minimax-m2.5:free",
									"qwen/qwen3-coder:free",
									"openai/gpt-oss-120b:free",
									"z-ai/glm-4.5-air:free",
									"nvidia/nemotron-3-super-120b-a12b:free",
									"stepfun/step-3.5-flash:free",
									"qwen/qwen3.6-plus-preview:free",
								},
							},
						},
					})
				end,
				groq = function() -- Model-dependent, reqs/day and tokens/day
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://api.groq.com/openai",
							api_key = "GROQ_API_KEY",
							chat_url = "/v1/chat/completions",
							models_endpoint = "/v1/models",
						},
						schema = {
							model = { default = "llama-3.3-70b-versatile" }, -- 1k/100k reqs,tokens/day
						},
					})
				end,
				mistral = function()
					return require("codecompanion.adapters").extend("mistral", {
						env = {
							url = "https://api.mistral.ai",
							api_key = "MISTRAL_API_KEY",
						},
						schema = {
							model = { default = "mistral-large-latest" },
						},
					})
				end,
			},
			acp = {
				opts = { show_presets = false },
				gemini_cli = function()
					return require("codecompanion.adapters").extend("gemini_cli", {})
				end,
				codex = function()
					return require("codecompanion.adapters").extend("codex", {})
				end,
				opencode = function()
					return require("codecompanion.adapters").extend("opencode", {})
				end,
			},
		},
		interactions = { -- same as strategies(old)
			chat = {
				adapter = "ollama_remote",
				editor_context = {
					["buffer"] = {
						opts = {
							default_params = "diff",
						},
					},
				},
				tools = {
					["mcp"] = {
						callback = function()
							return require("mcphub.extensions.codecompanion")
						end,
						description = "Call MCP tools (filesystem, LSP, GitHub, web)",
						opts = { requires_approval = true },
					},
				},
			},
			inline = { adapter = "ollama_remote_code" },
			cmd = { adapter = "gemini" },
			cli = {
				agent = "opencode",
				agents = {
					codex = { cmd = "codex" },
					opencode = { cmd = "opencode" },
					gemini = { cmd = "gemini" },
				},
			},
		},
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_tools = true,
					make_vars = true,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
		display = {
			chat = {
				show_token_count = true,
				show_tools_processing = true,
				start_in_insert_mode = false,
				intro_message = "CodeCompanion: ask, edit, execute | ? help | /prompts | #context | @tools ",
				window = {
					width = 0.4,
				},
			},
			cli = {
				window = {
					layout = "vertical",
					width = 0.3,
				},
			},
			diff = {
				enabled = true,
				threshold_for_chat = 6, -- At or below this diff size, always display the diff in the chat buffer
				word_highlights = {
					additions = true,
					deletions = true,
				},
			},
		},
	},
}
