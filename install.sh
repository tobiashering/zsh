#!/bin/bash

# Environment variables
ZSH_INITIAL_REPO_PATH=$HOME/zsh
ZSH_FINAL_REPO_PATH=$HOME/.zsh

OHMYZSH_PATH=$HOME/.oh-my-zsh
OHMYZSH_INSTALL_SCRIPT=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

ANTIDOTE_PATH=$HOME/.antidote
ANTIDOTE_REPO=https://github.com/mattmc3/antidote.git

# Install dependencies
echo "Install dependencies..."
sudo apt-get update && sudo apt-get install -y curl git zsh
echo

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
if [ -d "$ZSH_INITIAL_REPO_PATH" ]; then
  echo "Moving the zsh folder to $ZSH_FINAL_REPO_PATH..."
  rm -rf "$ZSH_FINAL_REPO_PATH"
  mv "$ZSH_INITIAL_REPO_PATH" "$ZSH_FINAL_REPO_PATH"
  echo
fi

# Remove the zsh config and replace it with a symlink
echo "Replace the zsh config with a symlink..."
ZSHRC=~/.zshrc
if [ -L "$ZSHRC" ] && [ "$(readlink "$ZSHRC")" = "$ZSH_FINAL_REPO_PATH/.zshrc" ]; then
  echo "Symlink already points to the correct location. Skipping..."
else
  rm -f $ZSHRC
  ln -sf "$ZSH_FINAL_REPO_PATH/.zshrc" $ZSHRC
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
LOCAL_FONT_PATH=~/.local/share/fonts
if [ ! -d "$LOCAL_FONT_PATH" ]; then
  mkdir -p $LOCAL_FONT_PATH
  chmod 755 $LOCAL_FONT_PATH
fi
cp -r "$ZSH_FINAL_REPO_PATH"/fonts/* $LOCAL_FONT_PATH
chmod 644 $LOCAL_FONT_PATH/*
fc-cache -f
echo ""

# Install mise
MISE_CONFIG_REPO_PATH=$ZSH_FINAL_REPO_PATH/.config/mise/mise.toml
MISE_LOCAL_CONFIG_PATH=$HOME/.config/mise/config.toml

echo "Install mise..."
curl https://mise.run | sh
mkdir -p "$HOME/.config/mise"
ln -sf "$MISE_CONFIG_REPO_PATH" "$MISE_LOCAL_CONFIG_PATH"
