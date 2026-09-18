#!/usr/bin/env bash
# Description: Clean neovim files to start a fresh installation

set -euo pipefail

rm -rf ~/.local/share/nvim-dev
rm -rf ~/.local/state/nvim-dev
rm -rf ~/.cache/nvim-dev
