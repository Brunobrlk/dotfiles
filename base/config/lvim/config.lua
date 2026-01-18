-- Options
reload("user.options")

-- Autocommands
reload("user.autocommands")

-- Mappings
reload("user.mappings")

-- User Plugins
reload("user.plugins")

-- Builtin Plugins
reload("plugins.telescope")
reload("plugins.nvimtree")
reload("plugins.treesitter")
reload("plugins.completion")
reload("plugins.lualine")
reload("plugins.lspconfig")
lvim.builtin.lir.active = false
lvim.builtin.dap.active = false
lvim.builtin.alpha.active = false
