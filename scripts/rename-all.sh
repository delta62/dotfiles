#!/usr/bin/env bash
# Rename each file in a directory to one of several given possibilities

set -e
shopt -s nocasematch

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $(basename $0) <choices_file> [start-from]"
    exit 1
fi

OPTIONS="$(<$1)"
printf -v OPTIONS "%s\n>>>" "$OPTIONS"
START_FROM="${2}"

for FILE in *; do
    if [ "$FILE" \< "$START_FROM" ]; then
        continue
    fi

    BASENAME="$(basename "$FILE")"
    STEM="${BASENAME%.*}"

    if grep -qFx "$STEM" "$1"; then
        continue
    fi

    HEADER=$(echo "$STEM" | sed -r 's/^[[:digit:]]+ - //')
    QUERY=$(echo "$HEADER" \
        | sed -r 's/^[[:digit:]]+ - //' \
        | sed -r 's/ \(M[[:digit:]]+\)//' \
        | sed -r 's/ \(U\)/ (USA)/' \
        | sed -r 's/ \(J\)/ (Japan)/' \
        | sed -r 's/ \(E\)/ (Europe)/' \
        | sed -r 's/ \(UE\)/ (USA, Europe)/')

    if [ -d "$FILE" ]; then
        EXTNAME=""
    else
        EXTNAME=".${FILE##*.}"
    fi
    RENAME_TO=$(echo "$OPTIONS" | fzf --height 40% -i --header "$HEADER" --query "$QUERY" --bind 'ctrl-d:clear-query')

    if [[ "$RENAME_TO" = ">>>" ]]; then
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
