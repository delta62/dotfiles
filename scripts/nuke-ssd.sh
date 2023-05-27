#!/usr/bin/env bash
# vi: et sts=4 sw=4 tw=80 cc=+1
#
# This script roughly follows the steps laid out in the Arch wiki here:
# https://wiki.archlinux.org/title/Solid_state_drive/Memory_cell_clearing#SATA_drive

set -e

PASSWORD="password"
BLUE="\e[94m"
BOLD="\e[1m"
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

function help() {
    cat << EOF
$(basename $0) [disk]

Erases a solid state disk by invoking the manufacturer's secure erase function.

When given a disk to operate on, the given device will be erased. When omitted,
the script will prompt for a drive to erase interactively.

This script will do a basic sanity check to ensure that the given device file
exists, but bear in mind that erasing disks is inherently VERY DANGEROUS. Make
sure you have appropriate backups and have selected the correct disk to wipe!

Some drives instantly report themselves as wiped, which is suspicious. The
script will print the total duration that was taken for the wipe, so if it's too
low you may need to physically destroy the disk.
EOF
    exit
}

function usage() {
    echo >&2 "Usage: $(basename $0) [disk]"
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

# Retrieve a security setting for a given device
# $1: Device name to query security settings for
# $2: The setting to query for
#
# This function will echo "true" if the setting is enabled, or "false" otherwise
#
# Example: security_param_state /dev/sde frozen
# > false
function security_param_state() {
    local STATE=$(sudo hdparm -I "$1")

    echo "$STATE" | awk \
        "/^[[:alpha:]]/{s=\$1} \
        s==\"Security:\" && \$1==\"not\" && \$2==\"$2\" {print \"false\"; next} \
        s==\"Security:\" && \$1==\"$2\" {print \"true\"}"
}

if [ $UID -eq 0 ]; then
    die "Refusing to run as root. This script will prompt for the root \
password when it's required."
fi

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

prompt "You are about to ${BOLD}PERMANENTLY${RESET} destroy ${BOLD}ALL${RESET} \
data on ${BOLD}${SHRED_FILE}${RESET}. Continue? [y/N]: "
read -r CONFIRM

case "$CONFIRM" in
    [yY])
        ;;
    *)
        die "Aborted by user"
        ;;
esac

step "Ensuring the drive isn't frozen"
FROZEN_STATE=$(security_param_state "$SHRED_FILE" "frozen")
if [ "$FROZEN_STATE" = "true" ]; then
    die "This drive appears to be frozen. Unfreeze it before continuing."
fi

step "Enabling device security; setting user password to \"$PASSWORD\""
sudo hdparm --user-master u --security-set-pass "$PASSWORD" "$SHRED_FILE"

step "Querying device for estimated wipe time"
sudo hdparm -I "$SHRED_FILE" | grep "SECURITY ERASE UNIT" | sed -E 's/^\s*/   /'

step "Validating that device security is enabled"
SECURITY_STATE=$(security_param_state "$SHRED_FILE" "enabled")
if [ "$SECURITY_STATE" = "false" ]; then
    die "Security must be enabled for this drive"
fi

# Reset bash-internal SECONDS variable
SECONDS=0

# Where supported, use the enhanced security erase mode
if sudo hdparm -I "$SHRED_FILE" | grep "ENHANCED SECURITY ERASE UNIT" > /dev/null; then
    step "Invoking drive's enhanced security erase feature"
    sudo hdparm --user-master u --security-erase-enhanced "$PASSWORD" "$SHRED_FILE"
else
    step "Invoking drive's security erase feature"
    sudo hdparm --user-master u --security-erase "$PASSWORD" "$SHRED_FILE"
fi

DT=$SECONDS

step "Validating that security has been disabled on the drive"
SECURITY_STATE=$(security_param_state "$SHRED_FILE" "enabled")
if [ "$SECURITY_STATE" = "true" ]; then
    die "Security was not disabled after the wipe completed"
fi

# Calculate delta time (in seconds) and convert it to h/m/s
H=$((DT/60/60%24))
M=$((DT/60%60))
S=$((DT%60))

# Status report
printf "Completed in %02d:%02d:%02d\n" "$H" "$M" "$S"
echo -e "${GREEN}Done! ${SHRED_FILE} is now clean${RESET}"
