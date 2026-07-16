# Wayland

cpbuff() {
  if [ "$#" -eq 1 ]; then
    wl-copy < "$1"
  else
    wl-copy
  fi
}
