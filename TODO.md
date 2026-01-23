# Setup
- [x] gnupg
- [x] ssh
    # Check file existence: git_key
- [] git
    # Check config.local existence and warn the user
- [x] aliases
    # Manage Distro/DE/DisplayServer specific aliases when installing dots
        - whatapp = X11 dependent => grep -Ri "Patience" /usr/share/applications
- [] env
    # Cinnamon doesn't even work environment.d

# TODO
- [x] Update scripts to match new structure: update.sh, install.sh

# Consider
- [] Implement backup and restore before installing
    - Save and restore from ~/.config/dotfiles
