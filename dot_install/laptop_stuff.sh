#/bin/bash

pacman_packages=(
  tlp
)

yay_packages=(
  tlpui
  # libinput-gestures
)

pacman -S $pacman_packages --no-confirm
yay -S $yay_packages --no-confirm

sudo rm /etc/tlp.conf || true
sudo ln -s ~/.config/tlp/tlp.conf /etc/tlp.conf

# [re]start and setup auto start for libinput-gestures
# libinput-gestures-setup stop desktop autostart start
