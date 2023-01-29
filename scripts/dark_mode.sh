#!/usr/bin/env bash
#
# Query or update the system light/dark color scheme preference

set -e

GTK3_SETTINGS_PATH="$HOME/.config/gtk-3.0/settings.ini"

function usage() {
    echo >&2 "Usage: $0 <get | dark | light | toggle>"
}

# Gets the current color scheme preference, either prefer-light or prefer-dark
function get_color_scheme() {
    # gsettings quotes the value, remove the quotes here
    sed -e "s/^'//" \
        -e "s/'$//" \
        <<< $(gsettings get org.gnome.desktop.interface color-scheme)
}

# Set the light/dark mode preference for both GTK 3 and 4
function set_color_scheme() {
    # GTK 3
    if [ "$1" == "prefer-dark" ]; then
        GTK3_VALUE=true
    else
        GTK3_VALUE=false
    fi

    if [ ! -f "$GTK3_SETTINGS_PATH" ]; then
        echo >&2 "$GTK3_SETTINGS_PATH does not exist. Please initialize it."
        exit 1
    fi

    sed -Ei \
        "s/(gtk-application-prefer-dark-theme)\s*=\s*(.*)/\1 = $GTK3_VALUE/" \
        "$GTK3_SETTINGS_PATH"

    # GTK 4
    gsettings set org.gnome.desktop.interface color-scheme "$1"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

case "$1" in
    "get")
        echo "$(get_color_scheme)"
        ;;
    "dark")
        set_color_scheme "prefer-dark"
        echo "$(get_color_scheme)"
        ;;
    "light")
        set_color_scheme "prefer-light"
        echo "$(get_color_scheme)"
        ;;
    "toggle")
        CURRENT="$(get_color_scheme)"
        if [ "$CURRENT" == "prefer-dark" ]; then
            set_color_scheme "prefer-light"
        else
            set_color_scheme "prefer-dark"
        fi
        echo "$(get_color_scheme)"
        ;;
    "-h" | "--help")
        usage
        exit 0
        ;;
    "*")
        usage
        exit 1
        ;;
esac
