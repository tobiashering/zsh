# Entrypoint used when ZDOTDIR points at this repository.
# shellcheck disable=SC2296,SC2298
export ZSH_REPO_PATH=${ZSH_REPO_PATH:-${${(%):-%N}:A:h}}
source "$ZSH_REPO_PATH/config/zsh/zshrc"
