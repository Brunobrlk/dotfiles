# Neovim Configuration

A modular Neovim setup built with **lazy.nvim** and organized by concern (core settings, UX, language tooling, and language-server overrides).

## Architecture Overview

### Startup flow

1. `init.lua` loads lazy.nvim, its plugins on `lua/plugins/*.lua` and foundational editor modules in this order:
   - `lua/keymaps.lua`
   - `lua/options.lua`
   - `lua/autocommands.lua`
2. LSP servers are enabled through the `nvim-lspconfig` setup in `lua/plugins/lsp.lua` and optional per-server overrides in `lsp/*.lua`.

This gives a predictable boot pipeline: **core editor behavior first, plugin/runtime integrations second**.

---

## Project Structure

```text
.
├── init.lua                      # Entry point and plugin bootstrap
├── filetype.lua                  # Filetype-specific glue (if used by Neovim runtime)
├── lazy-lock.json                # lazy.nvim lockfile for reproducible plugin versions
├── README.md
│
├── lua/
│   ├── options.lua               # UI, editing, search, split, clipboard, fold, performance options
│   ├── keymaps.lua               # Global + feature keymaps (Telescope, Git, Flutter, sessions, etc.)
│   ├── autocommands.lua          # LspAttach hooks, user commands, and diagnostic helpers
│   └── plugins/
│       ├── core.lua              # Core quality-of-life plugins (commenting, surround, autopairs, sudo, etc.)
│       ├── colorscheme.lua       # Theme setup
│       ├── bufferline.lua        # Buffer/tab UI
│       ├── lualine.lua           # Statusline
│       ├── whichkey.lua          # Keymap hinting
│       ├── noice.lua             # UI/command-line/message enhancements
│       ├── neotree.lua           # File explorer
│       ├── telescope.lua         # Finder/search UI
│       ├── treesitter.lua        # Syntax tree parsing/highlighting/textobjects
│       ├── completion.lua        # Completion (blink.cmp + LuaSnip)
│       ├── lsp.lua               # LSP diagnostics/capabilities/server enablement
│       ├── mason.lua             # Tool/server installation management
│       ├── conform.lua           # Formatting setup (format-on-save)
│       ├── lint.lua              # Linting setup and autocmd triggers
│       ├── dap.lua               # Debug adapter setup + UI
│       ├── git.lua               # Git integrations
│       ├── markdown.lua          # Markdown-specific plugins/config
│       ├── sessions.lua          # Session management
│       ├── toggleterm.lua        # Integrated terminal workflow
│       ├── flutter.lua           # Flutter tooling
│       ├── pyvenv.lua            # Python venv selection
│       └── illuminate.lua        # Symbol/reference illumination
│
├── lsp/
│   ├── bash-language-server.lua
│   ├── jdtls.lua
│   ├── json-lsp.lua
│   ├── kotlin-language-server.lua
│   ├── kotlin-lsp.lua
│   ├── lua-language-server.lua
│   ├── pyright.lua
│   ├── vim-language-server.lua
│   └── yaml-language-server.lua
│   # Per-server settings overrides consumed by Neovim's LSP config
│
└── snippets/
    ├── package.json
    ├── c.json
    ├── dart.json
    ├── java.json
    ├── markdown.json
    ├── python.json
    └── shell.json
    # VSCode-format custom snippets loaded via LuaSnip
```

---

## Configuration Layers

### 1) Core editor layer (`lua/options.lua`, `lua/keymaps.lua`, `lua/autocommands.lua`)

- Handles universal behavior independent of plugins:
  - editor options (indentation, folds, clipboard, search, split behavior)
  - keymap ergonomics and leader-based command groups
  - autocmd-driven behavior (e.g., LSP attach lifecycle)

### 2) Plugin composition layer (`lua/plugins/*.lua`)

Each file exports a lazy.nvim spec table so plugin concerns remain isolated.

- **UX/navigation**: `telescope.lua`, `neotree.lua`, `bufferline.lua`, `whichkey.lua`, `noice.lua`, `lualine.lua`
- **Code intelligence**: `lsp.lua`, `completion.lua`, `treesitter.lua`
- **Code quality**: `conform.lua`, `lint.lua`
- **Developer workflow**: `dap.lua`, `git.lua`, `toggleterm.lua`, `sessions.lua`
- **Language/domain extras**: `flutter.lua`, `pyvenv.lua`, `markdown.lua`

### 3) Language server override layer (`lsp/*.lua`)

This folder is reserved for per-server overrides and keeps language tuning separate from global LSP wiring.

Examples:

- `lsp/lua-language-server.lua` contains Lua LS settings
- `lsp/pyright.lua` and others can be expanded without touching plugin orchestration

### 4) Snippet layer (`snippets/*.json`)

Project-local snippets in VSCode JSON format are loaded by LuaSnip, letting you keep custom expansions versioned alongside the config.

---

## Common extension patterns

### Add a new plugin

1. Create `lua/plugins/<feature>.lua` exporting a lazy spec.
2. Add `require("plugins.<feature>")` to `lazy.setup(...)` in `init.lua`.
3. Add related keymaps to `lua/keymaps.lua` only if they are global/user-facing.

### Add or customize an LSP server

1. Add server package in `lua/plugins/mason.lua` (`ensure_installed`).
2. Enable server in `lua/plugins/lsp.lua` (`vim.lsp.enable({...})`).
3. Add optional override at `lsp/<server>.lua`.

### Add snippets

1. Add/update JSON files under `snippets/`.
2. Ensure language is included in snippet loader list in `lua/plugins/completion.lua`.
