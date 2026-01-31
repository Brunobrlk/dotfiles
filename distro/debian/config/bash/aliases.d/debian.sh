# Debian

alias cat='batcat -p'
alias bat='batcat'
alias apti='sudo apt install -y'
alias aptu='sudo apt update && sudo apt upgrade -y'
alias aptdu='sudo apt full-upgrade -y'
alias lsapt='ls /etc/apt/sources.list.d'
# Nala - Apt alternative
nala() {
    command nala "$@" || sudo nala "$@"
}
