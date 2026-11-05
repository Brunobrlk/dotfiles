# Profile configuration directory
XDG_PROFILE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/profile"

# Common environment
if [ -r "${XDG_PROFILE_CONFIG}/env.sh" ]; then
  . "${XDG_PROFILE_CONFIG}/env.sh"
fi

# Environment fragments
for f in "${XDG_PROFILE_CONFIG}"/env.d/*.sh; do
  if [ -r "${f}" ]; then
    . "${f}"
  fi
done

# Base initialization
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/bash"
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0"
