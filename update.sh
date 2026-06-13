#!/usr/bin/env bash
# Author: Bruno Guimarães
# Description: Update dotfiles script
# Version: 1.1
# Last Updated: 2026-01-20

set -uo pipefail
IFS=$'\n\t'

# ──────────────────────────────────────────────────────────────────────────────
# Constants / Config
# ──────────────────────────────────────────────────────────────────────────────
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source /etc/os-release

# ──────────────────────────────────────────────────────────────────────────────
# Functions
# ──────────────────────────────────────────────────────────────────────────────
logi() { printf '\033[0;34m[BRLK INFO]\033[0m - %s\n' "$1"; }
logw() { printf '\033[1;33m[BRLK WARNING]\033[0m - %s\n' "$1"; }
logs() { printf '\033[0;32m[BRLK SUCCESS]\033[0m - %s\n' "$1"; }

update_home() {
  logi "Updating home files"
  mkdir -p "$SCRIPT_DIR/base/home"

  rsync -ai "$HOME/.bashrc" "$SCRIPT_DIR/base/home/"
  rsync -ai "$HOME/.profile" "$SCRIPT_DIR/base/home/"

  mkdir -p "$SCRIPT_DIR/base/home/opt/android-sdk/emulator/skins"
  rsync -ai "$HOME/opt/android-sdk/emulator/skins/" "$SCRIPT_DIR/base/home/opt/android-sdk/emulator/skins"

  mkdir -p "$SCRIPT_DIR/base/home/utils"
  rsync -ai \
    --include='Cheatsheets/***' \
    --include='DockerContainers/***' \
    --include='CodeGists/***' \
    --include='Gitignore-Templates/***' \
    --exclude='*' \
    "$HOME/.utils/" "$SCRIPT_DIR/base/home/utils/"
}

update_config() {
  logi "Updating config files"
  mkdir -p "$SCRIPT_DIR/base/config"

  rsync -ai "$HOME/.config/aichat" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/alacritty" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/asdf/tool-versions" "$SCRIPT_DIR/base/config/asdf/"

  mkdir -p "$SCRIPT_DIR/base/config/bash/aliases.d"
  rsync -ai "$HOME/.config/bash/aliases.d/android.sh" "$SCRIPT_DIR/base/config/bash/aliases.d/"

  rsync -ai \
    --exclude='env.d/' \
    --exclude='aliases.d/' \
    "$HOME/.config/bash" "$SCRIPT_DIR/base/config/"

  rsync -ai "$HOME/.config/bat" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/btop" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/environment.d" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/flameshot" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/git" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/ideavim" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/less" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/lvim" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/mise" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/mpd" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/mpv" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/neofetch" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/npm" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/nvim" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/PCSX2" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/polybar" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/profile" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/rclone" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/readline" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/rmpc" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/rofi" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/starship" "$SCRIPT_DIR/base/config/"

  rsync -ai --exclude='user/*.wants/' \
    "$HOME/.config/systemd" "$SCRIPT_DIR/base/config/"

  rsync -ai --exclude='plugins' \
    "$HOME/.config/tmux" "$SCRIPT_DIR/base/config/"

  rsync -ai "$HOME/.config/wget" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/yazi" "$SCRIPT_DIR/base/config/"
  rsync -ai "$HOME/.config/yt-dlp" "$SCRIPT_DIR/base/config/"
}

sync_bash_scope() {
  local scope="$1"   # desktop | display | distro
  local name="$2"    # gnome | kde | xorg | fedora | ...

  local base="$SCRIPT_DIR/$scope/$name/config/bash"

  mkdir -p "$base/env.d" "$base/aliases.d"

  rsync -ai "$HOME/.config/bash/env.d/$name.conf" \
    "$base/env.d/" 2>/dev/null || true

  rsync -ai "$HOME/.config/bash/aliases.d/$name.sh" \
    "$base/aliases.d/" 2>/dev/null || true
}

update_desktop() {
  logi "Updating desktop files"
  case "$XDG_CURRENT_DESKTOP" in
    *GNOME*)    update_gnome ;;
    *KDE*)      update_kde ;;
    *Cinnamon*) update_cinnamon ;;
    *) logw "Unknown desktop: $XDG_CURRENT_DESKTOP" ;;
  esac
}

update_gnome() {
  sync_bash_scope "desktop" "gnome"

  mkdir -p "$SCRIPT_DIR/desktop/gnome"
  dconf dump /org/gnome/ >"$SCRIPT_DIR/desktop/gnome/dconf.conf"
}

update_kde() {
  sync_bash_scope "desktop" "kde"

  mkdir -p "$SCRIPT_DIR/desktop/kde/config"

  rsync -ai \
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
  sync_bash_scope "desktop" "cinnamon"

  mkdir -p "$SCRIPT_DIR/desktop/cinnamon"
  dconf dump /org/cinnamon/desktop/keybindings/ \
    >"$SCRIPT_DIR/desktop/cinnamon/shortcuts.conf"
}

update_display() {
  logi "Updating display files"
  case "$XDG_SESSION_TYPE" in
    x11)     update_xorg ;;
    wayland) update_wayland ;;
    *) logw "Unknown session type: $XDG_SESSION_TYPE" ;;
  esac
}

update_xorg() {
  sync_bash_scope "display" "xorg"

  mkdir -p "$SCRIPT_DIR/display/xorg/config"

  rsync -ai "$HOME/.config/sxhkd" \
    "$SCRIPT_DIR/display/xorg/config/"

  rsync -ai "$HOME/.config/greenclip.toml" \
    "$SCRIPT_DIR/display/xorg/config/"
}

update_wayland() {
  sync_bash_scope "display" "wayland"
}

update_distro() {
  logi "Updating distro files"
  case "$ID" in
    fedora) sync_bash_scope "distro" "fedora";;
    debian) sync_bash_scope "distro" "debian" ;;
    ubuntu) sync_bash_scope "distro" "ubuntu" ;;
    mint)   sync_bash_scope "distro" "mint" ;;
    *) logw "Distro not supported: $ID" ;;
  esac
}

# ──────────────────────────────────────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────────────────────────────────────
main() {
  update_home
  update_config
  update_desktop
  update_display
  update_distro
  logs "Everything is up to date"
}

# ──────────────────────────────────────────────────────────────────────────────
# Entry Point
# ──────────────────────────────────────────────────────────────────────────────
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"
