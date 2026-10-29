# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# Keep the user-local Qt 6.11 shell and its IPC clients on the same config.
if [[ $(command -v omarchy-shell) == "$HOME/.local/share/omarchy-qt611/bin/omarchy-shell" && -f "$HOME/.local/share/omarchy-qt611/shell/shell.qml" ]]; then
  export OMARCHY_PATH="$HOME/.local/share/omarchy-qt611"
fi

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
. "$HOME/.local/bin/env"
export CLASHCTL_HOME=/home/maki/clashctl
. $CLASHCTL_HOME/scripts/cmd/clashctl.sh
