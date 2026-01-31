lvim.plugins = {
    -- Theme
    { "catppuccin/nvim" },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "*" }, {
                RGB = true,      -- #RGB hex codes
                RRGGBB = true,   -- #RRGGBB hex codes
                names = true,    -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true,   -- CSS rgb() and rgba() functions
                hsl_fn = true,   -- CSS hsl() and hsla() functions
                css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end,
        event = "VeryLazy"
    },

    -- Formatter Manager
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                kotlin = { "ktlint" },
                python = { "ruff" },
                xml = { "xmlformatter" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                dart = { "dart_format" },
            },
        }
    },

    -- Linter Manager
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            require("lint").linters_by_ft = {
                python = { "ruff" },
                kotlin = { "ktlint" },
            }
        end
    },

    -- Session Manager
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            allowed_dirs = { "~/.utils/*", "~/Development/*", "~/.local/*", "~/.config/*", "~/Src/*" },
            session_lens = {
                picker = "telescope"
            },
            post_restore_cmds = {
                function()
                    local nvim_tree_api = require("nvim-tree.api")
                    nvim_tree_api.tree.open()
                    nvim_tree_api.tree.change_root(vim.fn.getcwd())
                    nvim_tree_api.tree.reload()
                end,
            }
        },
    },

    -- Bookmarks Manager
    {
        "tomasky/bookmarks.nvim",
        opts = {
            save_file = vim.fn.expand("$XDG_CONFIG_HOME/.lvim-bookmarks"), -- bookmarks save file path
            keywords = {
                ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
                ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
                ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
                ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
            },
        },
    },

    -- Python virtual environment manager
    -- {
    --     "linux-cultist/venv-selector.nvim",
    --     dependencies = { "neovim/nvim-lspconfig" },
    --     ft = "python", -- Load when opening Python files
    --     opts = {},
    -- },

    -- Flutter Tools 
    {
        'nvim-flutter/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = function()
            require("flutter-tools").setup {
                lsp = {
                    cmd = { "dart", "language-server", "--protocol=lsp" },
                },
            }
        end,
    },
    -- Git: Run Commands from nvim
    {
        "tpope/vim-fugitive",
    },

    -- Git: Better diff UI
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- Read/Write files with sudo
    {
        "lambdalisue/suda.vim",
        init = function()
            vim.cmd("let g:suda_smart_edit = 1")
            vim.cmd("let g:suda#noninteractive = 1")
        end
    },

    -- Better surround matching with . support via vim-repeat
    { "tpope/vim-surround", dependencies = { "tpope/vim-repeat" } },

    -- Navigate from/to tmux windows
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious"
        }
    },

    -- Show Method Signatures
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            bind = true,
            handler_opts = { border = "rounded" },
            floating_window = true,
            hint_enable = true,
            hint_prefix = "🐼 "
        }
    },

    -- Floating Search/CMD
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = false,      -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            -- {
            --     "rcarriga/nvim-notify",

            --     config = function()
            --         require('notify').setup {
            --             background_colour = "FloatShadow",
            --             render = "wrapped-compact",
            --             top_down = false
            --         }
            --     end,
            -- }
        }
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        init = function()
            vim.cmd("let g:mkdp_theme = 'light'")
            vim.cmd("let g:mkdp_auto_close = 0")
            vim.cmd("let g:mkdp_combine_preview = 1")
            vim.cmd("let g:mkdp_combine_preview_auto_refresh = 1")
            vim.cmd([[
                function OpenMarkdownPreview (url)
                    execute "silent ! brave-browser --new-window --start-fullscreen " . a:url
                endfunction
                let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]])

            vim.cmd([[let g:mkdp_preview_options = {
                \ 'mkit': {},
                \ 'katex': {},
                \ 'uml': {},
                \ 'maid': {},
                \ 'disable_sync_scroll': 0,
                \ 'sync_scroll_type': 'middle',
                \ 'hide_yaml_meta': 1,
                \ 'sequence_diagrams': {},
                \ 'flowchart_diagrams': {},
                \ 'content_editable': v:false,
                \ 'disable_filename': 1
                \ }]])
        end
    },

    {
        "bullets-vim/bullets.vim",
        ft = "markdown",
        config = function()
            vim.g.bullets_enable_in_empty_buffers = 0 -- default = 1
            vim.g.bullets_checkbox_markers = " ---x"
        end,
    },

    -- Telescope Extensions
    -- Project Manager
    { "nvim-telescope/telescope-project.nvim" },
}
