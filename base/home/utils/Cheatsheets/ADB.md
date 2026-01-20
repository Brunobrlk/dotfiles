# Generates a system dump for the current project
adbdump

# List permissions and status by group
adblsperm

# Grants the specified permission
adbaperm <permission.name>

# Revokes the specified permission
adbrperm <permission.name>

# Reset the user denied preferences, so the runtime dialog appears for testing
adbclsperm <permission.name>

# Installs the debug apk with all permissions granted for testing purposes
adbidallperm

# Installs the release apk with all permissions granted for testing purposes
adbirallperm
