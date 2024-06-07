#!/usr/bin/env bash

# Source: https://github.com/Lissy93/dotfiles/blob/master/scripts/installs/arch-pacman.sh

################################################################
# 📜 Arch Linux, Pacman Package Install / Update Script        #
################################################################
# Installs listed packages on Arch-based systems via Pacman    #
# Also updates the cache database and existing applications    #
# Confirms apps aren't installed via different package manager #
# Doesn't include desktop apps, that're managed via Flatpak    #
# Apps are sorted by category, and arranged alphabetically     #
# Be sure to delete / comment out anything you do not need     #
# For more info, see: https://wiki.archlinux.org/title/Pacman  #
################################################################
# MIT Licensed (C) Alicia Sykes 2022 <https://aliciasykes.com> #
################################################################

# Apps to be installed via Pacman
pacman_apps=(
	# Essentials
	'git'
	'lazygit'
	'tmux'
	'wget'

	# Terminal
	'alacritty'

	# Text / Code Editor, IDE
	'neovim'

	# CLI Power Basics
	# 'aria2'
	# 'trash-cli'
	# 'xsel'
	'bat'
	'exa'
	'fd'
	'fzf'
	'git-delta'
	'github-cli'
	'jq'
	'lazydocker'
	'rclone'
	'ripgrep'
	'sd'
	'thefuck'
	'tokei'
	'tree'
	'unzip'
	'xh'
	'yazi'
	'zoxide'
	'wget'

	# Development, languages, interpreters, compilers, etc
	# 'go'
	'clang'
	'cmake'
	'docker'
	'gdb'
	'nodejs'
	'npm'
	'python-pip'
	'rustup'

	# Formatter, Linter
	# 'actionlint'
	# 'eslint'
	# 'prettier'
	# 'ruff'

	# Security Utilities
	'gnupg'
	'openssl'

	# Monitoring, management and stats
	'btop'
	# 'speedtest-cli'

	# CLI Fun
	'cowsay'
	'fastfetch'
	'lolcat'

	# Apps / Tools
	'gammastep'
	'obs-studio'
	'screenkey'
	'vlc'

	# Fonts
	'ttf-nerd-fonts-symbols'
	'ttf-jetbrains-mono-nerd'
	'noto-fonts-emoji'

	# Other but IDK what it is :)
	'lsb-release'
	'pacman-contrib' # For paccache
	'wtype'
	'tree'
)

# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
CYAN_B='\033[1;96m'
LIGHT='\x1b[2m'
RESET='\033[0m'

PROMPT_TIMEOUT=15 # When user is prompted for input, skip after x seconds

# If set to auto-yes - then don't wait for user reply
if [[ $* == *"--auto-yes"* ]]; then
	PROMPT_TIMEOUT=0
	REPLY='Y'
fi

# Print intro message
echo -e "\n${PURPLE}Starting Arch package install / update script"
echo -e "${LIGHT}The following script is for Arch / Arch-based headless systems, and will"
echo -e "update database, upgrade packages, clear cache then install all listed CLI apps."
echo -e "${YELLOW}Before proceeding, ensure your happy with all the packages listed in \e[4m${0##*/}"
echo -e "${RESET}"

# Check if running as root, and prompt for password if not
if [ "$EUID" -ne 0 ]; then
	echo -e "${PURPLE}Elevated permissions are required to adjust system settings."
	echo -e "${CYAN_B}Please enter your password...${RESET}"
	sudo -v
	if [ $? -eq 1 ]; then
		echo -e "${YELLOW}Exiting, as not being run as sudo${RESET}"
		exit 1
	fi
fi

# Check pacman actually installed
if ! hash pacman 2>/dev/null; then
	echo "${YELLOW_B}Pacman doesn't seem to be present on your system. Exiting...${RESET}"
	exit 1
fi

# Prompt user to update package database
echo -e "${CYAN_B}Would you like to update package database? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo -e "${PURPLE}Updating database...${RESET}"
	sudo pacman -Syy --noconfirm
fi

# Prompt user to upgrade currently installed packages
echo -e "${CYAN_B}Would you like to upgrade currently installed packages? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo -e "${PURPLE}Upgrading installed packages...${RESET}"
	sudo pacman -Syu --noconfirm
fi

# Prompt user to clear old package caches
echo -e "${CYAN_B}Would you like to clear unused package caches? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo -e "${PURPLE}Freeing up disk space...${RESET}"
	sudo pacman -Sc --noconfirm
	paccache -r
fi

# Prompt user to install all listed apps
echo -e "${CYAN_B}Would you like to install listed apps? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo -e "${PURPLE}Starting install...${RESET}"
	for app in ${pacman_apps[@]}; do
		if hash "${app}" 2>/dev/null; then
			echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed${RESET}"
		elif [[ $(echo $(pacman -Qk $(echo $app | tr 'A-Z' 'a-z') 2>/dev/null)) == *"total files"* ]]; then
			echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed via Pacman${RESET}"
		elif hash flatpak 2>/dev/null && [[ ! -z $(echo $(flatpak list --columns=ref | grep $app)) ]]; then
			echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed via Flatpak${RESET}"
		else
			echo -e "${PURPLE}[Installing]${LIGHT} Downloading ${app}...${RESET}"
			sudo pacman -S ${app} --needed --noconfirm
		fi
	done
fi

echo -e "${PURPLE}Finished installing / updating Arch packages.${RESET}"

# EOF
