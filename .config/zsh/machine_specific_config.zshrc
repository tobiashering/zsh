# allow a configuration per machine which is not included in git
ZSH_MACHINE_SPECIFIC_CONFIG_PATH=$HOME/.machine_specific.zshrc

if [ ! -f "$ZSH_MACHINE_SPECIFIC_CONFIG_PATH" ]; then
  echo "No machine specific config found in ${ZSH_MACHINE_SPECIFIC_CONFIG_PATH}."
  echo "# machine specific ZSH Configuration" > "$ZSH_MACHINE_SPECIFIC_CONFIG_PATH"
  echo "Created machine specific config file at $ZSH_MACHINE_SPECIFIC_CONFIG_PATH."
fi

# shellcheck source=/dev/null
source "$ZSH_MACHINE_SPECIFIC_CONFIG_PATH"
