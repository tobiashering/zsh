# docker shell
dcshell() {
  docker compose exec $1 sh
}
dcbash() {
  docker compose exec $1 bash
}

update() {
  zsh $ZSH_FOLDER/scripts/update.sh
}
