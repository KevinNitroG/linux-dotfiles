#!/bin/bash

CACHE_DIR=${XDG_CACHE_HOME:-~/.cache}

sudo cp -rf "$HOME/.config/sddm/themes/catppuccin-mocha" "$CACHE_DIR/catppuccin-mocha"

sudo sed -i 's/CustomBackground="false"/CustomBackground="true"/' "$CACHE_DIR/catppuccin-mocha/theme.conf"
# sudo sed -i 's/Background="backgrounds\/wall.jpg"/Background="backgrounds\/wall.png"/' "$CACHE_DIR/catppuccin-mocha/theme.conf"

sudo cp "$HOME/assets/images/wallpaper/ArchMochaLavender(Base).jpg" "$HOME/.config/sddm/themes/catppuccin-mocha/backgrounds/wall.jpg"

sudo rm '/usr/share/sddm/themes/catppuccin-mocha/' -rf || true
# sudo ln -s "$HOME/.config/sddm/themes/catppuccin-mocha" '/usr/share/sddm/themes/catppuccin-mocha'
sudo cp -rf "$CACHE_DIR/catppuccin-mocha" '/usr/share/sddm/themes/catppuccin-mocha'

sudo rm "$CACHE_DIR/catppuccin-mocha/" -rf

echo "
Edit '/etc/sddm.conf/'

[Theme]
Current=catppuccin-mocha
"
