#!/bin/bash

ZSH_REPO_DIR=$HOME/zsh
ZSH_DIR=$HOME/.zsh

OHMYZSH_INSTALL_SCRIPT=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
OHMYZSH_FOLDER=$HOME/.oh-my-zsh

ANTIDOTE_PATH=$HOME/.antidote
ANTIDOTE_REPO=https://github.com/mattmc3/antidote.git

# Install dependencies
echo "Install dependencies..."
sudo apt-get update && sudo apt-get install -y curl git zsh
echo

# Install ohmyzsh
echo "Install oh-my-zsh..."
if [ ! -d "$OHMYZSH_FOLDER" ]; then
  sh -c "$(curl -fsSL $OHMYZSH_INSTALL_SCRIPT)" "" --unattended
else
  echo "oh-my-zsh already installed. Skipping..."
fi
echo

# Install antidote
echo "Install antidote..."
if [ ! -d "$ANTIDOTE_PATH" ]; then
  git clone --depth=1 $ANTIDOTE_REPO $ANTIDOTE_PATH
else
  echo "antidote already installed. Skipping..."
fi
echo

# Cleanup zsh folder
if [ -d "$ZSH_REPO_DIR" ]; then
  echo "Moving the zsh folder to $ZSH_DIR..."
  rm -rf $ZSH_DIR
  mv $ZSH_REPO_DIR $ZSH_DIR
  echo
fi

# Remove the zsh config and replace it with a symlink
echo "Replace the zsh config with a symlink..."
ZSHRC=~/.zshrc
if [ -L "$ZSHRC" ] && [ "$(readlink "$ZSHRC")" = "$ZSH_DIR/.zshrc" ]; then
  echo "Symlink already points to the correct location. Skipping..."
else
  rm -f $ZSHRC
  ln -s $ZSH_DIR/.zshrc $ZSHRC
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
FONT_DIR=~/.local/share/fonts
if [ ! -d "$FONT_DIR" ]; then
  mkdir -p $FONT_DIR
  chmod 755 $FONT_DIR
fi
cp -r $ZSH_DIR/fonts/* $FONT_DIR
chmod 644 $FONT_DIR/*
fc-cache -f
echo ""

# Install mise
echo "Install mise..."
curl https://mise.run | sh
mkdir -p $HOME/.config/mise
ln -sf $ZSH_DIR/mise.toml $HOME/.config/mise/config.toml
