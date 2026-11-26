# This file must be sourced inside ~/.bash_profile:

# if [[ -r "$HOME/.server_profile" ]]; then
#   source "$HOME/.server_profile"
# fi

# =========================
# Aliases
# =========================

shopt -s expand_aliases

# Navigation - consider using directly chtmux, etc.
alias ..='cd ..'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias cdbin='cd ~/.local/bin'
alias cdconf='cd ~/.config'
alias cdstate='cd ~/.local/state'
alias cdshare='cd ~/.local/share'
alias cdcache='cd ~/.cache'
alias cdnv='cd ~/.config/nvim'
alias cdmain='cd "app/src/main/java/$(if [ -f app/build.gradle ]; then sed -n "s/applicationId[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle; else sed -n "s/applicationId[[:space:]]=[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle.kts; fi | sed -e "s/\./\//g" | sed -e "s/^[[:space:]]*//")"'
alias cdres='cd app/src/main/res'

# System information
alias ls-sys='inxi -v 8'
alias duh='du -ha --max-depth=1 | sort -rh'
alias ls-gpg="gpg --list-secret-keys --keyid-format=long"
psgrep() {
  ps aux | grep -- "$@"
}
p() {
  psgrep "$@"
}
psg() {
  psgrep "$@"
}
ls-path() {
  printf '%s\n' "$PATH" | tr ':' '\n'
}

# Networking
alias ls-ip='curl ipinfo.io && echo && echo "Local IP: $(hostname -I)"'
alias ls-ports='ss -tulanp'

# Python
alias py='python'
alias pyapp='python app.py'
alias pysrv='python -m http.server --bind 127.0.0.1'
alias pyvenv='[ -d .venv ] && { read -p "A virtual environment already exists. Do you want to recreate it? (y/n): " -n 1 -r && echo ""; [[ $REPLY =~ ^[Yy]$ ]] && rm -rf .venv; } || python -m venv .venv'
alias pyon='source .venv/bin/activate'
alias pyoff='deactivate'
alias uvi="uv pip install"

# Utils
alias rmt='trash-put'
alias mkdirs='mkdir -p'
alias src='source ~/.bashrc'
alias v='$EDITOR'
alias nv='nvim'
alias ls-ram="free -mh | bat -l cpuinfo -p"
alias ls-sensors="sensors | bat -l cpuinfo -p"
h() {
  "$@" --help 2>&1 | bat --plain --language=help
}

alias gemini='npx https://github.com/google-gemini/gemini-cli'

alias ls='ls --color=auto'
alias ll='ls -lhaF'
alias la='ls -AF'
alias l='ll'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Clone repository using name/repo pattern
gcl() {
  git clone "git@github.com:$1"
}

# Yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

get-mac() {
  MAC="52:54:00:$(python -c 'import secrets; print(":".join(f"{secrets.randbelow(256):02x}" for _ in range(3)))')"
  echo "$MAC"
}

# =========================
# Environment
# =========================

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"${HOME}/.cache"}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-"${HOME}/.local/state"}"
export EDITOR="nvim"

HISTSIZE="20000"
HISTFILESIZE="40000"
HISTCONTROL="ignoreboth"
HISTIGNORE='ls:ls *:ll:ll *:la:la *:clear'

# =========================
# Init
# =========================

## Maybe mise, fzf?

# =========================
# Options
# =========================

shopt -s histappend
shopt -s checkwinsize
