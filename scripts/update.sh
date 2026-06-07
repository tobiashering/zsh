#!/usr/bin/env bash

headline() {
  gum style --bold --foreground 2 "$1"
}

update_apt() {
  headline "Updating apt packages..."
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get autoremove
  sudo apt-get clean
  echo
}

update_snaps() {
  if command -v snap &>/dev/null; then
    headline "Updating snap packages"
    sudo snap refresh
    echo
  fi
}

update_zsh() {
  headline "Updating zsh repo"
  git -C "$ZSH_FOLDER" stash
  git -C "$ZSH_FOLDER" pull
  echo
}

update_omz() {
  headline "Updating ohmyzsh"
  zsh -i -c "omz update"
  echo
}

update_antidote() {
  headline "Updating antidote plugins"
  zsh -i -c "antidote update"
  echo
}

update_mise() {
  headline "Updating mise"
  mise self-update
  mise install
  echo
}

sudo -v

update_apt
update_snaps
update_zsh
update_omz
update_antidote
update_mise
