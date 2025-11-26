source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Reset/clear transforms and turn externals off
xrandr --output DP-1 --off --output DP-2 --off
xrandr --output eDP-1 --primary --mode 1920x1080 --scale 1x1 --panning 0x0

# Bring up DP-1 mirroring the laptop
xrandr --output DP-1 --auto --scale-from 1920x1080 --same-as eDP-1

# Then add DP-2 mirroring as well
xrandr --output DP-2 --auto --scale-from 1920x1080 --same-as eDP-1

# xinput set-prop 12 "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 1

# xinput --set-button-map 11 1 3 2
# xkbset m
# xmodmap -e "keycode 135 = Pointer_Button2"

# setxkbmap -option caps:escape,altwin:ctrl_alt_win
# ~/.xinitrc

# ------------------------------------------------------------------
# CUSTOM INPUT DEVICE CONFIGURATION
# ------------------------------------------------------------------

# 1. Set keyboard options: Caps Lock -> Escape, Left Alt -> Control
# setxkbmap -option ''
# setxkbmap -option caps:escape -option ctrl:swap_lalt_lctl

# --- TrackPoint & Key Remapping ---

# Right physical button → middle click
# xinput set-button-map 12 1 2 3
#
# # Enable tapping
# xinput set-prop 12 "libinput Tapping Enabled" 1
# # Map tapping: one-finger=left (1), two-finger=right (3)
# xinput set-prop 12 "libinput Tapping Button Mapping Enabled" 1, 0
#
# # Scroll config: enable two-finger only
# xinput set-prop 12 "libinput Scroll Method Enabled" 0, 1, 0
# # Standard (not natural) scrolling
# xinput set-prop 12 "libinput Natural Scrolling Enabled" 0
#
# # Optional: turn off tap-and-drag if you don’t want it
# xinput set-prop 12 "libinput Tapping Drag Enabled" 0


# ------------------------------------------------------------------
# START THE WINDOW MANAGER
# ------------------------------------------------------------------

xrdb -merge ~/.Xresources
feh --bg-scale ~/dotfiles/wallpaper/simple.png

picom --vsync &

arandr-indicator &
blueman-applet &

exec dwm
