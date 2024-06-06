#!/bin/bash

url="https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json"

file="$HOME/.config/stylus/catppuccin.json"

wget -qO "$file" "$url"

sed -i 's/"name":"accentColor","value":null/"name":"accentColor","value":"lavender"/g' "$file"
