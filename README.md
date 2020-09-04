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

* POSIX utilities
* POSIX shell
* `switch_root`
* `mount`
* `cpio`
* `strip`
  - Optional
* `blkid`
  - Required for UUID, LABEL, PARTUUID support
* `mdev` OR `mdevd` OR `eudev` OR `systemd-udevd` OR CONFIG_UEVENT_HELPER
  - systemd-udevd not tested
* `lvm2`
  - Required for LVM support
* `cryptsetup`
  - Required for LUKS support
* `busybox loadkmap`
  - Required for loading keymap
* `kmod` OR `busybox modutils` with [this patch](https://gist.github.com/illiliti/ef9ee781b5c6bf36d9493d99b4a1ffb6) (already included in KISS Linux)
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
# read man pages and setup /etc/tinyramfs/config
tinyramfs -o /boot/initramfs-<ver> # replace <ver> with current kernel version
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
