#/bin/bash

pacman -S --needed git base-devel yay

yay_packages=(
	'google-chrome'
	'visual-studio-code-bin'
	'spotify'
)

yay -S $yay_packages --no-confirm
