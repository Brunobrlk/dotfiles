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

Hardcoded/Trash:

App | Legacy path | Notes
-- | -- | --
kotlin | ~/.kotlinc_history | Related Konan issue: https://youtrack.jetbrains.com/issue/KT-40763
Ollama | ~/.ollama | https://github.com/ollama/ollama/issues/228 - Model locations can be set with: `OLLAMA_MODELS=$XDG_DATA_HOME/ollama/models`
flutter | ~/.flutter, ~/.flutter_settings, ~/.flutter_tool_state, ~/.pub-cache | https://github.com/flutter/flutter/issues/59430
dart | ~/.dart, ~/.dart-tool, ~/.dartServer | https://github.com/dart-lang/sdk/issues/41560
nvidia-settings | ~/.nvidia-settings-rc | https://github.com/NVIDIA/nvidia-settings/issues/30
adb & Android Studio | ~/.android/ | Despite appearances otherwise, adb will always generate ~/.android/adbkeys, though it will try keys in ADB_VENDOR_KEYS as well.
Java OpenJDK | ~/.java/fonts | https://bugzilla.redhat.com/show_bug.cgi?id=1154277, https://bugs.openjdk.org/browse/JDK-8290140
maven | ~/.m2 | https://github.com/apache/maven/issues/8634

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
