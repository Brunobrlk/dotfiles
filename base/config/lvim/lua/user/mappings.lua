-- Neovim
local map = vim.keymap.set

map("n", "<M-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<M-h>", "<cmd>bprevious<CR>", { desc = "" })
map("n", "<M-x>", "<cmd>BufferKill<CR>", { desc = "" })
map("n", "<C-b>", "<cmd>lua vim.lsp.buf.definition<cr>", { desc = "" })
map("n", "<C-p>", "<cmd>lua require('lsp_signature').toggle_float_win()<cr>", { desc = "" })

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "" })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "" })

map("n", "mm", "<cmd>lua require('bookmarks').bookmark_toggle()<cr>")                    -- add or remove bookmark at current line
map("n", "mi", "<cmd>lua require('bookmarks').bookmark_ann()<cr>")                       -- add or edit mark annotation at current line
map("n", "mc", "<cmd>lua require('bookmarks').bookmark_clean()<cr>")                     -- clean all marks in local buffer
map("n", "mn", "<cmd>lua require('bookmarks').bookmark_next()<cr>")                      -- jump to next mark in local buffer
map("n", "mp", "<cmd>lua require('bookmarks').bookmark_prev()<cr>")                      -- jump to previous mark in local buffer
map("n", "ml", "<cmd>lua require('bookmarks').bookmark_list()<cr>")                      -- show marked file list in quickfix window
map("n", "mx", "<cmd>lua require('bookmarks').bookmark_clear_all()<cr>")                 -- removes all bookmarks

map("i", "jk", "<ESC>", { desc = "" })
map("i", "<C-p>", "<cmd>require('lsp_signature').toggle_float_win()<cr>", { desc = "" })

-- Which Key
local wk = lvim.builtin.which_key

wk.mappings["Q"] = { "<cmd>quitall<CR>", "Exit Session" }

wk.mappings["S"] = {
    name = "Sudo",
    w = { "<cmd>SudaWrite<CR>", "Save with Sudo" },
    r = { "<cmd>SudaRead<CR>", "Open with Sudo" }
}

wk.mappings["x"] = {
    name = "Trouble",
    x = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics" },
    X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics" },
    L = { "<cmd>Trouble loclist toggle<cr>", "Location List" },
    Q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List" },
    s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols" },
    l = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP References" }
}

wk.mappings["r"] = {
    name = "Session",
    w = { "<cmd>AutoSession search<cr>", "Select session" },
    s = { "<cmd>AutoSession save<cr>", "Save session" },
}

wk.mappings["F"] = {
    name = "Flutter",
    r = { "<cmd>FlutterRun<cr>", "Run" },
    t = { "<cmd>FlutterDevTools<cr>", "Dev Tools" },
    d = { "<cmd>FlutterDevices<cr>", "Devices" },
    e = { "<cmd>FlutterEmulators<cr>", "Emulators" },
    h = { "<cmd>FlutterReload<cr>", "Hot Reload" },
    H = { "<cmd>FlutterRestart<cr>", "Hot Restart" },
    p = { "<cmd>FlutterPubGet<cr>", "Pub Get" },
    q = { "<cmd>FlutterQuit<cr>", "Quit" },
    v = { "<cmd>FlutterVisualDebug<cr>", "Visual Debug" },
    c = { "<cmd>FlutterCopyProfilerUrl<cr>", "Copy Profiler Url" },
    l = { "<cmd>FlutterLogToggle<cr>", "Log Toggle" },
    x = { "<cmd>FlutterLogClear<cr>", "Log Clear" },
    o = { "<cmd>FlutterOutlineToggle<cr>", "Outline" },
}

wk.mappings["t"] = {
    name = "Telescope",
    f = { "<cmd>Telescope flutter commands<CR>", "Flutter Commands" },
    p = { "<cmd>Telescope projects<CR>", "Recent Projects" },
    P = { "<cmd>Telescope project<CR>", "Select Project" },
    n = { "<cmd>NoiceTelescope<CR>", "Noice Messages" },
    b = { "<cmd>Telescope bookmarks list<cr>", "Bookmarks" }
}

wk.mappings["f"] = {
    name = "Find",
    f = { "<cmd>Telescope find_files<cr>", "Files" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" }, -- Or fg(find grep)
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    l = { "<cmd>Telescope resume<cr>", "Last Picker" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    c = { "<cmd>Telescope neoclip<cr>", "Clipboard History" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Symbols" },
    H = { "<cmd>Telescope highlights<cr>", "Highlight Groups" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    u = { "<cmd>Telescope undo<cr>", "Undo History" },
    w = { "<cmd>Telescope grep_string<cr>", "Word" },
}

wk.mappings["lf"] = { "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>", "Format(Conform)" }
wk.mappings["Lt"] = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", "Theme" }
