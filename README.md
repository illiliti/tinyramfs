Tinyramfs
=========

**Currently tinyramfs is incomplete, don't expect that everything is working**

Features
--------

- No `local`'s, no bashisms, only POSIX shell
- Portable, not distro specific
- Easy to use configuration
- Build time and init time hooks
- LUKS (detached header, key), LVM
- mdev, mdevd, eudev, systemd-udevd

Dependencies
------------

* POSIX make (build time)
* POSIX utilities
* POSIX shell
* `switch_root`
* `mount`
* `cpio`
* `ldd`
  - Optional. Required for copying binary dependencies
* `strip`
  - Optional. Required for reducing image size by stripping binaries
* `blkid`
  - Optional. Required for UUID, LABEL, PARTUUID support
* `mdev` OR `mdevd` OR `eudev` OR `systemd-udevd` OR CONFIG_UEVENT_HELPER
  - Optional. Required for modular kernel, /dev/mapper/* and /dev/disk/* creation
* `lvm2`
  - Optional. Required for LVM support
* `cryptsetup`
  - Optional. Required for LUKS support
* `busybox loadkmap`
  - Optional. Required for keymap support
* `kmod` OR `busybox modutils` with [patch](https://gist.github.com/illiliti/ef9ee781b5c6bf36d9493d99b4a1ffb6) (already included in KISS Linux)
  - Not required for monolithic kernel

Installation
------------

```sh
git clone https://github.com/illiliti/tinyramfs
cd tinyramfs
make install
```

Usage
-----

```sh
# read tinyramfs.config(5) and setup /etc/tinyramfs/config
# run as root
tinyramfs -o "/boot/initramfs-$(uname -r)"
# update your bootloader
# reboot...
```

Thanks
------

[E5ten](https://github.com/E5ten)  
[dylanaraps](https://github.com/dylanaraps)

Donate
------

You can donate if you like this project

BTC: 1BwrcsgtWZeLVvNeEQSg4A28a3yrGN3FpK
