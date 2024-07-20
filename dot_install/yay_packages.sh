#/bin/bash

pacman -S --needed git base-devel yay

yay_packages=(
  # 'authy-desktop-win32-bin'
  'doggo'
  'google-chrome'
  'spotify'
  'ttf-google-sans'
  'visual-studio-code-bin'
)

yay -S $yay_packages --no-confirm
