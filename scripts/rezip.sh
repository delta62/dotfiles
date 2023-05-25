#!/usr/bin/env bash
# Rename the file contained in a zip file to match the zip archive's name.
# Will fail if zip file length is 0 or > 1.

set -e

TMP_PATH="/tmp/rezip"

if [ ! -d "$TMP_PATH" ]; then
    mkdir "$TMP_PATH"
fi

function rezip() {
    FILE="$1"
    FILE_LIST="$(zipinfo -1 "$FILE")"
    BASENAME="$(basename "$FILE")"
    BASENAME="${BASENAME%.*}"
    ZIP_LEN=$(echo "$FILE_LIST" | wc -l)
    EXTNAME="${FILE_LIST##*.}"

    if [ $ZIP_LEN -ne 1 ]; then
        echo >&2 "zip archive must contain exactly one item"
        exit 1
    fi

    unzip -o "$FILE" -d "$TMP_PATH"
    rm -v "$FILE"

    if [ ! -f "$TMP_PATH/$BASENAME.$EXTNAME" ]; then
        mv -v "$TMP_PATH/$FILE_LIST" "$TMP_PATH/$BASENAME.$EXTNAME"
    fi

    chmod -v 644 "$TMP_PATH/$BASENAME.$EXTNAME"
    zip --junk-paths "$FILE" "$TMP_PATH/$BASENAME.$EXTNAME"
}

if [ -z "$1" ]; then
    for FILE in *.zip; do
        rezip "$FILE"
    done
else
    rezip "$1"
fi
