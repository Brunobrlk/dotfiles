require("utils").load_secrets("~/.local/share/secure/ai-keys")

local ghost_completion_provider = "supermaven" -- supermaven | copilot | windsurf
local agent_chat_provider = "codecompanion" -- codecompanion | avante | parrot

return {
	require("plugins.ai.completion." .. ghost_completion_provider),
	require("plugins.ai.agent." .. agent_chat_provider),
}
