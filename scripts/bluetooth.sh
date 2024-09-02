#!/usr/bin/env bash
#
# Query or enable bluetooth

DEVICE="22:01:AE:DF:EF:A8" # earbuds

function usage() {
    echo >&2 "Usage: $0 <get | get_waybar | enable>"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

# Gets the current state of the bluetooth controller
# connected | discoverable | on | off
function get_state() {
    CONNECTED=$(bluetoothctl <<EOF
devices Connected
EOF
)
    CONNECTED=$(echo "$CONNECTED" | grep '^Device')
    DISCOVERABLE=$(echo "$STATUS" | grep 'Discoverable: yes')
    POWERED=$(echo "$STATUS" | grep 'Powered: yes')

    if [ ! -z "$CONNECTED" ]; then
        STATE="connected"
    else
        STATUS=$(bluetoothctl <<EOF
show
EOF
)
        if [ ! -z "$DISCOVERABLE" ]; then
            STATE="discoverable"
        elif [ ! -z "$POWERED" ]; then
            STATE="on"
        else
            STATE="off"
        fi
    fi

    echo "$STATE"
}

function enable() {
    bluetoothctl <<EOF
power on
connect $DEVICE
EOF
}

function get_battery_percent() {
    DEVICE_INFO=$(bluetoothctl <<EOF
info
EOF
)
    echo "$DEVICE_INFO" | sed -n 's/Battery Percentage:.*(\([^()]*\)).*/\1/p'
}

function get_waybar() {
    STATE=$(get_state)

    case "$STATE" in
        "off")
            cat <<- EOF
{"text":"","tooltip":"Enable bluetooth","class":"bluetooth-off"}
EOF
            ;;
        "on")
            cat <<- EOF
{"text":"","tooltip":"Bluetooth is on","class":"bluetooth-on"}
EOF
            ;;
        "discoverable")
            cat <<- EOF
{"text":"","tooltip":"Bluetooth is discoverable","class":"bluetooth-discoverable"}
EOF
            ;;
        "connected")
            BATT_PERCENT=$(get_battery_percent)
            cat <<- EOF
{"text":"","tooltip":"Connected (${BATT_PERCENT}%)","class":"bluetooth-discoverable"}
EOF
            ;;
    esac
}

case "$1" in
    "get")
        get_state
        ;;
    "get_waybar")
        get_waybar
        ;;
    "enable")
        enable
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
