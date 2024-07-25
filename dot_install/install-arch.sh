#/bin/bash

PACKAGES=(
  # Essentials
  'git'
  'google-chrome'
  'lazygit'
  'tmux'
  'wget'

  # Terminal
  'alacritty'

  # Text / Code Editor, IDE
  'neovim'
  'visual-studio-code-bin'

  # CLI Power Basics
  # 'aria2'
  # 'trash-cli'
  # 'xsel'
  'bat'
  'doggo'
  'exa'
  'fd'
  'fzf'
  'gh'
  'git-delta'
  'github-cli'
  'glow'
  'jq'
  'lazydocker'
  'rclone'
  'ripgrep'
  'sd'
  'thefuck'
  'tokei'
  'tree'
  'unzip'
  'wget'
  'xh'
  'yazi'
  'zip'
  'zoxide'

  # Development, languages, interpreters, compilers, etc
  # 'go'
  # 'pnpm'
  'clang'
  'cmake'
  'create-react-app'
  'docker'
  'gdb'
  'nodejs'
  'npm'
  'pyenv'
  'python-pip'
  'rustup'
  'yarn'

  # Formatter, Linter
  # 'actionlint'
  # 'eslint'
  # 'prettier'
  # 'ruff'

  # Security Utilities
  'gnupg'
  'openssl'

  # Monitoring, management and stats
  # 'speedtest-cli'
  'btop'
  'cronie'

  # CLI Fun
  'cowsay'
  'fastfetch'
  'lolcat'

  # Apps / Tools
  # 'authy-desktop-win32-bin'
  'gammastep'
  'obs-studio'
  'qbittorrent-enhanced'
  'rclone'
  'screenkey'
  'spotify'
  'vlc'

  # Fonts
  'noto-fonts-emoji'
  'ttf-google-sans'
  'ttf-jetbrains-mono-nerd'
  'ttf-nerd-fonts-symbols'

  # Other but IDK what it is
  # 'pacman-contrib' # For paccache
  'fuse3' # for rclone mount --daemon
  'gtk4'
  'lsb-release'
  'tree'
  'wtype'
)

PACKAGES_LAPTOP=(
  # 'gestures'
  # 'libinput-gestures'
  'tlp'
  'tlpui'
)

##########################################

# UPDATE SOURCES
echo 'UPDATE SOURCES...'
sudo pacman -Syu

# INSTALL YAY
echo 'INSTALLING YAY...'
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si && cd ..

# INSTALL PACKAGES
echo 'INSTALLING PACKAGES...'
yay -S $PACKAGES --noconfirm

# INSTALL CHEZMOI
echo 'INSTALLING OHMYZSH...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# INSTALL LAPTOP STUFF
read -p 'INSTALL LAPTOP STUFF? [y/N]: ' user_input

case $user_input in
[yY])
  echo 'INSTALLING LAPTOP STUFF...'
  yay -S $PACKAGES_LAPTOP --noconfirm
  ;;
esac

# INSTALL HYPRDOTS
read -p 'INSTALL HYPRDOTS? [Y/n]: ' user_input

case $user_input in
[nN]) ;;
*)
  git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
  cd ~/HyDE/Scripts
  ./install.sh
  ;;
esac
