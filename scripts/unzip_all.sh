#!/usr/bin/env bash

set -e

SOURCE="$1"
DEST="$2"

echo "This will extract all files from $SOURCE/* to $DEST"
read -p "Continue? [y/N]" -n 1 -r

if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo
    for ZIPFILE in "$SOURCE/"*; do
        echo "extracting $(basename "$ZIPFILE")..."
        unzip -qq "$ZIPFILE" -d "$DEST"
    done

    echo "done!"
else
    echo >&2 "Aborted"
    exit 1
fi
