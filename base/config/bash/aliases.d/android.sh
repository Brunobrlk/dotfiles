# Android Development

alias gw='./gradlew'
alias logcat='adb logcat'
alias devices='adb devices'

alias cllock='rm ~/.android/avd/*.avd/*.lock'

alias adblsperm='adb shell pm list permissions -d -g'
alias adbprint='adb emu screenrecord screenshot'

gwrun() {
  ./gradlew assembleDebug installDebug || return 1
  local pkg="$(grep 'namespace' "$(pwd)/app/build.gradle.kts" | sed -E 's/.*"([^"]+)".*/\1/')"
  adb shell monkey -p "$pkg" -c android.intent.category.LAUNCHER 1
  echo "Waiting for process: $pkg..."

  local pid=""
  for _ in {1..50}; do
    pid="$(adb shell pidof "$pkg" 2>/dev/null | tr -d '\r')"
    [[ -n "$pid" ]] && break
    sleep 0.1
  done

  if [[ -z "$pid" ]]; then
    echo "❌ App process did not start"
    return 1
  fi

  echo "✅ App started (pid=$pid)"
  adb logcat --pid="$pid"
}
adbaperm() {
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
adbrperm() {
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
adbidallperm() {
  local APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
  if [ -f "$APK_PATH" ]; then
    adb shell install -g $APK_PATH
  else
    echo "Please. Navigate to the root of your project first"
  fi
}
adbirallperm() {
  local APK_PATH="app/build/outputs/apk/release/app-release.apk"
  if [ -f "$APK_PATH" ]; then
    adb shell install -g $APK_PATH
  else
    echo "Please. Navigate to the root of your project first"
  fi
}
adbclsperm() {
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
adbdump() {
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
  local BLUE="\e[1;38;2;138;173;244m"  # #8aadf4
  local GREEN="\e[1;38;2;166;218;149m" # #a6da95
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
