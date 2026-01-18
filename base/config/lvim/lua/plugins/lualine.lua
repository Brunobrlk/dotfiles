local lualine = lvim.builtin.lualine

lualine.active = true

lualine.options = {
    theme = "auto",
    icons_enabled = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
}

local components = require("lvim.core.lualine.components")
local device = require("scripts.nvim_android_device")
local noice = require("noice")
lualine.sections.lualine_a = { "mode" }
lualine.sections.lualine_b = { components.branch, components.diff }
lualine.sections.lualine_c = {
    {
        noice.api.status.command.get,
        cond = noice.api.status.command.has,
        color = { fg = "#ff9e64" },
    },
    {
        noice.api.status.mode.get,
        cond = noice.api.status.mode.has,
        color = { fg = "#ff9e64" },
    },
}
lualine.sections.lualine_x = {
    {
        noice.api.status.search.get,
        cond = noice.api.status.search.has,
        color = { fg = "#ff9e64" },
    },
    device.android_model,
    components.python_env,
    components.filetype,
    components.lsp
}
lualine.sections.lualine_y = { components.progress, components.location }
lualine.sections.lualine_z = {}
