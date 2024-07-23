#!/bin/bash

sed -i 's/CustomBackground="false"/CustomBackground="true"/' "$HOME/.config/sddm/themes/catppuccin-mocha/theme.conf"
sed -i 's/Background="backgrounds\/wall.jpg"/Background="backgrounds\/wall.png"/' "$HOME/.config/sddm/themes/catppuccin-mocha/theme.conf"

cp "$HOME/.config/sddm/assets/images/catppuccin-rainbow-arch.png" "$HOME/.config/sddm/themes/catppuccin-mocha/backgrounds/wall.png"

sudo rm '/usr/share/sddm/themes/catppuccin-mocha/' -rf || true
# sudo ln -s "$HOME/.config/sddm/themes/catppuccin-mocha" '/usr/share/sddm/themes/catppuccin-mocha'
sudo cp -rf "$HOME/.config/sddm/themes/catppuccin-mocha" '/usr/share/sddm/themes/catppuccin-mocha'

echo "
Edit '/etc/sddm.conf/'

[Theme]
Current=catppuccin-mocha
"
