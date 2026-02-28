-- Options
reload("user.options")

-- Autocommands
reload("user.autocommands")

-- Mappings
reload("user.mappings")

-- User Plugins
reload("user.plugins")

-- Builtin Plugins
reload("plugins.completion")
reload("plugins.lsp")
reload("plugins.lspconfig")
reload("plugins.lualine")
reload("plugins.mason")
reload("plugins.nvimtree")
reload("plugins.telescope")
reload("plugins.treesitter")
lvim.builtin.lir.active = false
lvim.builtin.dap.active = false
lvim.builtin.alpha.active = false
