#!/bin/sh

DMENU=$2
CLIPDIRECTORY="$HOME/.clipdir"

save() {
    entry=$(date +"clipboard_%Y%m%d_%H%M%S_%N")
    mime=$(wl-paste -l)
    mkdir -p $CLIPDIRECTORY
    echo $mime | cut -d' ' -f1 > $CLIPDIRECTORY/.$entry
    wl-paste -t $(cat $CLIPDIRECTORY/.$entry) > $CLIPDIRECTORY/$entry
}

get() {
    entry=$(ls -r $CLIPDIRECTORY | $DMENU)
    cat $CLIPDIRECTORY/$entry | wl-copy -n -t $(cat $CLIPDIRECTORY/.$entry)
}

case $1 in
    save) save;;
    get) get;;
esac
