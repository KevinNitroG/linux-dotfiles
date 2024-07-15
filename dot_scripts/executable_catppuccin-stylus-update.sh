#!/bin/bash

URL="https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json"
FILE_DIR="$HOME/.config/stylus"
FILE_PATH="$FILE_DIR/catppuccin.json"

mkdir -p "$FILE_DIR"

if curl -V &>/dev/null; then
  curl -L -o "$FILE_PATH" "$URL"
elif wget -V &>/dev/null; then
  wget -qO "$FILE_PATH" "$URL"
fi

sed -i 's/"name":"accentColor","value":null/"name":"accentColor","value":"lavender"/g' "$FILE_PATH"
