# List all plugins
asdf plugin list all

# List installed plugins
asdf plugin list

# Install a plugin
asdf plugin add <name>

# Uninstall a plugin
asdf plugin remove <name>

# Update all plugins
asdf plugin update --all

# List installed packages and its configuration
asdf current
asdf list

# Installed versions of a package
asdf list <name>

# List all versions of a package
asdf list all <name>

# List latest stable version of a package
asdf latest <name>

# List latest stable version of all packages
asdf latest --all

# Install all package versions listed in .tool-versions file
asdf install

# Install a specific version of a package
asdf install <name> <version>

# Uninstall a specific version of a package
asdf uninstall <name> <version>

# Setup local and global package configuration
asdf [local | global] <name> <version>
asdf [local | global] <name> latest
