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

update_home() {
  mkdir -p "$SCRIPT_DIR/base/home"

  rsync -av "$HOME/.bashrc" "$SCRIPT_DIR/base/home/"
  rsync -av "$HOME/.profile" "$SCRIPT_DIR/base/home/"

  mkdir -p "$SCRIPT_DIR/base/home/utils"
  rsync -av \
    --include='Cheatsheets/***' \
    --include='DockerContainers/***' \
    --include='CodeGists/***' \
    --include='Gitignore-Templates/***' \
    --exclude='*' \
    "$HOME/.utils/" "$SCRIPT_DIR/base/home/utils/"
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

sync_bash_scope() {
  local scope="$1"   # desktop | display | distro
  local name="$2"    # gnome | kde | xorg | fedora | ...

  local base="$SCRIPT_DIR/$scope/$name/config/bash"

  mkdir -p "$base/env.d" "$base/aliases.d"

  rsync -av "$HOME/.config/bash/env.d/$name.conf" \
    "$base/env.d/" 2>/dev/null || true

  rsync -av "$HOME/.config/bash/aliases.d/$name.sh" \
    "$base/aliases.d/" 2>/dev/null || true
}

update_desktop() {
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
  sync_bash_scope "desktop" "cinnamon"

  mkdir -p "$SCRIPT_DIR/desktop/cinnamon"
  dconf dump /org/cinnamon/desktop/keybindings/ \
    >"$SCRIPT_DIR/desktop/cinnamon/shortcuts.conf"
}

update_display() {
  case "$XDG_SESSION_TYPE" in
    x11)     update_xorg ;;
    wayland) update_wayland ;;
    *) logw "Unknown session type: $XDG_SESSION_TYPE" ;;
  esac
}

update_xorg() {
  sync_bash_scope "display" "xorg"

  mkdir -p "$SCRIPT_DIR/display/xorg/config"

  rsync -av "$HOME/.config/sxhkd" \
    "$SCRIPT_DIR/display/xorg/config/"

  rsync -av "$HOME/.config/greenclip.toml" \
    "$SCRIPT_DIR/display/xorg/config/"
}

update_wayland() {
  sync_bash_scope "display" "wayland"
}

update_distro() {
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
}

# ──────────────────────────────────────────────────────────────────────────────
# Entry Point
# ──────────────────────────────────────────────────────────────────────────────
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"
