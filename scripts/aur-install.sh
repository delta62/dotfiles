#!/usr/bin/env bash

set -e

function usage() {
    echo 2>&1 "Usage: $(basename $0) <package>"
    exit 1
}

if [ -z "$1" ]; then
    usage
fi

cd ~/Downloads

PACKAGE="$1"
PKG_FILE="$PACKAGE.tar.gz"
PKG_URL="https://aur.archlinux.org/cgit/aur.git/snapshot/$PKG_FILE"

echo "Downloading $PKG_FILE..."
curl --fail --remote-name "$PKG_URL"

echo "Extracting..."
tar -xvzf "$PKG_FILE"

echo "Installing..."
cd "$PACKAGE"
makepkg -si
