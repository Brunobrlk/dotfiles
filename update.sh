#!/usr/bin/env bash
# Author: Bruno Guimarães
# Description: Update dotfiles script
# Version: 1.1
# Last Updated: 2026-01-20

set -uo pipefail
IFS=$'\n\t'

# ──────────────────────────────────────────────────────────────────────────────
# Constants
# ──────────────────────────────────────────────────────────────────────────────
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source /etc/os-release

# ────────────────────────────────────────────────────────────────────────────── 
# Functions
# ──────────────────────────────────────────────────────────────────────────────
logi() { printf '\033[0;34m[BRLK INFO]\033[0m - %s\n' "$1"; }

update_gnome() {
  mkdir -p "$SCRIPT_DIR/desktop/gnome/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/desktop/gnome/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/gnome.conf" \
    "$SCRIPT_DIR/desktop/gnome/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/gnome.sh" \
    "$SCRIPT_DIR/desktop/gnome/config/bash/aliases.d/"

  dconf dump /org/gnome/ >"$SCRIPT_DIR/desktop/gnome/dconf.conf"
}

update_kde() {
  mkdir -p "$SCRIPT_DIR/desktop/kde/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/desktop/kde/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/kde.conf" \
    "$SCRIPT_DIR/desktop/kde/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/kde.sh" \
    "$SCRIPT_DIR/desktop/kde/config/bash/aliases.d/"

  rsync -av \
    "$HOME/.config/kdeglobals" \
    "$HOME/.config/kglobalshortcutsrc" \
    "$HOME/.config/khotkeysrc" \
    "$HOME/.config/kwinrc" \
    "$HOME/.config/plasmarc" \
    "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" \
    "$HOME/.config/plasma-localerc" \
    "$HOME/.config/powerdevilrc" \
    "$SCRIPT_DIR/desktop/kde/config/"
}

update_cinnamon() {
  mkdir -p "$SCRIPT_DIR/desktop/cinnamon/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/desktop/cinnamon/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/cinnamon.conf" \
    "$SCRIPT_DIR/desktop/cinnamon/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/cinnamon.sh" \
    "$SCRIPT_DIR/desktop/cinnamon/config/bash/aliases.d/"

  dconf dump /org/cinnamon/desktop/keybindings/ \
    >"$SCRIPT_DIR/desktop/cinnamon/shortcuts.conf"
}

update_xorg() {
  mkdir -p "$SCRIPT_DIR/display/xorg/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/display/xorg/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/xorg.conf" \
    "$SCRIPT_DIR/display/xorg/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/xorg.sh" \
    "$SCRIPT_DIR/display/xorg/config/bash/aliases.d/"

  rsync -av "$HOME/.config/sxhkd" \
    "$SCRIPT_DIR/display/xorg/config/"

  rsync -av "$HOME/.config/greenclip.toml" \
    "$SCRIPT_DIR/display/xorg/config/"
}

update_wayland() {
  mkdir -p "$SCRIPT_DIR/display/wayland/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/display/wayland/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/wayland.conf" \
    "$SCRIPT_DIR/display/wayland/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/wayland.sh" \
    "$SCRIPT_DIR/display/wayland/config/bash/aliases.d/"
}

update_fedora() {
  mkdir -p "$SCRIPT_DIR/distro/fedora/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/distro/fedora/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/fedora.conf" \
    "$SCRIPT_DIR/distro/fedora/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/fedora.sh" \
    "$SCRIPT_DIR/distro/fedora/config/bash/aliases.d/"
}

update_debian() {
  mkdir -p "$SCRIPT_DIR/distro/debian/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/distro/debian/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/debian.conf" \
    "$SCRIPT_DIR/distro/debian/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/debian.sh" \
    "$SCRIPT_DIR/distro/debian/config/bash/aliases.d/"
}

update_mint() {
  mkdir -p "$SCRIPT_DIR/distro/mint/config/bash/env.d"
  mkdir -p "$SCRIPT_DIR/distro/mint/config/bash/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/mint.conf" \
    "$SCRIPT_DIR/distro/mint/config/bash/env.d/"

  rsync -av "$HOME/.config/bash/aliases.d/mint.sh" \
    "$SCRIPT_DIR/distro/mint/config/bash/aliases.d/"
}

update_home() {
  mkdir -p "$SCRIPT_DIR/base/home"

  rsync -av "$HOME/.bashrc" "$SCRIPT_DIR/base/home/"
  rsync -av "$HOME/.profile" "$SCRIPT_DIR/base/home/"
}

update_config() {
  mkdir -p "$SCRIPT_DIR/base/config"

  rsync -av "$HOME/.config/alacritty" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/asdf/tool-versions" "$SCRIPT_DIR/base/config/asdf/"


  mkdir -p "$SCRIPT_DIR/base/config/bash/aliases.d"
  rsync -av "$HOME/.config/bash/aliases.d/android.sh" "$SCRIPT_DIR/base/config/bash/aliases.d/"

  rsync -av \
    --exclude='env.d/' \
    --exclude='aliases.d/' \
    "$HOME/.config/bash" "$SCRIPT_DIR/base/config/"

  rsync -av "$HOME/.config/bat" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/btop" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/environment.d" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/flameshot" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/git" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/ideavim" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/less" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/lvim" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/mise" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/mpd" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/mpv" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/neofetch" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/npm" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/nvim" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/PCSX2" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/polybar" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/readline" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/rmpc" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/rofi" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/starship" "$SCRIPT_DIR/base/config/"

  rsync -av --exclude='user/*.wants/' \
    "$HOME/.config/systemd" "$SCRIPT_DIR/base/config/"

  rsync -av --exclude='plugins' \
    "$HOME/.config/tmux" "$SCRIPT_DIR/base/config/"

  rsync -av "$HOME/.config/wget" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/yt-dlp" "$SCRIPT_DIR/base/config/"
  rsync -av "$HOME/.config/yazi" "$SCRIPT_DIR/base/config/"
}

# ──────────────────────────────────────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────────────────────────────────────
main() {
  update_home
  update_config

  # ── Desktop Environment dispatch ────────────────────────────────────────────
  case "$XDG_CURRENT_DESKTOP" in
  *GNOME*)
    update_gnome
    ;;
  *KDE*)
    update_kde
    ;;
  *Cinnamon*)
    update_cinnamon
    ;;
  esac

  # ── Display Server dispatch ──────────────────────────────────────────────────
  case "$XDG_SESSION_TYPE" in
  x11)
    update_xorg
    ;;
  wayland)
    update_wayland
    ;;
  esac

  # ── Distro dispatch ──────────────────────────────────────────────────
  case "${ID}" in
  fedora)
    update_fedora
    ;;
  ubuntu)
    update_ubuntu
    ;;
  debian)
    update_debian
    ;;
  mint)
    update_mint
   ;;
  *)
    printf "Distro not supported"
    ;;
esac

  # ── Misc ─────────────────────────────────────────────────────────────────────
  rsync -av "$HOME/Development/android_studio_settings.zip" \
    "$SCRIPT_DIR/base/"

  mkdir -p "$SCRIPT_DIR/base/home/utils"
  rsync -av \
    --include='Cheatsheets/***' \
    --include='DockerContainers/***' \
    --include='CodeGists/***' \
    --include='Gitignore-Templates/***' \
    --exclude='*' \
    "$HOME/.utils/" "$SCRIPT_DIR/base/home/utils/"

  ## .ssh and .gnupg are sensitive folders, thus only save it locally

  ## vimium_c: Google Chrome > Vimium options > Export Settings
}

# ──────────────────────────────────────────────────────────────────────────────
# Entry Point
# ──────────────────────────────────────────────────────────────────────────────
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"
