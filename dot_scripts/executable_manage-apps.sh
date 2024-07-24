#!/bin/bash

_FZF_DEFAULT_OPTS="
--bind ctrl-a:toggle-all
--header-first
--preview-window right,70%
"

show_help() {
  cat <<EOF
Script name: ${0}

Description: To install, update, uninstall apps.
Require: fzf

Author: Kevin Nitro (KevinNitroG)

Usage: ${0} [OPTION]

Options:
  -i, --install      Perform 'install' apps
  -u, --update       Perform 'update' apps
  -U, --uninstall    Perform 'uninstall' apps
  -help, --help      Display this help

Examples:
  ${0} -i
  ${0} -u
  ${0} -U
EOF
}

has() {
  command -v $1 >/dev/null
}

manage_app() {
  local action=$1
  local distro
  distro=$(lsb_release -i | awk '{print $NF}')

  case "$distro" in
  'Arch')
    if has yay; then
      case "$action" in
      'install')
        yay -Sy
        yay -Slq | sort -u | fzf --multi --header 'INSTALL APPS' --preview 'yay -Sii {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro yay -S --needed
        ;;
      'update')
        yay -Sy
        yay -Qq | fzf --multi --header 'UPDATE APPS' --preview 'yay -Sii {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro yay -S --needed
        ;;
      'uninstall')
        yay -Qq | fzf --multi --header 'UNINSTALL APPS' --preview 'yay -Sii {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro yay -Rs --confirm
        ;;
      esac
    else
      case "$action" in
      'install')
        sudo pacman -Sy
        pacman -Slq | fzf --multi --header 'INSTALL APPS' --preview 'pacman -Sii {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo pacman -S --needed
        ;;
      'update')
        sudo pacman -Sy
        pacman -Qq | fzf --multi --header 'UPDATE APPS' --preview 'pacman -Sii {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo pacman -S --needed
        ;;
      'uninstall')
        yay -Qq | fzf --multi --header 'UNINSTALL APPS' --preview 'yay -Sii {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro yay -Rs --confirm
        ;;
      esac
    fi
    ;;
  'Ubuntu' | 'Debian')
    case "$action" in
    'install')
      sudo apt update
      apt list --installed | fzf --multi --header 'UNINSTALL APPS' --preview 'apt info {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo apt uninstall
      ;;
    'update')
      sudo apt update
      apt list --installed | fzf --multi --header 'UPDATE APPS' --preview 'apt info {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo apt install
      ;;
    'uninstall')
      apt list --installed | fzf --multi --header 'UNINSTALL APPS' --preview 'apt info {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo apt uninstall
      ;;
    esac
    ;;
  'Fedora' | 'CentOS' | 'RedHat')
    case "$action" in
    'install')
      dnf list --available | fzf --multi --header 'INSTALL APPS' --preview 'dnf info {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo dnf install
      ;;
    'update')
      sudo apt update
      dnf list --installed | fzf --multi --header 'UPDATE APPS' --preview 'dnf info {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo dnf install
      ;;
    'uninstall')
      dnf list --installed | fzf --multi --header 'UNINSTALL APPS' --preview 'dnf info {1}' ${_FZF_DEFAULT_OPTS[@]} | xargs -ro sudo dnf uninstall
      ;;
    esac
    ;;
  *)
    echo "Unsupported distribution: $distro"
    return 1
    ;;
  esac
}

if [ $# -eq 0 ]; then
  show_help
  exit 0
fi

case $1 in
-i | --install) manage_app 'install' ;;
-u | --update) manage_app 'update' ;;
-U | --uninstall) manage_app 'uninstall' ;;
-h | --help) show_help ;;
*)
  echo -e "Error: Unknown option '$1'"
  echo
  show_help
  exit 1
  ;;
esac
