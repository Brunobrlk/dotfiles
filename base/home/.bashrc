# System bash config (Fedora or Debian)
for f in /etc/bashrc /etc/bash.bashrc; do
  [ -f "$f" ] && . "$f"
done

# Stop if not interactive
case $- in
*i*) ;;
*) return ;;
esac

XDG_BASH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/bash"

# Aliases
if [ -f "$XDG_BASH_CONFIG/aliases.sh" ]; then
  . "$XDG_BASH_CONFIG/aliases.sh"
fi

# Environment
if [ -f "$XDG_BASH_CONFIG/env.sh" ]; then
  . "$XDG_BASH_CONFIG/env.sh"
fi

# Init
if [ -f "$XDG_BASH_CONFIG/init.sh" ]; then
  . "$XDG_BASH_CONFIG/init.sh"
fi

# Options
if [ -f "$XDG_BASH_CONFIG/options.sh" ]; then
  . "$XDG_BASH_CONFIG/options.sh"
fi
# BEGIN dev-genesis mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi
# END dev-genesis mise
