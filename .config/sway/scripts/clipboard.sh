#!/bin/sh

DMENU=$2

save() {
    wl-paste |
    cat - ~/.clipboard > ~/.clipboard_tmp &&
    mv ~/.clipboard_tmp ~/.clipboard
}

get() {
    cat ~/.clipboard | $DMENU | wl-copy -n
}

case $1 in
    save) save;;
    get) get;;
esac
