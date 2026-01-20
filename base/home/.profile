# ~/.profile: executed for login shells
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# User specific environment and startup programs
[ -f "$HOME/.config/profile/init.sh" ] && . "$HOME/.config/profile/init.sh"
