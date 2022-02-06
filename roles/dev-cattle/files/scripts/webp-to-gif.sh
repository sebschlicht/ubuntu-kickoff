#!/bin/bash

DELAY=10
LOOP=0

FILE_PATH="$(realpath "$1")"
FILE_DIR="$(dirname "$FILE_PATH")"
FILENAME="$(basename "$FILE_PATH")"
FILENAME_BASE="${FILENAME%.*}"

TARGET_FILENAME="$FILENAME_BASE.gif"
TARGET_FILE="$FILE_DIR/$TARGET_FILENAME"
TMP_DIR="$FILE_DIR/$TARGET_FILENAME.tmp"

if [ -f "$TARGET_FILE" ]; then
    echo "[WARN] The target file '$TARGET_FILE' already exists, skipping."
    exit 0
fi

if [ -e "$TMP_DIR" ];then
    echo "[WARN] The temporary directory '$TMP_DIR' already exists, skipping the conversion of '$FILE_PATH'."
fi

NUM_FRAMES="$(webpinfo -summary "$FILE_PATH" | grep frames | sed -e 's/.* \([0-9]*\)$/\1/')"
dur="$(webpinfo -summary "$FILE_PATH" | grep Duration | head -1 | sed -e 's/.* \([0-9]*\)$/\1/')"

if (($dur > 0)); then
    # consequences unclear, looks like DELAY has to be set now
    DELAY="$DELAY"
fi

mkdir "$TMP_DIR" || (echo "[ERROR] Failed to create temporary directory '$TMP_DIR', aborting."; exit 1)
for i in $(seq -f "%05g" 1 "$NUM_FRAMES"); do
    webpmux -get frame "$i" "$FILE_PATH" -o "$TMP_DIR/$FILENAME_BASE.$i.webp" 2>/dev/null
    dwebp "$TMP_DIR/$FILENAME_BASE.$i.webp" -o "$TMP_DIR/$FILENAME_BASE.$i.png" -quiet
done

convert "$TMP_DIR/$FILENAME_BASE".*.png -delay "$DELAY" -loop "$LOOP" "$TARGET_FILENAME"
rm -r "$TMP_DIR"
