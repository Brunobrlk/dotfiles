#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

readonly BACKUP_ROOT="$HOME/.local/share/backup/dotfiles"

logi() { printf '\033[0;34m[BRLK INFO]\033[0m - %s\n' "$1"; }
loge() { printf '\033[0;31m[BRLK ERROR]\033[0m - %s\n' "$1" >&2; }
logs() { printf '\033[0;32m[BRLK SUCCESS]\033[0m - %s\n' "$1"; }

latest_backup() {
  ls -1 "$BACKUP_ROOT" | sort | tail -n 1
}

restore_file() {
  local src="$1"
  local dst="$2"

  [[ -f "$BACKUP_DIR/$src" ]] || return 0
  cp -a "$BACKUP_DIR/$src" "$dst"
}

restore_dir() {
  local src="$1"
  local dst="$2"

  [[ -d "$BACKUP_DIR/$src" ]] || return 0
  rm -rf "$dst"
  mkdir -p "$dst"
  rsync -a "$BACKUP_DIR/$src/" "$dst/"
}

main() {
  local backup_id="${1:-$(latest_backup)}"
  readonly BACKUP_DIR="$BACKUP_ROOT/$backup_id"

  [[ -d "$BACKUP_DIR" ]] || {
    loge "Backup not found: $BACKUP_DIR"
    exit 1
  }

  logi "Restoring from: $BACKUP_DIR"

  # Home files
  restore_file "bashrc" "$HOME/.bashrc"
  restore_file "profile" "$HOME/.profile"

  # Home dirs
  restore_dir "ssh" "$HOME/.ssh"
  restore_dir "gnupg" "$HOME/.gnupg"

  # Config
  restore_dir "config" "$HOME/.config"

  logs "Restore completed"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
