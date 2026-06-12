lvim.builtin.treesitter.ensure_installed = {
  "kotlin",
  "java",
  "xml",
  "groovy",
  "dart",
  "c",
  "cpp",
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
  "javascript"
}

vim.filetype.add({
  filename = {
    ["Fastfile"]    = "ruby",
    ["Appfile"]     = "ruby",
    ["Matchfile"]   = "ruby",
    ["Gymfile"]     = "ruby",
    ["Deliverfile"] = "ruby",
    ["Pluginfile"]  = "ruby",
    ["Scanfile"]    = "ruby",
    ["Screengrabfile"] = "ruby",
    ["Snapfile"]    = "ruby",
    ["Podfile"]     = "ruby",   -- CocoaPods, bonus
  },
})
