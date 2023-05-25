#!/usr/bin/env bash
# Rename each file in a directory to one of several given possibilities

set -e
shopt -s nocasematch

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $(basename $0) <choices_file> [start-from]"
    exit 1
fi

OPTIONS="$(<$1)"
printf -v OPTIONS "$OPTIONS\n<SKIP>"
START_FROM="${2}"

for FILE in *; do
    if [ "$FILE" \< "$START_FROM" ]; then
        continue
    fi

    BASENAME="$(basename "$FILE")"
    BASENAME="${BASENAME%.*}"
    if [ -d "$FILE" ]; then
        EXTNAME=""
    else
        EXTNAME=".${FILE##*.}"
    fi
    RENAME_TO=$(echo "$OPTIONS" | fzf --height 40% -i --header "$BASENAME" --query "$BASENAME" --bind 'ctrl-d:clear-query')

    if [[ "$RENAME_TO" = "<SKIP>" ]]; then
        echo "Skipping $FILE"
        continue
    fi

    if [ -z "$RENAME_TO" ]; then
        exit 1
    fi

    if [ "${RENAME_TO}${EXTNAME}" != "$FILE" ]; then
        mv -v "$FILE" "${RENAME_TO}${EXTNAME}"
    fi
done
