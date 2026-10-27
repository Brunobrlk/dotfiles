# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# XDG overrides
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export SHIV_ROOT="${XDG_CACHE_HOME}/shiv"
export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"
export PLATFORMIO_CORE_DIR="${XDG_DATA_HOME}/platformio"
export COOKIECUTTER_CONFIG="${XDG_CONFIG_HOME}/cookiecutter/config.yml"
export AICHAT_ENV_FILE="${XDG_DATA_HOME}/secure/ai-keys-env"
export FZF_DEFAULT_OPTS_FILE="${XDG_CONFIG_HOME}/fzf/config"

# Dev
export EDITOR="nvim"
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
export ANDROID_SDK_ROOT="${HOME}/opt/android-sdk"
export ANDROID_HOME="${ANDROID_SDK_ROOT}" # Compatibility with tools that still read ANDROID_HOME
export ANDROID_USER_HOME="${XDG_CONFIG_HOME}/android"
export ANDROID_EMULATOR_HOME="${ANDROID_USER_HOME}"
export ANDROID_AVD_HOME="${ANDROID_EMULATOR_HOME}/avd"

# Desktop
export CHROME_EXECUTABLE="${XDG_DATA_HOME}/flatpak/exports/bin/com.google.Chrome"
export MPD_HOST="127.0.0.1"
export BITWARDEN_SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/bitwarden-ssh-agent.sock"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/bitwarden-ssh-agent.sock"

## Docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

## AI Agents
export GEMINI_CLI_HOME="$XDG_CONFIG_HOME/gemini"
export CODEX_HOME="$XDG_CONFIG_HOME/codex"

## Ruby
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"

## Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

## Ansible
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"
export ANSIBLE_LOCAL_TEMP="${XDG_CACHE_HOME}/ansible/tmp"
export ANSIBLE_SSH_CONTROL_PATH_DIR="${XDG_CACHE_HOME}/ansible/cp"
export ANSIBLE_ASYNC_DIR="${XDG_CACHE_HOME}/ansible_async"

# Path
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"
export PATH="${PATH}:${ANDROID_HOME}/emulator"
export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
export PATH="${PATH}:${HOME}/.local/bin"

# Debug
export DBG_PROFILE="Hello/from/envd"

# Base initialization
mkdir -p "${XDG_CACHE_HOME}/bash"

# Additional fragments: display server, desktop and other specific/variable configuration
for f in "${XDG_CONFIG_HOME}/profile/env.d/"*.sh; do
  [ -r "${f}" ] && . "${f}"
done
