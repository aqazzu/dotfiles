#!/bin/sh

#Depends on:
# - cat
# - dirname
# - touch
# - dwebp
# - inkscape
# - pdftoppm
# - img2sixel
# - ffmpegthumbnailer
# - blender-thumbnailer
# - dpkg-deb
# - highlight
# - 7z
# - unzip
# - unrar
# - tar

file=$1
#mimetype=$(file -Lb --mime-type -- "$file")
cacheroot="/home/rikou/.cache/lf"
cache="$cacheroot$file.sixel"
cachedir="$(dirname "$cache")"
cachebit="$cacheroot/cache"
imagecmd="img2sixel"
imageopth="-q low -h 500"
imageoptw="-q low -w 500"

caching_img () {
if [ ! -e "$cache" ]; then
    mkdir -p "$cachedir"
    touch "$cache"
    case "$file" in
    *.jpg|*.jpeg|*.png|*.bmp) $imagecmd $imageopth "$file" > "$cache";;
    *.webp) dwebp -quiet "$file" -o /dev/stdout | $imagecmd $imageopth > "$cache";;
    *.svg) inkscape "$file" --export-type=png -o - | $imagecmd $imageopth > "$cache";;
    *.pdf)
        pdftoppm -f 1 -l 1                   \
                 -singlefile                 \
                 -jpeg -tiffcompression jpeg \
                 -- "$file"                  \
        | $imagecmd $imageoptw > "$cache"
        ;;
    *.mp4|*.mkv|*.mp3|*.m4a|*.flac) ffmpegthumbnailer -i "$file" -o /dev/stdout -s 0 | $imagecmd $imageopth > "$cache";;
    *.blend) blender-thumbnailer "$file" /dev/stdout | $imagecmd $imageopth > "$cache";;
    *) echo "Something wrong happened, fix your preview script at: ~/.config/prv.sh!" > "$cache";;
    esac
fi

if [ "$DISPLAY" ]; then
    cat "$cache"
else
    echo "Cannot display Sixel!"
fi
}

case "$file" in
    *.jpg|*.jpeg|*.png|*.bmp|*.webp|*.svg|*.pdf|*.mp4|*.mkv|*.mp3|*.m4a|*.flac|*.blend) caching_img;;
    *.sixel) 
        if [ "$DISPLAY" ]; then
            cat "$1"
        else
            echo "Cannot display Sixel!"
        fi;;
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

if [ ! -e $cachebit ]; then echo 0 > $cachebit; fi

return $(cat $cachebit)
