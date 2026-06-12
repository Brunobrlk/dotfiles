return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return math.floor(vim.o.lines * 0.3)
            elseif term.direction == "vertical" then
                return math.floor(vim.o.columns * 0.3)
            end
        end,
        start_in_insert = true,
        insert_mappings = true,
        persist_mode = false,
        direction = "float",
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        persist_size = false,
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
            width = function()
                return math.floor(vim.o.columns * 0.9)
            end,
            height = function()
                return math.floor(vim.o.lines * 0.8)
            end,
        },
    },
}
