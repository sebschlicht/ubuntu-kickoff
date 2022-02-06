#!/bin/bash
#
# Converts webp image and video files to standard formats (JPG/GIF).
#
# Requirements:
# - [package] webp
# - [command] webp-to-gif

fc_convert_webp_to_jpg() {
    convert "$1" "${1%.*}.jpg" 2>/dev/null
}

fc_convert_webp_to_gif() {
    webp-to-gif "$1"
}

for i in $(find . -name '*.webp'); do
    fc_convert_webp_to_jpg "$i" || fc_convert_webp_to_gif "$i" || echo 'Failed to convert'
done
