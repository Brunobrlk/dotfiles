local M = {}
local map = vim.keymap.set

-- ── Secrets ──────────────────────────────────────────────────────────────────

local _secrets_loaded = false

function M.load_secrets(path)
	if _secrets_loaded then
		return
	end
	path = vim.fn.expand(path or "~/.local/share/secure/env")
	local file = io.open(path, "r")
	if not file then
		vim.notify("[utils] secrets not found: " .. path, vim.log.levels.WARN)
		return
	end
	for line in file:lines() do
		if not line:match("^%s*#") and not line:match("^%s*$") then
			local key, value = line:match("^export%s+([%w_]+)=(.+)$")
			if key and value then
				value = value:match('^"(.*)"$') or value:match("^'(.*)'$") or value
				vim.env[key] = value
			end
		end
	end
	file:close()
	_secrets_loaded = true
end

-- ── Keymap helpers ───────────────────────────────────────────────────────────

local function opts(desc, extra)
	return vim.tbl_extend("force", { silent = true, desc = desc }, extra or {})
end

function M.nmap(lhs, rhs, desc, extra)
	map("n", lhs, rhs, opts(desc, extra))
end
function M.imap(lhs, rhs, desc, extra)
	map("i", lhs, rhs, opts(desc, extra))
end
function M.vmap(lhs, rhs, desc, extra)
	map("v", lhs, rhs, opts(desc, extra))
end
function M.tmap(lhs, rhs, desc, extra)
	map("t", lhs, rhs, opts(desc, extra))
end
function M.nvmap(lhs, rhs, desc, extra)
	map({ "n", "v" }, lhs, rhs, opts(desc, extra))
end


function M.opts(desc, extra)
	return vim.tbl_extend("force", { silent = true, desc = desc }, extra or {})
end

return M
