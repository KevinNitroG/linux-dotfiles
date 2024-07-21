#/bin/bash

CHEZMOI_DOTFILES='git@github.com:KevinNitroG/linux-dotfiles.git'

export DISTRO=$(lsb_release -i | awk '{print $NF}')

##########################################

PIP_PACKAGES=(
)

NPM_PACKAGES=(
  'commitizen'
)

##########################################

has() {
  command -v $1 >/dev/null
}

##########################################

read -p 'MAKE SURE YOU RUN THIS SCRIPT IN USER PRIVILEDGE? (y/N): ' user_input

case $user_input in
[yY]) ;;
*) exit 1 ;;
esac

read -p 'MAKE SURE YOU HAVE IMPORTED SSH, GPG KEY? (Y/n): ' user_input

case $user_input in
[nN]) ;;
*) continue ;;
esac

##########################################

case "$DISTRO" in
"Arch")
  bash <(curl -fsSL https://raw.githubusercontent.com/KevinNitroG/linux-dotfiles/main/dot_install/install-arch.sh)"
  ;;
*)
  echo 'Unsupport distro!'
  exit 1
  ;;
esac

##########################################

# RESTORE CHEZMOI
if has chezmoi; then
  echo 'CHEZMOI RESTORE...'
  chezmoi init --apply --verbose $CHEZMOI_DOTFILES
else
  echo 'CHEZMOI NOT FOUND!'
fi

# TPM FOR TMUX
if has tmux; then
  echo 'INSTALLING TPM FOR TMUX...'
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# PATCH SPOTIFY
if has spotify; then
  echo 'PATCHING SPOTIFY USING SPOTX...'
  bash <(curl -sSL https://spotx-official.github.io/run.sh)
fi

# BAT CACHE THEMES
if has bat; then
  bat cache --build
fi

# CONFIGURE TLP
if has tlp; then
  echo 'CONFIGURING TLP...'
  sudo rm /etc/tlp.conf || true
  sudo ln -s ~/.config/tlp/tlp.conf /etc/tlp.conf
fi

##########################################

read -p 'INSTALL OTHER PACKAGES? [Y/n]: ' user_input

case $user_input in
[yY])
  if has pip; then
    pip install "${PIP_PACKAGES[@]}"
  else
    echo 'No pip installed!'
  fi
  if has npm; then
    npm install -g "${NPM_PACKAGES[@]}"
  else
    echo 'No NPM installed!'
  fi
  ;;
esac
