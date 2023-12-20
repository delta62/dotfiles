#!/usr/bin/env bash

set -e

if [ $# -ne 2 ]; then
    echo >&2 "Usage: $0 <src> <dest>"
    exit 1
fi

SRC="$1"
DEST="$2"

for SRC_FILE in "$SRC"/*; do
    SRC_CHECKSUM=$(md5sum "$SRC_FILE")
    DEST_FILE="$DEST/$(basename "$SRC_FILE")"

    if [ -f "$DEST_FILE" ]; then
        DEST_CHECKSUM=$(md5sum "$DEST_FILE")
    else
        DEST_CHECKSUM=""
    fi

    if [ "$SRC_CHECKSUM" != "$DEST_CHECKSUM" ]; then
        echo "$SRC_FILE -> $DEST"
        # cp --interactive "$SRC_FILE" "$DEST_FILE"
    else
        echo "Skipping $SRC_FILE, already exists in destination"
    fi
done
