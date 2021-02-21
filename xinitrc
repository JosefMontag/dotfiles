xinput set-prop 14 "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 1
xinput --set-button-map 13 1 3 2
xkbset m
xmodmap -e "keycode 135 = Pointer_Button2"

setxkbmap -option caps:escape,altwin:ctrl_alt_win
xrdb -merge ~/.Xresources

exec dwm
