#!/usr/bin/env bash

set -euo pipefail

ZSH_REPO_PATH=${ZSH_REPO_PATH:-"$HOME/.zsh"}

# Prompt for sudo password at the beginning of the script
sudo -v

# Update APT packages
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get clean
echo

# Update Snap packages
if command -v snap &>/dev/null; then
  sudo snap refresh
  echo
fi

# Update Oh My Zsh repository
git -C "$ZSH_REPO_PATH" stash
git -C "$ZSH_REPO_PATH" pull
echo

# Update Oh My Zsh plugins and themes
zsh -i -c "omz update"
echo

# Update Antidote plugins and themes
zsh -i -c "antidote update"
echo

# Update Mise and dependencies
mise self-update --yes
mise install --yes
echo
