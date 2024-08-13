#!/bin/sh

# A hook for loginctl
# Copy the script to /lib/elogind/system-sleep
# Don't forget to pass these variables
export WAYLAND_DISPLAY=wayland-?
export XDG_RUNTIME_DIR=/run/user/????
export USER=

lock() {
    IMG=/tmp/lock.png
    /usr/bin/grim -c $IMG
    /usr/bin/convert $IMG -resize 10% -blur 0x2 $IMG
    sudo -Eu $USER /usr/bin/swaylock -fi $IMG
}

case $# in
    0)
        MSG="No arguments provided..."
        notify-send -i help "Hey, $USER" "$MSG"
        echo Hey, $USER: $MSG
    ;;

    1)
        MSG="Not enough arguments provided..."
        notify-send -i help "Hey, $USER" "$MSG"
        echo Hey, $USER: $MSG
    ;;

    *)
    case $1 in
        pre)
            lock
            ;;
        post)
            MSG="You've put your computer on $2"
            notify-send -i sleep "Welcome back $USER" "$MSG"
            echo Welcome back $USER: $MSG
        ;;
        *)
            MSG="Incorrect first argument provided..."
            notify-send -i help "Hey, $USER" "$MSG"
            echo Hey, $USER: $MSG $#
        ;;
    esac
    ;;
esac

