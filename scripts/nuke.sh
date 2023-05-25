#!/usr/bin/env bash
# vi: et sts=4 sw=4 tw=80 cc=+1

ITERATIONS=3
ZERO_PASS=1
RANDOM_SOURCE=/dev/urandom

BLUE="\e[94m"
BOLD="\e[1m"
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

function help() {
    cat << EOF
$(basename $0) [-h] [-n iterations] [disk]

Erases a disk by writing random data and/or zeroes to it. Options are passed
through to shred; see man shred for more information.

When given a disk to operate on, the given device will be erased. When omitted,
the script will prompt for a drive to erase interactively.

This script will do a basic sanity check to ensure that the given device file
exists, but bear in mind that erasing disks is inherently VERY DANGEROUS. Make
sure you have appropriate backups and have selected the correct disk to wipe!
EOF
    exit
}

function usage() {
    echo >&2 "Usage: $0 [-h] [-n iterations] [disk]"
    exit 1
}

function prompt() {
    echo -en "${GREEN}=>${RESET} $1"
}

function die() {
    echo -e >&2 "${RED}ERROR:${RESET} $1"
    exit 1
}

function step() {
    echo -e "${BLUE}=>${RESET} $1"
}

function select_disk() {
    step "Select a disk to nuke"
    lsblk --list --nodeps --output NAME,PATH,PTTYPE,SIZE,VENDOR,MODEL,SERIAL
    echo

    prompt "Disk NAME or PATH: "
    read -r SHRED_FILE
}

if [ $UID -eq 0 ]; then 
    die "Refusing to run as root"
fi

while getopts ":hn:" OPTION; do
    case "$OPTION" in
        h)
            help
            ;;
        n)
            ITERATIONS="$OPTARG"
            ;;
        ?)
            usage
            ;;
    esac
done

SHRED_FILE=${@:$OPTIND:1}
if [ -z "$SHRED_FILE" ]; then
    select_disk
fi

# Convert stuff like "sdb" to "/dev/sdb"
if ! [[ "$SHRED_FILE" = "/dev/"* ]]; then
    SHRED_FILE=${SHRED_FILE/#//dev/}
fi

# Validate that whateever disk was given actually exists
VALID_DISKS=$(lsblk --list --nodeps --output PATH --noheadings)
if ! echo "$VALID_DISKS" | grep --line-regexp "$SHRED_FILE" > /dev/null; then
    die "The specified disk was not found"
fi

# Quit on any errors from here out
set -e

DISK_SIZE=$(lsblk -o SIZE "$SHRED_FILE" | tail -n +2 | awk '{print $1}')

cat << EOF

File:              $SHRED_FILE ($DISK_SIZE)
Random source:     $RANDOM_SOURCE
Random passes:     $ITERATIONS
Zero passes:       $ZERO_PASS

EOF

prompt "You are about to ${BOLD}PERMANENTLY${RESET} destroy ${BOLD}ALL${RESET} \
data on ${BOLD}${SHRED_FILE}${RESET}. Continue? [y/N]: "
read -r CONFIRM

case "$CONFIRM" in
    [yY])
        echo
        step "Wiping $SHRED_FILE"
        ;;
    *)
        die "Aborted by user"
        ;;
esac

# Reset bash-internal SECONDS variable
SECONDS=0

sudo shred \
    --iterations "$ITERATIONS" \
    --random-source $RANDOM_SOURCE \
    --zero \
    --verbose \
    "$SHRED_FILE"

# Calculate delta time (in seconds) and convert it to h/m/s
DT=$SECONDS
H=$((DT/60/60%24))
M=$((DT/60%60))
S=$((DT%60))

# I'll never not do this
if [ "$ITERATIONS" -eq 1 ]; then
    PASSES="pass"
else
    PASSES="passes"
fi

# Status report
printf "Wrote ${BLUE}${ITERATIONS}${RESET} random ${PASSES} \
and ${BLUE}1${RESET} zero pass in %02d:%02d:%02d\n" "$H" "$M" "$S"

echo -e "${GREEN}Done! ${SHRED_FILE} is now clean${RESET}"
