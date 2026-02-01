#!/usr/bin/env bash
# Author: Bruno Guimarães
# Description: Install dotfiles
# Version: 1.0
# Last Updated: 2026-01-21

set -euo pipefail
IFS=$'\n\t'

# ──────────────────────────────────────────────────────────────────────────────
# Constants / Config
# ──────────────────────────────────────────────────────────────────────────────
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source /etc/os-release

# ──────────────────────────────────────────────────────────────────────────────
# Functions
# ──────────────────────────────────────────────────────────────────────────────
install_home() {
  # .bashrc, .profile and .utils/
  rsync -av "$SCRIPT_DIR/base/home/" "$HOME/"

  if [[ -d "$HOME/utils" && ! -d "$HOME/.utils" ]]; then
    mv "$HOME/utils" "$HOME/.utils"
  fi
}

install_config() {
  mkdir -p "$HOME/.config"
  rsync -av "$SCRIPT_DIR/base/config/" "$HOME/.config/"
}

install_bash_scope() {
  local scope="$1" # desktop | display | distro
  local name="$2"  # gnome | kde | xorg | fedora | ...

  local src="$SCRIPT_DIR/$scope/$name/config/bash"

  [[ -d "$src" ]] || return 0

  mkdir -p "$HOME/.config/bash/env.d" "$HOME/.config/bash/aliases.d"

  rsync -av "$src/env.d/" "$HOME/.config/bash/env.d/" 2>/dev/null || true
  rsync -av "$src/aliases.d/" "$HOME/.config/bash/aliases.d/" 2>/dev/null || true
}

install_desktop() {
  case "$XDG_CURRENT_DESKTOP" in
    *GNOME*)    install_gnome ;;
    *KDE*)      install_kde ;;
    *Cinnamon*) install_cinnamon ;;
    *) logw "Unknown desktop: $XDG_CURRENT_DESKTOP" ;;
  esac
}

install_gnome() {
  install_bash_scope "desktop" "gnome"

  local dir="$SCRIPT_DIR/desktop/gnome"
  [[ -f "$dir/dconf.conf" ]] || return 0

  dconf load /org/gnome/ <"$dir/dconf.conf"
}

install_kde() {
  install_bash_scope "desktop" "kde"

  local dir="$SCRIPT_DIR/desktop/kde/config"
  [[ -d "$dir" ]] || return 0

  rsync -av "$dir/" "$HOME/.config/"

  # Reload KWin safely
  if command -v qdbus >/dev/null; then
    qdbus org.kde.KWin /KWin reconfigure || true
  fi
}

install_cinnamon() {
  install_bash_scope "desktop" "cinnamon"

  local dir="$SCRIPT_DIR/desktop/cinnamon"
  [[ -f "$dir/shortcuts.conf" ]] || return 0

  dconf load /org/cinnamon/desktop/keybindings/ \
    <"$dir/shortcuts.conf"
}

install_display() {
  case "$XDG_SESSION_TYPE" in
    x11)     install_xorg ;;
    wayland) install_wayland ;;
    *) logw "Unknown session type: $XDG_SESSION_TYPE" ;;
  esac
}

install_xorg() {
  install_bash_scope "display" "xorg"

  local dir="$SCRIPT_DIR/display/xorg/config"
  [[ -d "$dir" ]] || return 0

  rsync -av "$dir/" "$HOME/.config/"
}

install_wayland() {
  install_bash_scope "display" "wayland"
}

install_distro() {
  case "$ID" in
    fedora) install_distro_common "fedora" ;;
    debian) install_distro_common "debian" ;;
    ubuntu) install_distro_common "ubuntu" ;;
    mint)   install_distro_common "mint" ;;
    *) logw "Distro not supported: $ID" ;;
  esac
}

install_distro_common() {
  local distro="$1"

  install_bash_scope "distro" "$distro"

  local dir="$SCRIPT_DIR/distro/$distro/config"
  [[ -d "$dir" ]] || return 0

  rsync -av "$dir/" "$HOME/.config/"
}

install_secrets() {
  local secure_dir="$HOME/.local/share/secure"

  [[ -d "$secure_dir" ]] || {
    logw "Secure directory not found: $secure_dir"
    return 0
  }

  # SSH
  mkdir -p "$HOME/.ssh"
  rsync -av "$secure_dir/ssh/" "$HOME/.ssh/"

  chmod 700 "$HOME/.ssh"
  find "$HOME/.ssh" -type f ! -name '*.pub' -exec chmod 600 {} +

  if command -v ssh-add >/dev/null; then
    ssh-add "$HOME/.ssh"/id_* 2>/dev/null || true
  fi

  # GPG
  mkdir -p "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"
  rsync -av "$secure_dir/gpg/" "$HOME/.gnupg/"

  find "$HOME/.gnupg" -type d -exec chmod 700 {} +
  find "$HOME/.gnupg" -type f -exec chmod 600 {} +
}

# ──────────────────────────────────────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────────────────────────────────────
main() {
  install_home
  install_config
  install_desktop
  install_display
  install_distro
  install_secrets
}

# ──────────────────────────────────────────────────────────────────────────────
# Entry Point
# ──────────────────────────────────────────────────────────────────────────────
# Only run main if script is executed (not sourced)
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
