#/bin/bash

pacman -S tlp --no-confirm
yay -S tlpui --no-confirm

sudo rm /etc/tlp.conf || true
sudo ln -s ~/.config/tlp/tlp.conf /etc/tlp.conf
