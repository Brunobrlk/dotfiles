# dotfiles

Personal Linux dotfiles and environment setup.

This repository is primarily an attempt to automate my own daily Linux setup,
but the structure and scripts were designed with portability in mind.
The default behavior reflects my preferences (Fedora, KDE-Plasma, Wayland).
while other platforms are intentionally kept minimal as templates / examples.

## Overview

This repository manages configuration for:

- Shell environment: bash
- Terminal + Prompt: alacritty, starship, tmux, readline
- Editors: neovim, lunarvim, ideavim
- Media tools: mpd, mpv, rmpc
- Code/Tool versioning: git and mise 
- Utilities: bat, btop, rofi, yazi, wget, yt-dlp, etc.
- Personal helpers: cheatsheets, gists, docker-compose templates
- Desktop, Display and Distro specific behavior

All files are installed following XDG Base Directory conventions whenever possible.

Empty or minimal folders (for example: distro/debian, desktop/kde) are intentional
and serve as examples.

## Directory layout - Configuration

The repository is organized in layers, applied from generic to specific:
```
base/        # shared defaults (always applied)
distro/      # distro-specific overrides (fedora, debian, mint)
display/     # display server overrides (wayland, xorg)
desktop/     # desktop environment overrides (kde, gnome, cinnamon)
```
## Usage

Tool | Description
--- | ---
install.sh | Installs dotfiles into your system by merging layers into the appropriate locations.
backup.sh | Creates a backup of existing configuration before installation.
restore.sh | Restores files previously backed up by backup.sh.
update.sh | Utility script to help keep dotfiles sync.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, feel free to contact me at [brunoguimaraes.dev@gmail.com].
