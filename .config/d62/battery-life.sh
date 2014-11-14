#!/bin/bash

# Bash Colors
# COLOR_GREEN='\033[0;32m'
# COLOR_YELLOW='\033[1;33m'
# COLOR_RED='\033[0;31m'
# COLOR_GRAY_DK='\033[1;30m'

# Screen colors
COLOR_WHITE='\005{w}'
COLOR_GREEN='\005{g}'
COLOR_YELLOW='\005{y}'
COLOR_RED='\005{r}'
COLOR_GRAY='\005{K}'
COLOR_NONE='\005{-}'

print_battery() {
    # Print status bars
    echo -en "$COLOR_WHITE[$COLOR_GREEN"
    for i in `seq 1 $NUM_BARS`
    do
        PERCENTAGE=$(($i * $BAR_VALUE))
        COLOR_END=0
        if (($PERCENTAGE>$BATT_LIFE)) && (($COLOR_END<1))
        then
            COLOR_END=1
            echo -en "$COLOR_GRAY"
        fi
        echo -n "|"
    done
    echo -en "$COLOR_WHITE]"

    #print (dis)charging status
    case "$BATT_STATE" in
        "charged"|"charging")
            echo -n '+'
            ;;
        "discharging")
            echo -n '-'
            ;;
    esac
    echo -en "$COLOR_NONE"
}

print_cord() {
    # Print cordy thing
    echo -en "$COLOR_WHITE=D$COLOR_GREEN"
    for i in `seq 1 $NUM_BARS`
    do
        PERCENTAGE=$(($i * $BAR_VALUE))
        COLOR_END=0
        if (($PERCENTAGE>$BATT_LIFE)) && (($COLOR_END<1))
        then
            COLOR_END=1
            echo -en "$COLOR_GRAY"
        fi
        echo -n "-"
    done
}

# First capture is the percentage, second is the state ("charging", etc.)
REGEX="([0-9]+)%; ([a-z]+)"
BATT_STATUS=`pmset -g batt`
NUM_BARS=6

# Execute the regex to capture the output
[[ "$BATT_STATUS" =~ $REGEX ]]
BATT_LIFE="${BASH_REMATCH[1]}"
BATT_STATE="${BASH_REMATCH[2]}"

# Percentage value of a single bar
BAR_VALUE=$((100 / $NUM_BARS))

# Figure out what battery color to use
if (($BATT_LIFE>50))
then
    BATT_COLOR=$COLOR_GREEN
elif (($BATT_LIFE>15))
then
    BATT_COLOR=$COLOR_YELLOW
else
    BATT_COLOR=$COLOR_RED
fi

# Output
case "$BATT_STATE" in
    "charged"|"charging")
        print_cord
        ;;
    "discharging")
        print_battery
        ;;
esac

echo -en " $COLOR_WHITE($BATT_LIFE%)"
