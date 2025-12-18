-- JSON
lvim.lsp.settings.jsonls = {
    json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
    },
}

-- YAML
lvim.lsp.settings.yamlls = {
    yaml = {
        schemaStore = {
            enable = false,
            url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
        validate = true,
        completion = true,
        hover = true,
    },
}

-- LSP Formatter
lvim.lsp.on_attach_callback = function(client, _)
  local disable_formatting_for = {
    "kotlin_language_server",
    "pyright",
    "dartls",
    "lemminx",
    "bashls",
  }

  if vim.tbl_contains(disable_formatting_for, client.name) then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

