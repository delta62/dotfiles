#!/usr/bin/env bash

for FILE in *; do
    EXTNAME="${FILE##*.}"

    if [ "$EXTNAME" != "zip" ]; then
        FILENAME="${FILE%.*}"
        echo "$FILENAME"
        zip "${FILENAME}.zip" "$FILE"
    fi
done
