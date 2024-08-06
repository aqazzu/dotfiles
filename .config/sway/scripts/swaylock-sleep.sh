#!/bin/sh

# A hook for loginctl
# Copy the script to /lib/elogind/system-sleep

lock() {
    IMG=/tmp/lock.png
    /usr/bin/grim -c $IMG
    /usr/bin/convert $IMG -resize 10% -blur 0x2 $IMG
    /usr/bin/swaylock -i $IMG
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
            sleep 1s
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

