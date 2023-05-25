#!/usr/bin/env bash
# Rename ripped GameCube files to have sane names

for F in ./*dumpinfo.txt; do
    FILENAME="$(grep 'Filename' "$F" | sed -E 's/^[^:]+:\s*//' | tr -dc '[:graph:] ')"
    ROM_NAME="$(grep 'Internal Name' "$F" | sed -E 's/^[^:]+:\s*//' | tr -dc '[:graph:] ')"

    echo "$FILENAME" | grep 'disc2' > /dev/null
    if [ $? -eq 0 ]; then
        DISK=" Disk 2"
    else
        DISK=""
    fi

    mv -v "$FILENAME.iso" "${ROM_NAME}${DISK}.iso"
done
