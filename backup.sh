#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
readonly BACKUP_ROOT="$HOME/.local/share/backup/dotfiles"
readonly BACKUP_DIR="$BACKUP_ROOT/$TIMESTAMP"

logs() { printf '\033[0;32m[BRLK SUCCESS]\033[0m - %s\n' "$1"; }

backup_file() {
  local src="$1"
  local dst="$2"

  [[ -f "$src" ]] || return 0
  mkdir -p "$BACKUP_DIR"
  cp -a "$src" "$BACKUP_DIR/$dst"
}

backup_dir() {
  local src="$1"
  local dst="$2"

  [[ -d "$src" ]] || return 0
  mkdir -p "$BACKUP_DIR/$dst"
  rsync -a "$src/" "$BACKUP_DIR/$dst/"
}

main() {
  mkdir -p "$BACKUP_DIR"

  # Home files
  backup_file "$HOME/.bashrc" "bashrc"
  backup_file "$HOME/.profile" "profile"

  # Home dirs
  backup_dir "$HOME/.ssh" "ssh"
  backup_dir "$HOME/.gnupg" "gnupg"

  # Config
  backup_dir "$HOME/.config" "config"

  logs "Backup completed at: $BACKUP_DIR"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
