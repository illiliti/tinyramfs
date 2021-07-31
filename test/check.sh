#!/bin/sh

if [ "$(id -u)" != 0 ]; then
    printf '%s: must be run as root' "$0"
    exit 1
fi

if [ "$DEVMGR" ]; then
    :
elif command -v mdev; then
    DEVMGR=mdev
elif command -v mdevd; then
    DEVMGR=mdevd
elif command -v udevd; then
    DEVMGR=eudev
elif command -v /lib/systemd/systemd-udevd; then
    DEVMGR=systemd-udev
elif [ -e /proc/sys/kernel/hotplug ]; then
    DEVMGR=proc
else
    printf '%s: device manager not found' "$0" >&2
    exit 1
fi > /dev/null

export DEVMGR

if command -v modprobe > /dev/null; then
    modprobe kvm
    modprobe nbd
    modprobe zfs
fi

[ "$1" ] || set -- *.test

for file; do
    if [ "$DEBUG" ]; then
        "./${file}" 2>&1
    else
        "./${file}" > /dev/null 2>&1
    fi

    case $? in
        222) status=SKIP ;;
        0)   status=PASS ;;
        *)   status=FAIL ;;
    esac

    printf '%s: %s\n' "$file" "$status" >&2
done
