#!/usr/bin/env bash
# Author: Bruno Guimarães
# Description:
# Version: 1.0
# Last Updated: 2026-01-21

set -euo pipefail
IFS=$'\n\t'

# ──────────────────────────────────────────────────────────────────────────────
# Constants / Config
# ──────────────────────────────────────────────────────────────────────────────
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ──────────────────────────────────────────────────────────────────────────────
# Functions
# ──────────────────────────────────────────────────────────────────────────────
install_home() {
  # .bashrc, .profile and .utils/
  rsync -av "$SCRIPT_DIR/base/home/" "$HOME/"

  mv "$HOME/utils" "$HOME/.utils"
}

install_config() {
  rsync -av "$SCRIPT_DIR/base/config/" "$HOME/.config/"
}

install_desktop() {
  case "$XDG_CURRENT_DESKTOP" in
  *GNOME*)
    install_gnome
    ;;
  *KDE*)
    install_kde
    ;;
  *Cinnamon*)
    install_cinnamon
    ;;
  esac
}

install_display() {
  case "$XDG_SESSION_TYPE" in
  x11)
    install_xorg
    ;;
  wayland)
    install_wayland
    ;;
  esac
}

install_distro() {
  case "${ID}" in
  fedora)
    install_fedora
    ;;
  ubuntu)
    install_ubuntu
    ;;
  debian)
    install_debian
    ;;
  mint)
    install_mint
    ;;
  *)
    printf "Distro not supported"
    ;;
  esac
}

install_fedora() {
  # Config
  local fedora_dir="$SCRIPT_DIR/distro/fedora"
  rsync -av "$fedora_dir/config/" "$HOME/.config/"
}

install_ubuntu() {
  # Config
  local ubuntu_dir="$SCRIPT_DIR/distro/ubuntu"
  rsync -av "$ubuntu_dir/config/" "$HOME/.config/"
}

install_debian() {
  # Config
  local debian_dir="$SCRIPT_DIR/distro/debian"
  rsync -av "$debian_dir/config/" "$HOME/.config/"
}

install_mint() {
  # Config
  local mint_dir="$SCRIPT_DIR/distro/mint"
  rsync -av "$mint_dir/config/" "$HOME/.config/"
}

install_secrets() {
  local secure_dir="$HOME/.local/share/secure"
  if [[ ! -d "$HOME/.local/share/secure" ]]; then
    echo "Directory doesn't exist: $HOME/.local/share/secure"
    return 1
  fi

  # Add ssh keys
  mkdir -p "$HOME/.ssh"
  rsync -av "$secure_dir/ssh/" "$HOME/.ssh/"

  find "$HOME/.ssh" -maxdepth 1 -type f -name 'id_*' ! -name '*.pub' -perm /077 \
    -exec chmod 600 {} + \
    -exec ssh-add {} + || true

  # GPG
  mkdir -p "$HOME/.gnupg"
  chmod 700 "$HOME/.gnupg"
  rsync -av "$secure_dir/gpg/" "$HOME/.gnupg/"

  # Normalize permissions
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
