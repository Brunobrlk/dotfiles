lvim.builtin.mason.ensure_installed = {
    "ktlint",
    "ruff",
    "shfmt",
    "mdformat",
    "xmlformatter"
}

-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "kotlin-language-server" })
-- remove `jedi_language_server` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "kotlin-lsp"
end, lvim.lsp.automatic_configuration.skipped_servers)
