# .bash_aliases - Custom Bash Aliases
# Author: Bruno Guimarães
# GitHub: https://github.com/Brunobrlk

# Notes:
# ch - Change
# dk - Docker

shopt -s expand_aliases

# Navigation - consider using directly chtmux, etc.
alias ..='cd ..'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias cdmobile='cd ~/Development/Mobile'
alias cdandroid='cd ~/Development/Mobile/Android'
alias cdflutter='cd ~/Development/Mobile/Flutter'
alias cdsrc='cd ~/Src'
alias cdconf='cd ~/.config'
alias cdbin='cd ~/.local/bin'
alias cdnv='cd ~/.config/nvim'
alias cdlv='cd ~/.config/lvim'
alias cdbash='cd ~/.config/bash'
alias cdrofi='cd ~/.config/rofi'
alias cdtmux='cd ~/.config/tmux'
alias cdsxh='cd ~/.config/sxhkd'
alias cdnotes='cd ~/.utils/Notes'
alias cdpy='cd ~/Development/Python'
alias cdpro='cd ~/Development/Projects'
alias cdtest='cd ~/Notes/Test'
alias cdwork='cd ~/Development/Work'
alias cdscripts='cd ~/Development/BashScripts'
alias cdasconf='cd ~/.config/Google/AndroidStudio2024.2'
alias cdmain='cd "app/src/main/java/$(if [ -f app/build.gradle ]; then sed -n "s/applicationId[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle; else sed -n "s/applicationId[[:space:]]=[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle.kts; fi | sed -e "s/\./\//g" | sed -e "s/^[[:space:]]*//")"'
alias cdres='cd app/src/main/res'

# Edit Files
alias chbash='$EDITOR ~/.bashrc'
alias chalias='$EDITOR ~/.config/bash/aliases'
alias chenv='$EDITOR ~/.config/bash/env'
alias cbox='$EDITOR ~/.utils/CodeGists/'

# Docker
alias dk='docker'
alias dkrun='docker run'
alias dkexec='docker exec -it'
alias dklog='docker logs'
alias dkps='docker ps'
alias dkpsa='docker ps -a'

alias dkrm='docker rm'
alias dkrmall='docker rm $(docker ps -a -q)'

alias dkstop='docker stop'
alias dkstopall='docker stop $(docker ps -a -q)'

alias dkimg='docker image'
alias dkimgs='docker images'
alias dkrmimg='docker rmi'
alias dkrmimgs='docker rmi $(docker images --quiet --filter "dangling=true")'

alias dkvol='docker volume'
alias dkvols='docker volume ls'
alias dkrmvol='docker volume rm'
alias dkrmvols='docker volume rm $(docker volume ls -q)'

alias compose='docker-compose'
alias dkup='docker-compose up'
alias dkdown='docker-compose down'
# System information
alias basedon='cat /etc/upstream-release/lsb-release'
alias sysinfo='inxi -v 8'
alias duh='du -ha --max-depth=1 | sort -rh'
alias p="ps aux | grep $1" # Seems like direct arguments only works for | grep

# Networking
alias ipinfo='curl ipinfo.io && echo && echo "Local IP: $(hostname -I)"'
alias ports='netstat -tulanp'
alias wports='watch -n 1 netstat -tulanp'

# Python
alias py='python'
alias pyapp='python app.py'
alias pysrv='python -m SimpleHTTPServer'
alias pyvenv='[ -d .venv ] && { read -p "A virtual environment already exists. Do you want to recreate it? (y/n): " -n 1 -r && echo ""; [[ $REPLY =~ ^[Yy]$ ]] && rm -rf .venv; } || python -m venv .venv'
alias pyon='source .venv/bin/activate'
alias pyoff='deactivate'

# Terminal Translator
alias pt='trans :pt'
alias en='trans'

# Utils
# alias rm='trash-put'
alias mkdirs='mkdir -p'
alias src='source ~/.bashrc'
alias lv='lvim'
alias nv='nvim'
alias v='$EDITOR'
alias bat='batcat'
alias cat='batcat -p'
alias whatapp='xprop | grep WM_CLASS'
alias apti='sudo apt install -y'
alias aptu='sudo apt update'
alias aptdu='sudo apt dist-upgrade -y'
alias whether='curl wttr.in/Barreiras'
alias psg="ps aux | grep $1"
alias ram="free -mh | bat -l cpuinfo -p"
alias sensors="sensors | bat -l cpuinfo -p"
h(){
    "$@" --help 2>&1 | bat --plain --language=help
}

# Download the best video quality + best audio to ~/Videos dir
alias ytv='yt-dlp -f "bv*+ba/b" -P "$HOME/Videos"'

## Download the best video quality(With subtitles in english) + best audio to ~/Videos dir
alias ytvonly='yt-dlp --no-write-subs --no-write-auto-subs -f "bv*+ba/b" -P "$HOME/Videos"'

# Download the best audio quality to Music dir
alias ytaonly='yt-dlp -t mp3 -P "$HOME/Music"'

## Download the best audio quality to Music dir with thumbnail
alias yta='yt-dlp -t mp3 --embed-thumbnail --no-write-subs --no-write-auto-subs -P "$HOME/Music"'

alias screenlight='xrandr --output HDMI-0 --brightness'
alias gemini='npx https://github.com/google-gemini/gemini-cli'

alias lsapt='ls /etc/apt/sources.list.d'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so: $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cpbuff="xclip -selection clipboard"

# Android Development
alias gw='./gradlew'
alias gwrun='gw=./gradlew && $gw assembleDebug && $gw installDebug && pkg="com.example.$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')" && adb shell am start -W "$pkg/$pkg.MainActivity" && logcat --pid=$(adb shell pidof $pkg)'
alias logcat='adb logcat'
alias devices='adb devices'

alias cllock='rm ~/.android/avd/*.avd/*.lock'

alias adblsperm='adb shell pm list permissions -d -g'
alias adbprint='adb emu screenrecord screenshot'

adbaperm(){
  if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
    echo "Incorrect number of arguments"
    return 1
  fi

  if [ "$#" -eq 1 ]; then
    if [ -f "app/build.gradle.kts" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]=[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle.kts | sed -e "s/^[[:space:]]*//")
    elif [ -f "app/build.gradle" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle | sed -e "s/^[[:space:]]*//")
    else
      echo "You should provide the package name or run this command in the root of your project"
      return 1
    fi
    local perm="$1"
    shift
  fi

  if [ "$#" -eq 2 ]; then
    local pkg="$1"
    local perm="$2"
    shift 2
  fi
  adb shell pm grant $pkg $perm
}
adbrperm(){
  if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
    echo "Incorrect number of arguments"
    return 1
  fi

  if [ "$#" -eq 1 ]; then
    if [ -f "app/build.gradle.kts" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]=[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle.kts | sed -e "s/^[[:space:]]*//")
    elif [ -f "app/build.gradle" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle | sed -e "s/^[[:space:]]*//")
    else
      echo "You should provide the package name or run this command in the root of your project"
      return 1
    fi
    local perm="$1"
    shift
  fi

  if [ "$#" -eq 2 ]; then
    local pkg="$1"
    local perm="$2"
    shift 2
  fi
  adb shell pm revoke $pkg $perm
}
adbidallperm(){
  local APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
  if [ -f "$APK_PATH" ]; then
    adb shell install -g $APK_PATH
  else
    echo "Please. Navigate to the root of your project first"
  fi
}
adbirallperm(){
  local APK_PATH="app/build/outputs/apk/release/app-release.apk"
  if [ -f "$APK_PATH" ]; then
    adb shell install -g $APK_PATH
  else
    echo "Please. Navigate to the root of your project first"
  fi
}
adbclsperm(){
  if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
    echo "Incorrect number of arguments"
    return 1
  fi

  if [ "$#" -eq 1 ]; then
    if [ -f "app/build.gradle.kts" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]=[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle.kts | sed -e "s/^[[:space:]]*//")
    elif [ -f "app/build.gradle" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle | sed -e "s/^[[:space:]]*//")
    else
      echo "You should provide the package name or run this command in the root of your project"
      return 1
    fi
    local perm="$1"
    shift
  fi

  if [ "$#" -eq 2 ]; then
    local pkg="$1"
    local perm="$2"
    shift 2
  fi
  adb shell pm clear-permission-flags $pkg $perm user-set user-fixed "$@"
}
adbdump(){
  if [ "$#" -eq 0 ]; then
    if [ -f "app/build.gradle.kts" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]=[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle.kts | sed -e "s/^[[:space:]]*//")
    elif [ -f "app/build.gradle" ]; then
      local pkg=$(sed -n "s/applicationId[[:space:]]*\"\\([^\"]*\\)\"/\\1/p" app/build.gradle | sed -e "s/^[[:space:]]*//")
    else
      echo "You should provide the package name or run this command in the root of your project"
      return 1
    fi
  else
    local pkg="$1"
  fi
  adb shell dumpsys package $pkg
}
lsandroid() {
  local BLUE="\e[1;38;2;138;173;244m"   # #8aadf4
  local GREEN="\e[1;38;2;166;218;149m"  # #a6da95
  local RESET="\e[0m"

  local classics=()
  local composes=()

  for d in */; do
    [ -d "$d" ] || continue
    d="${d%/}"

    local gradle_file
    gradle_file=$(find "$d" -maxdepth 1 -type f -name "build.gradle*" | head -n 1)

    if [ -n "$gradle_file" ] && grep -q "compose" "$gradle_file"; then
      composes+=("$d")
    else
      classics+=("$d")
    fi
  done

  # Print Classic first
  for d in "${classics[@]}"; do
    echo -e "${BLUE}${d}${RESET}"
  done

  # Then Compose
  for d in "${composes[@]}"; do
    echo -e "${GREEN}${d} (Compose)"
  done
}

# Markdown viewer
md(){
    pandoc $1 > /tmp/$1.html
    xdg-open /tmp/$1.html
}

# Clone repository using name/repo pattern
gcl(){
    git clone git@github.com:$1
}

# Nala - Apt alternative
nala() {
    command nala "$@" || sudo nala "$@"
}

# Yazi
function y(){
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
