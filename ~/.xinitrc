# --- Machine-Specific XRANDR Configuration ---
case $(cat /etc/hostname) in
    hp)
        echo "Applying xrandr settings for Laptop HP..."
        xrandr --output DP-1 --off --output DP-2 --off
        xrandr --output eDP-1 --primary --mode 1920x1080 --scale 1x1 --panning 0x0
        xrandr --output DP-1 --auto --scale-from 1920x1080 --same-as eDP-1
        ;;
    jm-x1)
        echo "Applying xrandr settings for Thinkpad X1..."
        xrandr --output DP-1 --off --output DP-2 --off --output HDMI-1 --off
        xrandr --output eDP-1 --mode 2560x1440 --scale 0.75x0.75
        xrandr --output HDMI-1 --mode 3840x2160 --scale 0.5x0.5 --same-as eDP-1
        xrandr --output DP-2 --mode 2560x1440 --scale 0.75x0.75
        ;;
esac

xrdb -merge ~/.Xresources
feh --bg-scale ~/dotfiles/wallpaper/simple.png

picom --vsync &
blueman-applet &
arandr-indicator &

exec dwm
