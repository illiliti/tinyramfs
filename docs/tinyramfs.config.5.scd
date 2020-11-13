tinyramfs.config(5)

# NAME

Tinyramfs - configuration file

# SYNOPSIS

*/etc/tinyramfs/config*

# DESCRIPTION

Tinyramfs configuration file is a list of environment variables.
Each variable must be written in POSIX way, bashism not allowed.

Example:

```
key=value
```

If value contains spaces it must must be quoted.

```
key="value value2"
```

If value contains special symbols like $, it must be escaped
or quoted using single quotes.

```
key=\\$value
key='$value'
```

If line exceeded maximum space on your display and you want to make it
more readable, you can concatenate them.

```
key=value
key="${key}value"
```

If you want to temporary undefine variable without actually deleting it,
you can simply prepend \#.

```
#key=value
```

## MAN PAGE SYNTAX

```
|   - OR
*   - any value
[a] - optional value
... - can be repeated
```

# GENERAL OPTIONS

*monolith*=1

	Monolithic kernel means kernel with builtin modules.
	If you didn't build kernel yourself, then in most cases you have
	modular kernel and you don't need to enable this option. To check
	if you have monolithic you need to check if */lib/modules/<kernel
	version>/modules* exist. If this directory doesn't exist you probably 
	have monolithic kernel which means you need to set *monolith* to *1*.

*hostonly*=1

	Hostonly mode enumerates *sysfs*(5) and copies only neccessary modules
	instead of copying all modules. Which means that this mode can dramatically
	reduce initramfs size. This option will be ignored if *monolith* was set
	to *1*.

*compress*=command [args ...]

	Specify which command will be used to compress initramfs image.
	There is a lot of commands you can use, such as:

	- xz
	- zst (if supported by kernel)
	- gzip
	- bzip2
	- and many more ...

	You can set compression level by specifing -[0-9] in args.
	For example - gzip -9.

*root*=UUID|LABEL|/dev/\*|PARTUUID

	Specify which way tinyramfs will use to look up root filesystem.

	- UUID     - lookup device by uuid
	- LABEL    - lookup device by label
	- /dev/\*   - lookup device by full path
	- PARTUUID - lookup device by partition uuid

	You must install *blkid*(8) (avalable in toybox, busybox, util-linux)
	for ability to use UUID, LABEL, PARTUUID. Note that PARTUUID only
	supported in util-linux *blkid*(8).
	
*root_type*=type

	Explicitly set root filesystem type instead of automatically discovering via
	/proc/mounts. This option must be specified if you booted from Live CD.

*root_opts*=opts
	
	See *fstab*(5) fourth field.

*hooks*=hook [hook ...]

	Hooks provide a flexible way to extend tinyramfs with custom scripts.
	You must know that *hooks are launched in the order in which they are
	specified*. List of shipped by default hooks:

	- lvm - LVM support
	- luks - LUKS support 
	- live - live support
	- mdev - mdev support
	- proc - CONFIG_UEVENT_HELPER support
	- mdevd - mdevd support
	- eudev - eudev support
	- keymap - keymap support
	- systemd-udevd - systemd udevd support

	See below how to use them.
	If hook doesn't have options, then it's not yet documented or can be used
	"as is".

	More detailed information and how to write your own hooks described in
	*tinyramfs.hooks*(7).

# HOOKS OPTIONS

## LIVE

*live_disk*=LABEL

	Specify LABEL from the live disk to boot from.

*live_img_file*=/path/to/pseudo-fs

	Specify location to the pseudo-fs image file.

*live_ram_opts*=opts

	Options for ram mountpoint.

*live_sfs_opts*=opts

	Options for pseudo-fs mountpoint.

## LVM

*lvm_tag*=tag

	Specify LVM tag which will be used to trigger LVM. This option will be
	ignored if *lvm_name*/*lvm_group* was specified.

*lvm_name*=name

	Specify LVM name which will be used to trigger LVM. *lvm_group* must be
	specified.

*lvm_group*=group

	Specify LVM group which will be used to trigger LVM.

*lvm_config*=1

	Include */etc/lvm/lvm.conf* in initramfs.

*lvm_discard*=1

	Pass issue_discards to lvm. Useful for SSD's.

## LUKS

*luks_key*=/path/to/key

	Specify location to key.
	GPG-encrypted key currently not supported.

*luks_name*=name

	Specify which name will be registered to mapping table after cryptsetup
	unlocks LUKS root.

*luks_root*=UUID|LABEL|/dev/\*|PARTUUID

	See *root* for details.

*luks_header*=/path/to/header

	Specify location to detached header.

*luks_discard*=1

	Pass --allow-discards to *cryptsetup*. Useful for SSD's, but you must know
	that security will be decreased.

## KEYMAP

*keymap_path*=/path/to/keymap

	Specify location to binary keymap.
	Currently, this hook supports loading keymap only via busybox loadkmap.
	kbd loadkeys not supported.

# EXAMPLES

Remember, these just examples ! _Don't copy blindly_ ! Your configuration may
(and should) differ.

## ROOT

```
hooks=eudev
root=/dev/sda1
```

## ROOT + MONOLITH + PROC (CONFIG_UEVENT_HELPER)

```
hooks=proc
monolith=1
root=/dev/nvme0n1p1
```

## ROOT + COMPRESS

```
hostonly=1
hooks=mdevd
compress="gzip -9"
root=PARTUUID=8e05009d-a1d5-4fdb-b407-b0e79360555c
```

## ROOT + KEYMAP

```
root_type=f2fs
hooks="eudev keymap"
root=UUID=13bcb7cc-8fe5-4f8e-a1fe-e4b5b336f3ef
keymap_path=/usr/share/bkeymaps/colemak/en-latin9.bmap
```

## ROOT + LIVE

```
hooks="mdev live"

root=overlay
root_type="$root"

live_disk=LIVECD
live_img_file=system/livefs.sfs
live_ram_opts="size=50%,mode=0755"
```

## ROOT + LUKS

```
hooks="mdev luks"
root=LABEL=my_root

luks_discard=1
luks_key=/root/key
luks_header=/root/header
luks_root=PARTUUID=35f923c5-083a-4950-a4da-e611d0778121
```

## ROOT + LVM + LUKS

```
compress="lz4 -9"
hooks="eudev lvm luks"
root=/dev/disk/by-uuid/aa82d7bb-ab2b-4739-935f-fd8a5c9a6cb0

luks_discard=1
luks_root=/dev/sdb2

lvm_config=1
lvm_discard=1
lvm_name=lvm1
lvm_group=lvm_grp2
```

# SEE ALSO

*tinyramfs*(8) *tinyramfs.cmdline*(7) *tinyramfs.hooks*(7)
