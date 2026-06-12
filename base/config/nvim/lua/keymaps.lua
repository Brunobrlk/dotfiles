vim.g.mapleader = " "
vim.g.maplocalleader = " "

local utils = require("utils")

local map = vim.keymap.set
local nmap = utils.nmap
local imap = utils.imap
local vmap = utils.vmap
local tmap = utils.tmap
local nvmap = utils.nvmap
local opts = utils.opts

-- ======================
-- General
-- ======================
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- Disable space, it's leader
imap("jk", "<ESC>", "Exit Insert Mode")

nmap("<leader>e", "<cmd>Neotree toggle<cr>", "Explorer")
nmap("<leader>h", "<cmd>nohlsearch<CR>", "No highlight")
nmap("<leader>q", "<cmd>quit<cr>", "Quit")
nmap("<leader>Q", "<cmd>quitall<cr>", "Quit all")
nmap("<leader>w", "<cmd>w<cr>", "Save")
local function reveal_current_file_in_neotree()
	local current_buf = vim.api.nvim_get_current_buf()
	local buftype = vim.bo[current_buf].buftype
	local filepath = vim.api.nvim_buf_get_name(current_buf)

	if buftype ~= "" or filepath == "" then
		return
	end

	local ok, command = pcall(require, "neo-tree.command")
	if not ok then
		return
	end

	command.execute({
		action = "focus",
		source = "filesystem",
		position = "left",
		reveal_file = filepath,
		focus = true,
	})
end

nmap("<C-A-l>", reveal_current_file_in_neotree, "Reveal current file in Neo-tree")

nmap("<leader>/", "gcc", "Toggle comment", { remap = true })
vmap("<leader>/", "gc", "Toggle comment", { remap = true })

-- Move
nmap("<M-j>", function()
	require("mini.move").move_line("down")
end)
nmap("<M-k>", function()
	require("mini.move").move_line("up")
end)

vmap("<M-j>", function()
	require("mini.move").move_selection("down")
end)
vmap("<M-k>", function()
	require("mini.move").move_selection("up")
end)

-- TmuxNavigator
nmap("<C-h>", "<cmd>TmuxNavigateLeft<CR>", "Window left")
nmap("<C-j>", "<cmd>TmuxNavigateDown<CR>", "Window down")
nmap("<C-k>", "<cmd>TmuxNavigateUp<CR>", "Window up")
nmap("<C-l>", "<cmd>TmuxNavigateRight<CR>", "Window right")

-- ToggleTerm
nmap("<M-1>", "<cmd>1ToggleTerm direction=horizontal<CR>", "Terminal 1 (horizontal)")
tmap("<M-1>", [[<C-\><C-n><cmd>1ToggleTerm direction=horizontal<CR>]], "Terminal 1 (horizontal)")

nmap("<M-2>", "<cmd>2ToggleTerm direction=vertical<CR>", "Terminal 2 (vertical)")
tmap("<M-2>", [[<C-\><C-n><cmd>2ToggleTerm direction=vertical<CR>]], "Terminal 2 (vertical)")

nmap("<M-3>", "<cmd>3ToggleTerm direction=float<CR>", "Terminal 3 (float)")
tmap("<M-3>", [[<C-\><C-n><cmd>3ToggleTerm direction=float<CR>]], "Terminal 3 (float)")

tmap("<C-h>", [[<C-\><C-n><cmd>TmuxNavigateLeft<CR>]], "Window left")
tmap("<C-j>", [[<C-\><C-n><cmd>TmuxNavigateDown<CR>]], "Window down")
tmap("<C-k>", [[<C-\><C-n><cmd>TmuxNavigateUp<CR>]], "Window up")
tmap("<C-l>", [[<C-\><C-n><cmd>TmuxNavigateRight<CR>]], "Window right")

-- ======================
-- [A]I
-- ======================
nmap("<leader>aa", "<cmd>CodeCompanionActions<cr>", "Actions")
nmap("<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", "Chat")
nmap("<leader>ao", function()
	local opencode = require("toggleterm.terminal").Terminal:new({ cmd = "opencode", direction = "vertical" })
	opencode:toggle()
end, "OpenCode")
nmap("<leader>at", "<cmd>CodeCompanionCLI<cr>", "Terminal")

nvmap("<leader>ai", "<cmd>CodeCompanion<cr>", "Inline")

vmap("<leader>ab", "<cmd>CodeCompanionChat Add<cr>", "Add buffer selection to Chat")
vmap("<leader>ae", "<cmd>CodeCompanionChat /explain<cr>", "Explain")
vmap("<leader>af", "<cmd>CodeCompanionChat /fix<cr>", "Fix")

-- ======================
-- [B]uffer Actions
-- ======================
nmap("<leader>bf", function()
	require("conform").format({ async = true })
end, "Format (Conform)")
nmap("<leader>bh", "<cmd>BufferLineCloseLeft<CR>", "Close Left")
nmap("<leader>bl", "<cmd>BufferLineCloseRight<CR>", "Close Right")

nmap("<M-l>", "<cmd>BufferLineCycleNext<CR>", "Next Buffer")
nmap("<M-h>", "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer")
nmap("<M-x>", function()
	require("mini.bufremove").delete(0, false)
end, "Close buffer")

nmap("<leader>c", function()
	require("mini.bufremove").delete(0, false)
end, "Close buffer")

-- ======================
-- [C]olorscheme
-- ======================
vim.keymap.set("n", "<leader>Ct", function()
	local c = require("catppuccin")
	c.options.transparent_background = not c.options.transparent_background
	c.compile()
	vim.cmd("colorscheme catppuccin")
end, { desc = "Toggle Transparency" })

-- ======================
-- [G]itsigns
-- ======================
nmap(
	"]c",
	"<cmd>lua if vim.wo.diff then vim.cmd.normal({']c', bang = true}) else require('gitsigns').nav_hunk('next') end<CR>",
	"Next Hunk"
)
nmap(
	"[c",
	"<cmd>lua if vim.wo.diff then vim.cmd.normal({'[c', bang = true}) else require('gitsigns').nav_hunk('prev') end<CR>",
	"Prev Hunk"
)

nmap("<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", "Reset Hunk")

vmap("<leader>gs", "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>", "Stage Hunk")
vmap("<leader>gr", "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>", "Reset Hunk")

nmap("<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<CR>", "Stage Buffer")
nmap("<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<CR>", "Reset Buffer")
nmap("<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", "Preview Hunk")
nmap("<leader>gi", "<cmd>lua require('gitsigns').preview_hunk_inline()<CR>", "Preview Inline Hunk")

nmap("<leader>gb", "<cmd>lua require('gitsigns').blame_line({ full = true })<CR>", "Blame Line")

nmap("<leader>gd", "<cmd>lua require('gitsigns').diffthis()<CR>", "Diff This")
nmap("<leader>gD", "<cmd>lua require('gitsigns').diffthis('~')<CR>", "Diff ~")

nmap("<leader>gQ", "<cmd>lua require('gitsigns').setqflist('all')<CR>", "Quickfix (All)")
nmap("<leader>gq", "<cmd>lua require('gitsigns').setqflist()<CR>", "Quickfix")

-- Toggles
nmap("<leader>gB", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", "Toggle Blame")
nmap("<leader>gw", "<cmd>lua require('gitsigns').toggle_word_diff()<CR>", "Toggle Word Diff")

-- Text object
map({ "o", "x" }, "gh", "<cmd>lua require('gitsigns').select_hunk()<CR>", opts("Select Hunk"))

-- ======================
-- [L]azy
-- ======================
nmap("<leader>Lu", "<cmd>Lazy update<cr>", "Update")
nmap("<leader>Ls", "<cmd>Lazy sync<cr>", "Sync")
nmap("<leader>Lh", "<cmd>Lazy home<cr>", "Home")
nmap("<leader>Ll", "<cmd>Lazy log<cr>", "Log")
nmap("<leader>Lp", "<cmd>Lazy profile<cr>", "Profile")
nmap("<leader>Lr", "<cmd>Lazy restore<cr>", "Restore")

-- ======================
-- [M]arkdown
-- ======================
local markdown_mappings = function()
	nmap("<leader>mp", "<cmd>MarkdownPreview<cr>", "Preview")
	nmap("<leader>ms", "<cmd>MarkdownPreviewStop<cr>", "Stop Preview")
	nmap("<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", "Toggle Preview")
	nmap("<leader>ms", function()
	    vim.notify("Syncing markdown notes...")
		vim.fn.jobstart({ "rclone", "sync", vim.fn.expand("~/Documents/Vault"), "google-drive:notes", "--update" }, { detach = true })
	end, "Sync Notes")
end

-- ======================
-- [N]oice
-- ======================
nmap("<leader>na", "<cmd>NoiceAll<cr>", "All Messages")
nmap("<leader>nn", "<cmd>NoiceLast<cr>", "Last Message")
nmap("<leader>nd", "<cmd>NoiceDismiss<cr>", "Dismiss")
nmap("<leader>ne", "<cmd>NoiceErrors<cr>", "Errors")
nmap("<leader>nh", "<cmd>NoiceHistory<cr>", "History")

-- ======================
-- [P]ersistence
-- ======================
nmap("<leader>pa", "<cmd>lua require('persistence').select()<cr>", "All Sessions")
nmap("<leader>pc", "<cmd>lua require('persistence').load()<cr>", "Current dir")
nmap("<leader>pl", "<cmd>lua require('persistence').load({ last = true })<cr>", "Last")

-- ======================
-- [R]un
-- ======================
local flutter_mappings = function()
	nmap("<leader>rc", "<cmd>FlutterCopyProfilerUrl<cr>", "Flutter: Copy Profiler Url")
	nmap("<leader>rC", "<cmd>Telescope flutter commands<CR>", "Flutter: Commands")
	nmap("<leader>rd", "<cmd>FlutterDevices<cr>", "Flutter: Devices")
	nmap("<leader>re", "<cmd>FlutterEmulators<cr>", "Flutter: Emulators")
	nmap("<leader>rh", "<cmd>FlutterReload<cr>", "Flutter: Hot Reload")
	nmap("<leader>rH", "<cmd>FlutterRestart<cr>", "Flutter: Hot Restart")
	nmap("<leader>rl", "<cmd>FlutterLogToggle<cr>", "Flutter: Log Toggle")
	nmap("<leader>ro", "<cmd>FlutterOutlineToggle<cr>", "Flutter: Outline")
	nmap("<leader>rp", "<cmd>FlutterPubGet<cr>", "Flutter: Pub Get")
	nmap("<leader>rq", "<cmd>FlutterQuit<cr>", "Flutter: Quit")
	nmap("<leader>rr", "<cmd>FlutterRun<cr>", "Flutter: Run")
	nmap("<leader>rt", "<cmd>FlutterDevTools<cr>", "Flutter: Dev Tools")
	nmap("<leader>rx", "<cmd>FlutterLogClear<cr>", "Flutter: Log Clear")
end

-- DAP (Debug)
-- Alt + q - Throw Exception = Not Supported
-- Alt + z - Enable/Disable line breakpoint = Not Supported
-- Alt + a - View all break points = Not Supported
-- Alt + f - Mute/Unmute all breakpoints = Not Supported
local function dap_support()
	-- Step into
	nmap("<A-w>", function()
		require("dap").step_into()
	end, "DAP: Step Into")

	-- Evaluate expression
	nmap("<A-e>", function()
		require("dapui").eval()
	end, "DAP: Eval")

	-- Resume / Continue
	nmap("<A-r>", function()
		require("dap").continue()
	end, "DAP: Continue")

	-- Step over
	nmap("<A-s>", function()
		require("dap").step_over()
	end, "DAP: Step Over")

	-- Step out (closest valid to "drop frame")
	nmap("<A-d>", function()
		require("dap").step_out()
	end, "DAP: Step Out")

	-- REPL (closest valid "execution interaction")
	nmap("<A-x>", function()
		require("dap").repl.open()
	end, "DAP: REPL")

	-- Run to cursor
	nmap("<A-c>", function()
		require("dap").run_to_cursor()
	end, "DAP: Run to Cursor")

	-- Toggle breakpoint (line)
	nmap("<A-v>", function()
		require("dap").toggle_breakpoint()
	end, "DAP: Toggle Breakpoint")

	-- Start / Select config
	nmap("<leader>rd", function()
		require("dap").continue()
	end, "Run Debugging")

	-- Toggle UI manually
	nmap("<A-5>", function()
		require("dapui").toggle()
	end, "DAP: Toggle UI")
end

local python_mappings = function()
	nmap("<leader>rr", function()
		local terminal = require("toggleterm.terminal").Terminal:new({
			cmd = (vim.fn.executable("python") == 1 and "python" or "python3") .. " main.py",
			dir = vim.fn.getcwd(),
			direction = "float",
			close_on_exit = false,
		})

		terminal:toggle()
	end, "Python: Run main.py")
	nmap("<leader>rv", "<cmd>VenvSelect<cr>", "Python: Venv select")
	dap_support()
end

local languages_registry = { -- Trigger keymaps per filetype
	python = python_mappings,
	dart = flutter_mappings,
	markdown = markdown_mappings,
}

-- ======================
-- [S]udo
-- ======================
nmap("<leader>Sw", "<cmd>SudaWrite<CR>", "Save with Sudo")
nmap("<leader>Sr", "<cmd>SudaRead<CR>", "Open with Sudo")

-- ======================
-- [S]earch Telescope
-- ======================
nmap("<leader>sb", "<cmd>lua require('telescope.builtin').buffers()<CR>", "Search Buffers")
nmap("<leader>sc", "<cmd>Telescope commands<cr>", "Search Commands")
nmap("<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "Search Diagnostics")
nmap("<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<CR>", "Search Files")
nmap("<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Search Help")
nmap("<leader>sH", "<cmd>Telescope highlights<cr>", "Search Highlight Groups")
nmap("<leader>sk", "<cmd>lua require('telescope.builtin').keymaps()<CR>", "Search Keymaps")
nmap("<leader>sl", "<cmd>lua require('telescope.builtin').resume()<CR>", "Search Last Picker")
nmap("<leader>sM", "<cmd>Telescope man_pages<cr>", "Search Man Pages")
nmap("<leader>sr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Search Recent Files")
nmap("<leader>sR", "<cmd>Telescope registers<cr>", "Search Registers")
nmap("<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", "Search Symbols")
nmap("<leader>st", "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Search Text")
nmap("<leader>sT", "<cmd>lua require('telescope.builtin').builtin()<CR>", "Search Telescope")
nmap("<leader>sw", "<cmd>lua require('telescope.builtin').grep_string()<CR>", "Search current Word")
nmap("<leader>su", "<cmd>Telescope undo<cr>", "Search Undo History")
nmap("<leader>sn", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, "Search Neovim files")

-- ======================
-- [T]elescope Integrations
-- ======================
nmap("<leader>tb", "<cmd>Telescope bookmarks list<cr>", "Bookmarks")
nmap("<leader>tn", "<cmd>NoiceTelescope<CR>", "Noice Messages")

nmap("<leader>tc", function()
	require("telescope.builtin").live_grep({
		prompt_title = "Cheatsheets",
		cwd = vim.fn.expand("~/.utils/Cheatsheets"),
	})
end, "Cheatsheet")

-- ======================
-- [Y] Trouble
-- ======================
nmap("<leader>yx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics")
nmap("<leader>yX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics")
nmap("<leader>yL", "<cmd>Trouble loclist toggle<cr>", "Location List")
nmap("<leader>yQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix List")
nmap("<leader>ys", "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols")
nmap("<leader>yl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP References")

-- ======================
-- [L]SP
-- ======================
local M = {}

function M.setup_lsp_keymaps(buf, client)
	local telescope = require("telescope.builtin")

	local function lmap(mode, lhs, rhs, desc, extra)
		map(mode, lhs, rhs, utils.opts(desc, vim.tbl_extend("force", { buffer = buf }, extra or {})))
	end

	lmap("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
	lmap({ "n", "x" }, "<leader>la", vim.lsp.buf.code_action, "Code Action")

	lmap("n", "<leader>lf", function()
		require("conform").format({ async = true })
	end, "Format (Conform)")

	lmap("n", "<leader>lX", "<cmd>LspRestart<cr>", "Restart LSP")
	lmap("n", "<leader>lR", telescope.lsp_references, "References")
	lmap("n", "<leader>li", telescope.lsp_implementations, "Implementation")
	lmap("n", "<leader>ld", telescope.lsp_definitions, "Definitions")
	lmap("n", "<leader>lD", vim.lsp.buf.declaration, "Declaration")
	lmap("n", "<leader>ls", telescope.lsp_document_symbols, "Document Symbols")
	lmap("n", "<leader>lS", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")
	lmap("n", "<leader>lt", telescope.lsp_type_definitions, "Type Definition")
	lmap("n", "gd", vim.lsp.buf.definition, "Goto Definition")
	lmap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
	lmap({ "n", "i" }, "gK", vim.lsp.buf.signature_help, "Signature Help")
	lmap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous Diagnostic")
	lmap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
	lmap("n", "<leader>ll", vim.diagnostic.open_float, "Line Diagnostics")

	lmap("n", "<C-b>", vim.lsp.buf.definition, "Go to LSP Definition") -- This was vim.lsp.buf.definition, so kept it
	-- lmap("n", "<C-p>", "<cmd>lua require('lsp_signature').toggle_float_win()<cr>", { desc = "Toggle LSP Signature Float" })
	-- lmap("i", "<C-p>", "<cmd>lua require('lsp_signature').toggle_float_win()<cr>", { desc = "Toggle LSP Signature Float" })

	if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		lmap("n", "<leader>lh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }))
		end, "Toggle Inlay Hints")
	end
end

function M.setup_language_keymaps(buf)
	if vim.b[buf].keymaps_loaded then -- prevent duplicate execution
		return
	end
	vim.b[buf].keymaps_loaded = true

	local ft = vim.bo[buf].filetype
	local fn = languages_registry[ft]

	if not fn then
		return
	end

	fn()
end

return M
