local telescope = lvim.builtin.telescope

telescope.defaults = {
    layout_strategy = "horizontal",
    layout_config = {
        horizontal = {
            preview_width = 0.67,
            results_width = 0.33,
            mirror = false,
        },
        width = 0.85,
        height = 0.85,
        preview_cutoff = 120,
    },
    winblend = 0,
    path_display = { truncate = 3 },
    file_ignore_patterns = {
        "%.git",
        "node_modules/",
        "/generated/"
    },

    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
}

telescope.pickers = {
    find_files = {
        find_command = {
            "fd",
            "--type", "f",
            "--hidden",
            "--exclude", ".git",
            "--exclude", "node_modules",
            "--exclude", "generated",
            "--exclude", ".venv",
        },
    },
}

telescope.on_config_done = function(telescope_arg)
    -- pcall(telescope_arg.load_extension, "project")
    pcall(telescope_arg.load_extension, "flutter")
end
