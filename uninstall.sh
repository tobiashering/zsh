#!/usr/bin/env bash

set -euo pipefail

remove_path() {
  local path=$1

  if [ -e "$path" ] || [ -L "$path" ]; then
    rm -rf "$path"
    echo "Removed $path"
  fi
}

remove_path "$HOME/.zshrc"
remove_path "$HOME/.oh-my-zsh"
remove_path "$HOME/.antidote"

echo "Kept ${ZSH_REPO_PATH:-"$HOME/.zsh"}"
