# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

XDG_BASH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/bash"

# Aliases
if [ -f "$XDG_BASH_CONFIG/aliases" ]; then
    . "$XDG_BASH_CONFIG/aliases"
fi

# Environment
if [ -f "$XDG_BASH_CONFIG/env" ]; then
    . "$XDG_BASH_CONFIG/env"
fi

# Init
if [ -f "$XDG_BASH_CONFIG/init" ]; then
    . "$XDG_BASH_CONFIG/init"
fi

# Options
if [ -f "$XDG_BASH_CONFIG/options" ]; then
    . "$XDG_BASH_CONFIG/options"
fi
