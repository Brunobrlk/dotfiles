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

  ## .ssh and .gnupg are sensitive folders, thus only save it locally

  ## vimium_c: Google Chrome > Vimium options > Export Settings
}

install_config() {
  # Maybe a backup before?
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

install_secrets(){
  # Add ssh keys
  mkdir -p "$HOME/.ssh"
  rsync -av --exclude=known* "$HOME/.local/share/secure/ssh/" "$HOME/.ssh/"

  find "$HOME/.ssh" -maxdepth 1 -type f -name 'id_*' ! -name '*.pub' -perm /077 \
    -exec chmod 600 {} + \
    -exec ssh-add {} + || true


  # GPG
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
