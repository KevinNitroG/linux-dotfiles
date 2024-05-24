#/bin/bash

read -p "MAKE SURE YOU RUN THIS SCRIPT IN USER PRIVILEDGE? (y/N) " user_input

case $user_input in 
  [yY] )
    continue
    ;;
  [nN] )
  * ) 
    exit 1
    ;;
esac

read -p "MAKE SURE YOU HAVE IMPORTED SSH, GPG KEY? (Y/n) " user_input

case $user_input in 
  [nN] )
    exit 1
    ;;
  [yY] )
  * ) 
    continue
    ;;
esac

# Install packages
sh -c "$(curl -fsSL https://raw.githubusercontent.com/KevinNitroG/linux-dotfiles/main/dot_install/packages.sh)"

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Chezmoi
chezmoi init --apply --verbose git@github.com:KevinNitroG/linux-dotfiles.git

# TPM for tmux
git clone https://github.com/tmux-plugins/tpm /.tmux/plugins/tpm

if bat -V &>/dev/null; then
  bat cache --build
fi

read -p "INSTALL HYPRDOTS? (Y/n) " user_input

case $user_input in 
  [nN] )
    continue
    ;;
	[yY] )
  * ) 
    git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
    cd ~/HyDE/Scripts
    ./install.sh
    ;;
esac

