#/bin/bash

pacman -S --needed git base-devel yay

yay_packages=(
	# 'authy-desktop-win32-bin'
	'google-chrome'
	'spotify'
	'visual-studio-code-bin'
)

yay -S $yay_packages --no-confirm
