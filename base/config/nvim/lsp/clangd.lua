return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=never",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = {
		"platformio.ini",
		"compile_commands.json",
		"compile_flags.txt",
		"CMakeLists.txt",
		".git",
	},
}
