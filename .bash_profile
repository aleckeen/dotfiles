# This file is sourced by bash for login shells. The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]]; then
  source "$HOME/.bashrc"
else
  source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/common.sh"
fi

# Autostart X at login.
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx "$XINITRC"
fi
