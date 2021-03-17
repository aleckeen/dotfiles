#!/bin/sh

# export WINIT_X11_SCALE_FACTOR=1
# # export QT_QPA_PLATFORMTHEME=qt5ct
# 
# # /usr/bin/prime-offload
# 
# # numlockx
# xset s off -dpms
# xset r rate 300 50
# # setxkbmap tr
# # xrandr --setprovideroutputsource modesetting NVIDIA-G0
# 
# # run kde if $CURRENT_MANAGER is set to plasma else run
# # whatever value it contains. default value is set in
# # zshrc.
# # if [ $CURRENT_MANAGER = "plasma" ]
# # then
# #   export DESKTOP_SESSION=plasma
# #   exec startplasma-x11
# # elif [ $CURRENT_MANAGER = "mate" ]
# # then
# #   exec mate-session
# # else
# #   current_gpu="$(optimus-manager --status | awk 'NR == 4 { print $5 }')"
# 
#   # if [ $current_gpu = "nvidia" ]
#   # then
#   #   xrandr --output eDP-1-1 --primary --mode 1920x1080 \
#   #          --output DP-1-1 --left-of eDP-1-1 --mode 1366x768 \
#   #          --output HDMI-1-1 --right-of eDP-1-1 --mode 1366x768
#   # else
#   #   xrandr --output eDP-1 --primary --mode 1920x1080 \
#   #          --output DP-1 --left-of eDP-1 --mode 1366x768 \
#   #          --output HDMI-1 --right-of eDP-1 --mode 1366x768
#   # fi
#   xrandr --output eDP-1 --primary --mode 1920x1080 \
#          --output DP-1 --left-of eDP-1 --mode 1366x768 \
#          --output HDMI-1 --right-of eDP-1 --mode 1366x768 &
# 
#   # lxsession &
#   # picom --config ~/.config/picom/picom.conf &
#   # nitrogen --restore &
#   # dunst &
# 
#   exec $CURRENT_MANAGER
# fi

export WINIT_X11_SCALE_FACTOR=1

xrandr --setprovideroutputsource modesetting NVIDIA-G0

xrandr_options=""
for mon in $(xrandr --listmonitors | awk 'NR!=1 { print $4 }'); do
  if [ $mon = "eDP-1" ]; then
    xrandr_options="$xrandr_options --output eDP-1 --primary --mode 1920x1080"
  elif [ $mon = "HDMI-1" ]; then
    xrandr_options="$xrandr_options --output HDMI-1 --right-of eDP-1 --mode 1366x768"
  elif [ $mon = "DP-1" ]; then
    xrandr_options="$xrandr_options --output DP-1 --left-of eDP-1 --mode 1366x768"
  fi
done
xrandr $xrandr_options

xset s off -dpms
xset r rate 300 50

picom --config ~/.config/picom/picom.conf &
nitrogen --restore &
dunst &

exec qtile
