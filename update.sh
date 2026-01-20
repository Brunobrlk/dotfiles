#!/bin/bash

# Author: Bruno Guimarães
# Description: Get the most recent dot files
# Version: 1.0
# Last Updated: YYYY-MM-DD

# -----------------------------------------------------------------------------
# Base
rsync -av ~/.bashrc ./base/home
rsync -av ~/.profile ./base/home

rsync -av ~/.config/alacritty ./base/config
# rsync -av ~/.config/asdf/tool-versions ./base/config/asdf
rsync -av \
  --exclude='env.d/' \
  --exclude='aliases.d/' \
  ~/.config/bash ./base/config
rsync -av ~/.config/bat ./base/config
rsync -av ~/.config/btop ./base/config
rsync -av ~/.config/environment.d ./base/config
rsync -av ~/.config/flameshot ./base/config
rsync -av ~/.config/git ./base/config
# rsync -av ~/.config/Google config
rsync -av ~/.config/ideavim ./base/config
rsync -av ~/.config/less ./base/config
rsync -av ~/.config/lvim ./base/config
rsync -av ~/.config/mise ./base/config
rsync -av ~/.config/mpd ./base/config
rsync -av ~/.config/mpv ./base/config
rsync -av ~/.config/neofetch ./base/config
rsync -av ~/.config/npm ./base/config
rsync -av ~/.config/nvim ./base/config
rsync -av ~/.config/PCSX2 ./base/config
rsync -av ~/.config/polybar ./base/config
rsync -av ~/.config/readline ./base/config
rsync -av ~/.config/rmpc ./base/config
rsync -av ~/.config/rofi ./base/config
rsync -av ~/.config/starship ./base/config
rsync -av \
  --exclude='user/*.wants/' \
  ~/.config/systemd ./base/config
rsync -av --exclude='plugins' ~/.config/tmux ./base/config
rsync -av ~/.config/wget ./base/config
rsync -av ~/.config/yt-dlp ./base/config
rsync -av ~/.config/yazi ./base/config

rsync -av ~/Development/android_studio_settings.zip ./base

rsync -av \
  --include='Cheatsheets/***' \
  --include='DockerContainers/***' \
  --include='CodeGists/***' \
  --include='Gitignore-Templates/***' \
  --exclude='*' \
  ~/.utils/ ./utils/

# -----------------------------------------------------------------------------
# Display

## Xorg
if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
  rsync -av ~/.config/bash/env.d/xorg.conf ./display/xorg/config/bash/env.d
  rsync -av ~/.config/bash/aliases.d/xorg.sh ./display/xorg/config/bash/aliases.d

  rsync -av ~/.config/sxhkd ./display/xorg/config
  rsync -av ~/.config/greenclip.toml ./display/xorg/config
fi

## Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  rsync -av ~/.config/bash/env.d/wayland.conf ./display/wayland/config/bash/env.d
  rsync -av ~/.config/bash/aliases.d/wayland.sh ./display/wayland/config/bash/aliases.d
fi

# -----------------------------------------------------------------------------
# Desktop

## Cinnamon
if [[ "$XDG_CURRENT_DESKTOP" == *Cinnamon* ]]; then
  rsync -av ~/.config/bash/env.d/cinnamon.conf ./desktop/cinnamon/config/bash/env.d
  rsync -av ~/.config/bash/aliases.d/cinnamon.sh ./desktop/cinnamon/config/bash/aliases.d

  dconf dump /org/cinnamon/desktop/keybindings/ >desktop/cinnamon/shortcuts.conf
fi

## KDE
if [[ "$XDG_CURRENT_DESKTOP" == *KDE* ]]; then
  rsync -av ~/.config/bash/env.d/kde.conf ./desktop/kde/config/bash/env.d
  rsync -av ~/.config/bash/aliases.d/kde.sh ./desktop/kde/config/bash/aliases.d

  rsync -av \
  ~/.config/kdeglobals \
  ~/.config/kglobalshortcutsrc \
  ~/.config/khotkeysrc \
  ~/.config/kwinrc \
  ~/.config/plasmarc \
  ~/.config/plasma-org.kde.plasma.desktop-appletsrc \
  ~/.config/plasma-localerc \
  ~/.config/powerdevilrc \
  desktop/kde/config/
fi

## Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *GNOME* ]]; then
  rsync -av ~/.config/bash/env.d/gnome.conf ./desktop/gnome/config/bash/env.d
  rsync -av ~/.config/bash/aliases.d/gnome.sh ./desktop/gnome/config/bash/aliases.d

  dconf dump /org/gnome/ >desktop/gnome/dconf.conf
fi

# -----------------------------------------------------------------------------
# Others
## .ssh and .gnupg are sensitive folders, thus only save it locally

## vimium_c: Google Chrome > Vimium options > Export Settings
