#!/bin/sh

file=$1
#mimetype=$(file -Lb --mime-type -- "$file")
cacheroot="/home/rikou/.cache/lf"
cache="$cacheroot$file.sixel"
cachedir="$(dirname "$cache")"

caching_img () {
if [ ! -e "$cache" ]
then
    mkdir -p "$cachedir"
    touch "$cache"
    case "$file" in
    *.jpg|*.jpeg|*.png|*.bmp) img2sixel -q low -h 500 "$file" > "$cache";;
    *.webp) dwebp -quiet "$file" -o /dev/stdout | img2sixel -q low -h 500 > "$cache";;
    *.pdf)
        pdftoppm -f 1 -l 1                   \
                 -singlefile                 \
                 -jpeg -tiffcompression jpeg \
                 -- "$file"                  \
        | img2sixel -q low -w 500 > "$cache"
        ;;
    *.mp4|*.mkv|*.mp3|*.m4a|*.flac) ffmpegthumbnailer -i "$file" -o /dev/stdout -s 0 | img2sixel -q low -h 500 || echo "no thumbnail" > "$cache";;
    *.blend) blender-thumbnailer "$file" /dev/stdout | img2sixel -q low -h 500 > "$cache";;
    *) echo "Something wrong happened, fix your preview script at: ~/.config/prv.sh!" > "$cache";;
    esac
    cat "$cache"
else
    cat "$cache"
fi
}

case "$file" in
    *.jpg|*.jpeg|*.png|*.bmp|*.webp|*.pdf|*.mp4|*.mkv|*.mp3|*.m4a|*.flac|*.blend) caching_img;;
    *.sixel) cat "$1";;
    *.tar*) tar -tf "$file";;
    *.zip) unzip -l "$file";;
    *.rar) unrar l "$file";;
    *.7z) 7z l "$file";;
    *.deb)
        dpkg-deb --show "$file"
        echo "* * *"
        dpkg-deb --info "$file"
        ;;
    *) highlight -O ansi "$file" || cat "$1";;
esac

exit 1
