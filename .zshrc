# Environment variables
export ZSH_REPO_PATH=$HOME/.zsh
export ZSH_CONFIG_PATH=$ZSH_REPO_PATH/.config/zsh
export ZSH_MISE_CONFIG_PATH=$ZSH_REPO_PATH/.config/mise
export ZSH_SCRIPTS_PATH=$ZSH_REPO_PATH/scripts

export MISE_TRUSTED_CONFIG_PATHS=$ZSH_MISE_CONFIG_PATH/mise.toml
export ANTIDOTE_PATH=$HOME/.antidote/antidote.zsh

export ZSH=$HOME/.oh-my-zsh

# Theme
export ZSH_THEME="eastwood"

# Initialize plugin manager
export ZDOTDIR=$ZSH_REPO_PATH
# shellcheck source=/dev/null
source "$ANTIDOTE_PATH"
antidote load

# Load mise
MISE_EXECUTABLE_PATH=$HOME/.local/bin/mise
eval "$($MISE_EXECUTABLE_PATH activate zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # shellcheck source=/dev/null
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh settings
export EDITOR=nano
zstyle ':omz:update' mode auto

# Mount config files
# shellcheck source=.config/zsh/aliases.zshrc
source "$ZSH_CONFIG_PATH/aliases.zshrc"
# shellcheck source=.config/zsh/commands.zshrc
source "$ZSH_CONFIG_PATH/commands.zshrc"
# shellcheck source=.config/zsh/machine_specific_config.zshrc
source "$ZSH_CONFIG_PATH/machine_specific_config.zshrc"

# To customize prompt, run `p10k configure` or edit .p10k.zsh
P10K_CONFIG_FILE=$ZSH_REPO_PATH/.p10k.zsh
[[ ! -f $P10K_CONFIG_FILE ]] || source $P10K_CONFIG_FILE
