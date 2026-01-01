#!/usr/bin/env bash
# Author: Bruno Guimarães
# Description:
# Version: 1.0
# Last Updated: 2025-12-22

set -euo pipefail
IFS=$'\n\t'

# ──────────────────────────────────────────────────────────────────────────────
# Constants / Config
# ──────────────────────────────────────────────────────────────────────────────
readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ──────────────────────────────────────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────────────────────────────────────
main() {
  rsync -av "$SCRIPT_DIR/.bashrc" "$HOME"
  rsync -av "$SCRIPT_DIR/.profile" "$HOME"
  rsync -av "$SCRIPT_DIR/.config/*" "$HOME/.config"
  rsync -av "$SCRIPT_DIR/.utils" "$HOME"
  rsync -av "$SCRIPT_DIR/vimium-options.json" "$HOME/Downloads"
  rsync -av "$SCRIPT_DIR/android-studio-settings.zip" "$HOME/Downloads"
}

# ──────────────────────────────────────────────────────────────────────────────
# Entry Point
# ──────────────────────────────────────────────────────────────────────────────
# Only run main if script is executed (not sourced)
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
