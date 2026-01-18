# ~/.profile: executed for login shells

export DBG_PROFILE_HOME="Hello world from ~/.profile - it sources bashrc but probably exits before setting anything"
# Source .bashrc for consistency
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
