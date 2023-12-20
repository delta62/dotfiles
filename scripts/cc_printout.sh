#!/usr/bin/env bash

# Print out a CSV containing account debits and credits into a table
# The colums are assumed to be
# * post date
# * <unused>
# * <unused>
# * description
# * <unused>
# * debit
# * credit
#
# ACH descriptors are assumed to be 24 characters or less. This should
# be fine as the max is supposed to be 22 characters.

set -e

INPUT_FILE="$1"
REGEX="$2"

function divider() {
    printf "%0.s-" {1..63}
    echo
}

divider
printf "| %-10s | %-24s | %-8s | %-8s |\n" Date Description Debit Credit
divider
cat "$INPUT_FILE" | \
    grep -e "$REGEX" | \
    awk -F ',' '{printf "| %s | %-24s | -$%-6.2f | +$%-6.2f |\n", $1, $4, $6, $7}' | \
    sort
divider
