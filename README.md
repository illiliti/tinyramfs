Features
--------

- No `local`'s, no bashisms, only POSIX shell
- Easy configuration
- LUKS
- LVM
- mdev, mdevd, eudev

Installation
------------

Dependencies
------------

* POSIX shell
* `toybox` OR `busybox` OR `sbase/ubase` OR `coreutils/util-linux`
* `mdev` OR `mdevd` OR `eudev`
* `kmod`
  - Not required for monolithic kernel (builtin modules)
* `cryptsetup`
  - Required for LUKS support
* `lvm2`
  - Required for LVM support

Usage
-----

```
usage: ./tinyramfs [option]
       -o, --output <file>  set initramfs output path
       -c, --config <file>  set config file path
       -m, --moddir <dir>   set modules directory
       -k, --kernel <ver>   set kernel version
       -F, --files  <dir>   set files directory
       -d, --debug          enable debug mode
       -f, --force          overwrite initramfs image
```

Configuration
-------------

```sh
# debug mode
#
debug=0

# overwrite initramfs
#
force=0

# initramfs output path
#
# default - /tmp/initramfs-$kernel
# example - output="/tmp/myinitramfs.img.gz"
#
output=""

# monolithic kernel
#
monolith=0

# modules directory
#
# default - /lib/modules
# example - moddir="/mnt/root/lib/modules"
#
moddir=""

# kernel version
#
# default - $(uname -r)
# example - kernel="5.4.18_1"
#
kernel=""

# compression program
#
# default - gzip -9
# example - compress="pigz -9"
#
compress=""

# root
#
# supported - PARTUUID, DEVICE, LABEL, UUID
# example -
#   root="/dev/sda1"
#   root="PARTUUID=35f923c5-083a-4950-a4da-e611d0778121"
#
root=""

# root type
#
# default - autodetected
# example - root_type="btrfs"
#
root_type=""

# root options
# example - see fstab(5)
#
root_opts=""

# device manager
# supported - udev, mdev, mdevd
#
devmgr=""

# hostonly mode
#
hostonly=0

# additional modules
# example - modules="fat crc32c_generic"
#
modules=""

# exclude modules
# example - modules_exclude="wmi fuse"
#
modules_exclude=""

# additional binaries
# example - binaries="ls cat /path/to/mycustomprog"
#
binaries=""

# LVM support
#
lvm=0

# LVM options
#
# supported - tag, name, group, config, discard
# description -
#   tag - trigger lvm by tag
#   name - trigger lvm by logical volume name
#   group - trigger lvm by volume group name
#   config - embed host lvm config
#   discard - enable issue_discards
# example -
#   lvm_opts="tag=lvm-server"
#   lvm_opts="name=lv1,group=vg1"
#   lvm_opts="config=1,discard"
#   lvm_opts="discard=1"
#
lvm_opts=""

# LUKS support
#
luks=0

# LUKS encrypted root
#
# supported - PARTUUID, DEVICE, LABEL, UUID
# example -
#   luks_root="/dev/sda1"
#   luks_root="PARTUUID=35f923c5-083a-4950-a4da-e611d0778121"
#
luks_root=""

# LUKS options
#
# supported - key, name, header, discard
# description -
#   key - embed key
#   name - device mapper name
#   header - embed header
#   discard - enable allow-discards
# example -
#   luks_opts="key=/path/to/keyfile,name=myluksroot,header=/path/to/header,discard"
#   luks_opts="discard=1"
#
luks_opts=""
```

TODO document kernel command-line parameters

License
-------

Licensed under GPLv3
