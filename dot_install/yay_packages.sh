#/bin/bash

pacman -S --needed git base-devel yay

yay_packages=(
  google-chrome
  visual-studio-code-bin
)

yay -S $yay_packages --no-confirm
