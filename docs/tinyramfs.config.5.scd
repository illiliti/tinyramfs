tinyramfs.config(5)

# NAME

Tinyramfs - configuration file

# SYNOPSIS

*/etc/tinyramfs/config*

# DESCRIPTION

Let's reduce confusing situations and document everything !

## MAN PAGE SYNTAX

```
*   - any value
[a] - optional value
... - can be repeated
0|1 - choice between no and yes
```

## CONFIG SYNTAX

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

# GENERAL OPTIONS

*monolith*=0|1

	Monolithic kernel means kernel with builtin modules.
	If you didn't build kernel yourself, then in most cases you have
	modular kernel and you don't need to enable this option. To check
	if you have monolithic you need to check if */lib/modules/<kernel
	version>/modules* exist. If this directory doesn't exist you probably 
	have monolithic kernel which means you need to set *monolith* to *1*.

*hostonly*=0|1

	Hostonly mode enumerates *sysfs*(5) and copies only neccessary modules
	instead of copying all modules. Which means that this mode can dramatically
	reduce initramfs size. This option ignored if *monolith* was set to *1*.

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

*lvm_opts*=[tag, name, group, config, discard]

	- tag - trigger lvm by tag
	- name - trigger lvm by logical volume name. group must be specified
	- group - trigger lvm by volume group name
	- config - embed /etc/lvm.conf config
	- discard - enable issue_discards

*luks_opts*=root=UUID|LABEL|/dev/\*|PARTUUID, [key, name, header, discard]

	- key - embed key
	- name - device mapper name
	- root - encrypted root
		- UUID     - lookup device by uuid
		- LABEL    - lookup device by label
		- /dev/\*   - lookup device by full path
		- PARTUUID - lookup device by partition uuid
	- header - embed header
	- discard - enable allow-discards

*keymap_path*=/path/to/keymap

	Specify location to binary keymap.
	Currently, this hook supports loading keymap only via busybox loadkmap.
	kbd loadkeys not supported.

# EXAMPLES

Remember, it's just examples ! Don't copy blindly ! Your configuration may
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

## ROOT + LUKS

```
hooks="mdev luks"
root=LABEL=my_root
luks_opts=root=PARTUUID=35f923c5-083a-4950-a4da-e611d0778121
luks_opts="${luks_opts},key=/root/key,header=/root/header,discard=1"
```

## ROOT + LVM + LUKS

```
compress="lz4 -9"
hooks="eudev lvm luks"
luks_opts=root=/dev/sdb2,discard=1
lvm_opts=name=lvm1,group=lvm_grp2,config=1,discard=1
root=/dev/disk/by-uuid/aa82d7bb-ab2b-4739-935f-fd8a5c9a6cb0
```

# SEE ALSO

*tinyramfs*(8) *tinyramfs.cmdline*(7) *tinyramfs.hooks*(7)
