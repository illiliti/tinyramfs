#!/bin/sh -f
#
# Load modules via $MODALIAS.
# Create /dev/disk/by-* and /dev/mapper/* symlinks.

create_symlink()
{
    typ=$1; sym=$2

    sym=${sym%\"}
    sym=${sym#\"}
    sym="/dev/disk/by-${typ}/${sym}"

    mkdir -p "${sym%/*}"
    ln    -s "../../${dev_name}" "$sym"
}

exec > /dev/null 2>&1

[ "$MODALIAS" ] && modprobe "$MODALIAS"
[ "$SUBSYSTEM" = block ] && [ -b "/dev/${dev_name=${DEVPATH##*/}}" ] || exit 1

read -r dm_name < "/sys/block/${dev_name}/dm/name" && {
    mkdir -p /dev/mapper
    ln    -sf "../${dev_name}" "/dev/mapper/${dm_name:?}"
}

command -v blkid || exit 0

# Race condition may occur if uevent arrives faster(isn't that a kernel bug!?)
# than the kernel initializes device. This prevents blkid to fetch data from
# device. To fix this, we simply waiting until blkid is succeeded.
while ! _blkid=$(blkid "/dev/${dev_name}"); do
    if [ "$((count += 1))" = 10 ]; then
        exit 1
    else
        sleep 1
    fi
done

for line in $_blkid; do case           ${line%%=*} in
    UUID)     create_symlink uuid     "${line#*=}" ;;
    LABEL)    create_symlink label    "${line#*=}" ;;
    PARTUUID) create_symlink partuuid "${line#*=}" ;;
esac; done
