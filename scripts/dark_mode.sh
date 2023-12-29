#!/usr/bin/env bash
#
# Query or update the system light/dark color scheme preference

set -e

GTK3_SETTINGS_PATH="$HOME/.config/gtk-3.0/settings.ini"
NVIM_COLORS_PATH=~/.config/nvim/lua/colors.lua

function usage() {
    echo >&2 "Usage: $0 <get | get_waybar | dark | light | toggle>"
}

# Gets the current color scheme preference, either prefer-light or prefer-dark
function get_color_scheme() {
    CURRENT="$(gsettings get org.gnome.desktop.interface color-scheme)"
    if [ "$CURRENT" == "'prefer-dark'" ]; then
        echo "dark"
    else
        echo "light"
    fi
}

# Set the light/dark mode preference
function set_color_scheme() {
    if [ "$1" == "dark" ]; then
        GTK3_VALUE=true
        GTK4_VALUE="prefer-dark"
        KITTY_THEME="Ayu Mirage"
        NVIM_FIND="light"
        NVIM_REPLACE="mirage"
    else
        GTK3_VALUE=false
        GTK4_VALUE="prefer-light"
        KITTY_THEME="Ayu Light"
        NVIM_FIND="mirage"
        NVIM_REPLACE="light"
    fi

    if [ ! -f "$GTK3_SETTINGS_PATH" ]; then
        echo >&2 "$GTK3_SETTINGS_PATH does not exist. Please initialize it."
        exit 1
    fi

    # GTK 3
    sed -Ei \
        "s/(gtk-application-prefer-dark-theme)\s*=\s*(.*)/\1 = $GTK3_VALUE/" \
        "$GTK3_SETTINGS_PATH"

    # GTK 4
    gsettings set org.gnome.desktop.interface color-scheme "$GTK4_VALUE"

    # Neovim
    # sed -Ei \
    #     "s/'$NVIM_FIND'/'$NVIM_REPLACE'/" \
    #     "$NVIM_COLORS_PATH"
    # nvr -cc "luafile $NVIM_COLORS_PATH"

    # Kitty
    kitty +kitten themes --reload-in all --config-file-name themes.conf "$KITTY_THEME"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

case "$1" in
    "get")
        get_color_scheme
        ;;
    "get_waybar")
        if [ $(get_color_scheme) == "dark" ]; then
            cat <<- EOF
{"text":"","tooltip":"Switch to light mode","class":"dark"}
EOF
        else
            cat <<- EOF
{"text":"","tooltip":"Switch to dark mode","class":"light"}
EOF
        fi
        ;;
    "dark")
        set_color_scheme "dark"
        ;;
    "light")
        set_color_scheme "light"
        ;;
    "toggle")
        if [ $(get_color_scheme) == "dark" ]; then
            set_color_scheme "light"
        else
            set_color_scheme "dark"
        fi
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
