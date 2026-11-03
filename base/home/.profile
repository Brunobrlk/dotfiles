# ~/.profile: executed for login shells
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# Profile configuration directory
XDG_PROFILE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/profile"

# User specific environment and startup programs
[ -f "${XDG_PROFILE_CONFIG}/init.sh" ] && . "${XDG_PROFILE_CONFIG}/init.sh"
if [ -f "${XDG_PROFILE_CONFIG}/init.sh" ]; then
  . "${XDG_PROFILE_CONFIG}/init.sh"
fi
