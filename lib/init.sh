#!/bin/sh
#
# https://shellcheck.net/wiki/SC2154
# https://shellcheck.net/wiki/SC2034
# shellcheck disable=2154,2034

init_base()
{
    mount -t proc     -o nosuid,noexec,nodev     proc /proc
    mount -t sysfs    -o nosuid,noexec,nodev     sys  /sys
    mount -t tmpfs    -o nosuid,nodev,mode=0755  run  /run
    mount -t devtmpfs -o nosuid,noexec,mode=0755 dev  /dev

    ln -s /proc/self/fd /dev/fd
    ln -s fd/0          /dev/stdin
    ln -s fd/1          /dev/stdout
    ln -s fd/2          /dev/stderr
}

eval_hooks()
{
    _type=$1

    # https://shellcheck.net/wiki/SC2086
    # shellcheck disable=2086
    { IFS=,; set -- $hooks; unset IFS; }

    for _hook; do
        [ -f "@@LIBDIR@@/tinyramfs/hook.d/${_hook}/${_hook}.${_type}" ] || continue
        [ "$rdbreak" = "$_hook" ] && panic "break before: ${_hook}.${_type}"

        # https://shellcheck.net/wiki/SC1090
        # shellcheck disable=1090
        . "@@LIBDIR@@/tinyramfs/hook.d/${_hook}/${_hook}.${_type}"
    done
}

parse_cmdline()
{
    # XXX /proc/cmdline can contain multiline data?
    read -r cmdline < /proc/cmdline

    # https://kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
    # ... parameters with '=' go into init's environment ...
    for _param in $cmdline; do case $_param in
        rdpanic) trap - EXIT ;;
        rddebug) set -x ;;

        # Maintain backward compatibility with kernel parameters.
        ro | rw)      rorw=$_param ;;
        rootwait)     root_wait=-1 ;;
        --)           init_args=${_param##*--}; break ;;
        rootfstype=*) root_type=${_param#*=} ;;
        rootflags=*)  root_opts=${_param#*=} ;;
        rootdelay=*)  root_wait=${_param#*=} ;;
    esac; done
}

mount_root()
{
    [ "$rdbreak" = root ] && panic 'break before: mount_root()'

    resolve_device "$root" "$root_wait"

    # https://shellcheck.net/wiki/SC2086
    # shellcheck disable=2086
    mount \
        -o "${rorw:-ro}${root_opts:+,$root_opts}" ${root_type:+-t "$root_type"} \
        -- "$device" /mnt/root || panic "failed to mount rootfs: $device"
}

boot_system()
{
    [ "$rdbreak" = boot ] && panic 'break before: boot_system()'

    for _dir in run dev sys proc; do
        mount -o move "/${_dir}" "/mnt/root/${_dir}" || :
    done

    # POSIX 'exec' has no '-c' flag to execute command with empty environment.
    # Use 'env -i' instead to prevent leaking exported variables.
    #
    # Some implementations of 'switch_root' doesn't conform to POSIX utility
    # guidelines and doesn't support '--'. This means that safety of init_args
    # isn't guaranteed.
    #
    # https://shellcheck.net/wiki/SC2086
    # shellcheck disable=2086
    exec \
        env -i TERM=linux PATH=/bin:/sbin:/usr/bin:/usr/sbin \
        switch_root /mnt/root "${init:-/sbin/init}" $init_args ||
        panic "failed to boot system"
}

# TODO add `quiet` support

# -e: Exit if command return status greater than 0
# -f: Disable globbing *?[]
set -ef

# Run emergency shell if init unexpectedly exiting due to error.
# TODO prompt to continue
trap panic EXIT

# https://shellcheck.net/wiki/SC1091
# shellcheck disable=1091
. @@LIBDIR@@/tinyramfs/common.sh

# https://shellcheck.net/wiki/SC1091
# shellcheck disable=1091
. /etc/tinyramfs/config

init_base
parse_cmdline
eval_hooks init
mount_root
eval_hooks init.late
boot_system
