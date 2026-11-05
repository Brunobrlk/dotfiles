return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local parsers = {
            "kotlin",
            "java",
            "xml",
            "groovy",
            "dart",
            "c",
            "cpp",
            "cmake",
            "c_sharp",
            "lua",
            "python",
            "bash",
            "json",
            "toml",
            "yaml",
            "ruby",
            "html",
            "css",
            "javascript",

            -- Markdown
            "markdown",
            "markdown_inline",
        }

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "kotlin",
                "java",
                "xml",
                "groovy",
                "dart",
                "c",
                "cpp",
                "cmake",
                "cs",
                "lua",
                "python",
                "sh",
                "json",
                "toml",
                "yaml",
                "ruby",
                "html",
                "css",
                "javascript",
                "markdown",
            },
            callback = function(args)
                vim.treesitter.start(args.buf)
            end,
        })
    end,
}
