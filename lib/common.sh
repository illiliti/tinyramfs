# vim: set ft=sh:
# shellcheck shell=sh
#
# https://shellcheck.net/wiki/SC2154
# shellcheck disable=2154

print()
{
    printf "%s %s\n" "${2:-">>"}" "$1"
}

panic()
{
    print "${1:-unexpected error occurred}" '!>' >&2

    if [ "$$" = 1 ]; then
        sh
    else
        exit 1
    fi
}

# random()
# {
#     _sum=$(cksum < /proc/uptime)
#     printf '%s' "${sum% *}"
# }

# TODO ensure correctness
copy_file()
(
    file=$1; dest=$2

    [ -e "${tmpdir}/${dest}" ] && return

    while [ -h "$file" ]; do
        mkdir -p "${tmpdir}/${file%/*}"
        cp -P "$file" "${tmpdir}/${file}"
        cd -P "${file%/*}" || exit

        symlink=$(ls -ld "$file")
        symlink=${symlink##* -> }

        case $symlink in
            /*) file=$symlink ;;
            *)  file="${PWD}/${symlink##*/}" ;;
        esac
    done

    [ -h "${tmpdir}/${dest}" ] && dest=$file

    mkdir -p "${tmpdir}/${dest%/*}"
    cp "$file" "${tmpdir}/${dest}"

    [ "$3" ] && chmod "$3" "${tmpdir}/${dest}"

    # https://shellcheck.net/wiki/SC2015
    # shellcheck disable=2015
    [ "$4" ] && strip "${tmpdir}/${dest}" > /dev/null 2>&1 || :
)

copy_exec()
{
    _bin=$(command -v "$1")

    case $_bin in /*) ;;
        '')
            panic "unable to find command: $1"
        ;;
        *)
            # https://shellcheck.net/wiki/SC2086
            # shellcheck disable=2086
            { IFS=:; set -- $PATH; unset IFS; }

            for _dir; do
                __bin="${_dir}/${_bin}"

                [ -x "$__bin" ] && break
            done

            # https://shellcheck.net/wiki/SC2015
            # shellcheck disable=2015
            [ -x "$__bin" ] && _bin=$__bin || panic "unable to find command: $_bin"
        ;;
    esac

    copy_file "$_bin" "/bin/${_bin##*/}" 0755 1

    # TODO copy libs to the directory of interpreter.
    ldd "$_bin" 2> /dev/null |

    while read -r _lib || [ "$_lib" ]; do
        _lib=${_lib#* => }
        _lib=${_lib% *}

        [ -e "$_lib" ] && copy_file "$_lib" "$_lib" 0755 1
    done
}

copy_kmod()
{
    modprobe -S "$kernel" -D "$1" 2> /dev/null |

    while read -r _ _mod || [ "$_mod" ]; do
        case $_mod in /*) copy_file "$_mod" "$_mod" 0644; esac
    done
}

# TODO allow full path to hook
copy_hook()
{
    for _dir in "${local+./hook}" /etc/tinyramfs/hook.d /lib/tinyramfs/hook.d; do
        _hook="${_dir}/${1}/${1}"
        [ -f "$_hook" ] && break
    done

    [ -f "$_hook" ] || panic "unable to find hook: $1"

    for _ext in init init.late; do
        [ -f "${_hook}.${_ext}" ] || continue

        print "copying hook: ${1}.${_ext}"

        copy_file "${_hook}.${_ext}" "/lib/tinyramfs/hook.d/${1}/${1}.${_ext}" 0644
    done

    print "evaluating hook: $1"

    # https://shellcheck.net/wiki/SC1090
    # shellcheck disable=1090
    . "$_hook"
}

resolve_device()
{
    device=$1; _count=${2:-30}

    case ${device%%=*} in
        UUID)     device="/dev/disk/by-uuid/${device#*=}"     ;;
        LABEL)    device="/dev/disk/by-label/${device#*=}"    ;;
        PARTUUID) device="/dev/disk/by-partuuid/${device#*=}" ;;
        /dev/*)          ;;
        *)        return ;;
    esac

    # Race condition may occur if device manager is not yet initialized device.
    # To fix this, we simply waiting until device is available. If device
    # didn't appear in specified time, we panic.
    while :; do
        if [ -b "$device" ]; then
            return
        elif [ "$((_count -= 1))" = 0 ]; then
            break
        else
            sleep 1
        fi
    done

    panic "failed to lookup partition: $device"
}
