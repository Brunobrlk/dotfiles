#!/bin/bash

# Author: Bruno Guimarães
# Description: Get the most recent dot files
# Version: 1.0
# Last Updated: YYYY-MM-DD


# -----------------------------------------------------------------------------
# Copy dot files
dconf dump /org/cinnamon/desktop/keybindings/ > cinnamon-shortcuts.conf

rsync -av ~/.bashrc .
rsync -av ~/.profile .

rsync -av ~/.config/alacritty config
rsync -av ~/.config/asdf/tool-versions config/asdf/
rsync -av ~/.config/bash config
rsync -av ~/.config/flameshot config
rsync -av ~/.config/git config
rsync -av ~/.config/ideavim config
rsync -av ~/.config/lvim config
rsync -av ~/.config/less config
rsync -av ~/.config/neofetch config
rsync -av ~/.config/npm config
rsync -av ~/.config/mpd config
rsync -av ~/.config/PCSX2 config
rsync -av ~/.config/polybar config
rsync -av ~/.config/rmpc config
rsync -av ~/.config/rofi config
rsync -av ~/.config/starship config
rsync -av ~/.config/sxhkd config
rsync -av --exclude='plugins' ~/.config/tmux config
rsync -av ~/.config/wget config

rsync -av ~/Development/android_studio_settings.zip .
rsync -av ~/.config/Google/AndroidStudio2025.1.4/fileTemplates .


rsync -av \
    --include='Cheatsheets/***' \
    --include='DockerContainers/***' \
    --include='CodeGists/***' \
    --include='Gitignore-Templates/***' \
    --exclude='*' \
    ~/.utils/ ./utils/

## .ssh and .gnupg are sensitive folders, thus only save it locally

## vimium_c: Google Chrome > Vimium options > Export Settings
