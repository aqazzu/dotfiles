#!/bin/sh

file=$1
cacheroot="/home/rikou/.cache/lf"
cache="$cacheroot$file.sixel"
cachedir="$(dirname "$cache")"

case "$file" in
    *.jpg|*.jpeg|*.png|*.bmp|*.webp|*.pdf|*.mp4|*.mkv|*.mp3|*.m4a|*.flac|*.blend) rm $cache;;
esac
