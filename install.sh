#!/bin/bash

set -euo pipefail

ZSH_INITIAL_REPO_PATH=${ZSH_INITIAL_REPO_PATH:-"$HOME/zsh"}
ZSH_REPO_PATH=${ZSH_REPO_PATH:-"$HOME/.zsh"}
ZSH_CONFIG_PATH=$ZSH_REPO_PATH/config/zsh
ZSH_MISE_CONFIG_PATH=$ZSH_REPO_PATH/config/mise
ZSH_FONTS_PATH=$ZSH_REPO_PATH/fonts

LOCAL_FONT_PATH=$HOME/.local/share/fonts
MISE_BIN_PATH=$HOME/.local/bin/mise

OHMYZSH_PATH=${OHMYZSH_PATH:-"$HOME/.oh-my-zsh"}
OHMYZSH_INSTALL_SCRIPT=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

ANTIDOTE_PATH=${ANTIDOTE_PATH:-"$HOME/.antidote"}
ANTIDOTE_REPO=https://github.com/mattmc3/antidote.git

link_file() {
  local source=$1
  local target=$2

  if [ ! -L "$target" ] || [ "$(readlink "$target")" != "$source" ]; then
    rm -f "$target"
    ln -sf "$source" "$target"
  fi
}

# Install dependencies
APT_PACKAGES=("curl" "git" "zsh" "fontconfig")
if ! dpkg -s "${APT_PACKAGES[@]}" >/dev/null 2>&1; then
  echo "Install dependencies..."
  sudo apt-get update
  sudo apt-get install -y "${APT_PACKAGES[@]}"
  echo
fi

# Install ohmyzsh
echo "Install oh-my-zsh..."
if [ ! -d "$OHMYZSH_PATH" ]; then
  sh -c "$(curl -fsSL $OHMYZSH_INSTALL_SCRIPT)" "" --unattended
else
  echo "oh-my-zsh already installed. Skipping..."
fi
echo

# Install antidote
echo "Install antidote..."
if [ ! -d "$ANTIDOTE_PATH" ]; then
  git clone --depth=1 "$ANTIDOTE_REPO" "$ANTIDOTE_PATH"
else
  echo "antidote already installed. Skipping..."
fi
echo

# Cleanup zsh folder
if [ ! -d "$ZSH_REPO_PATH" ] && [ -d "$ZSH_INITIAL_REPO_PATH" ]; then
  echo "Moving the zsh folder to $ZSH_REPO_PATH..."
  mv "$ZSH_INITIAL_REPO_PATH" "$ZSH_REPO_PATH"
  echo
fi

# Remove the zsh config and replace it with a symlink
echo "Replace the zsh config with a symlink..."
if [ -L "$HOME/.zshrc" ] && [ "$(readlink "$HOME/.zshrc")" = "$ZSH_CONFIG_PATH/zshrc" ]; then
  echo "Symlink already points to the correct location. Skipping..."
else
  link_file "$ZSH_CONFIG_PATH/zshrc" "$HOME/.zshrc"
fi
echo

# Set zsh as default shell if it isnt
CURRENT_SHELL=$(basename "$SHELL")

if [ "$CURRENT_SHELL" != "zsh" ]; then
  echo "The current shell is not zsh. Changing default shell to zsh. Please enter your user password."
  chsh -s "$(which zsh)"
  echo "Default shell changed to zsh. Please log out and log back in for the change to take effect."
else
  echo "The current shell is already zsh. Finishing..."
fi
echo

# Install fonts
echo "Install fonts..."
mkdir -p "$LOCAL_FONT_PATH"
fonts_installed=0
for font in "$ZSH_FONTS_PATH"/*; do
  if [ ! -f "$LOCAL_FONT_PATH/$(basename "$font")" ]; then
    cp "$font" "$LOCAL_FONT_PATH"
    chmod 644 "$LOCAL_FONT_PATH/$(basename "$font")"
    fonts_installed=1
  fi
done
if [ "$fonts_installed" -eq 1 ]; then
  fc-cache -f >/dev/null
else
  echo "fonts already installed. Skipping..."
fi
echo ""

# Install mise
echo "Install mise..."
if [ ! -x "$MISE_BIN_PATH" ]; then
  curl https://mise.run | sh
else
  echo "mise already installed. Skipping..."
fi
mkdir -p "$HOME/.config/mise"
link_file "$ZSH_MISE_CONFIG_PATH/mise.toml" "$HOME/.config/mise/config.toml"
