# Setup
- [] gnupg
- [] ssh
    # Check file existence: git_key
- [] git
    # Check config.local existence and warn the user
- [] aliases
    # Manage Distro/DE/DisplayServer specific aliases when installing dots
        - whatapp = X11 dependent => grep -Ri "Patience" /usr/share/applications
- [] env
    # Cinnamon doesn't even work environment.d

# TODO
- [] Update scripts to match new structure: update.sh, install.sh

# Consider
- [] Implement backup and restore before installing
    - Save and restore from ~/.config/dotfiles
