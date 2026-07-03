# Docker shell
dcshell() {
  docker compose exec "$1" sh
}

# Docker bash
dcbash() {
  docker compose exec "$1" bash
}

# Execute update script
update() {
  zsh "$ZSH_SCRIPTS_PATH/update.sh"
}
