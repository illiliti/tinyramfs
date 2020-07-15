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
* `mdev` OR `mdevd` OR `eudev` OR `systemd-udevd`
  - systemd-udevd not tested
* `lvm2`
  - Required for LVM support
* `cryptsetup`
  - Required for LUKS support
* `kmod` OR `busybox modutils` with [this patch](https://gist.github.com/illiliti/ef9ee781b5c6bf36d9493d99b4a1ffb6) (already included in KISS Linux)
  - Not required for monolithic kernel

Notes
-----

* busybox modutils doesn't handle soft dependencies (modules.softdep). You must manually copy them using hooks
* busybox and toybox blkid doesn't support PARTUUID. You must use util-linux blkid for PARTUUID support
* `cp` in toybox incorrectly handles `-P` flag. You need to apply patch from [this issue](https://github.com/landley/toybox/issues/174) or replace cp with another implementation

Installation
------------

```sh
git clone https://github.com/illiliti/tinyramfs
cd tinyramfs
make install
vi /etc/tinyramfs/config # edit config for your needs
tinyramfs -o /boot/initramfs
# update your bootloader
# reboot...
```

Configuration
-------------

Statically via config
-----------------

See [config](config)

Dynamically via kernel parameters
-----------------------------

TODO finalize and document kernel command-line parameters

Thanks
------

[E5ten](https://github.com/E5ten)  
[dylanaraps](https://github.com/dylanaraps)

License
-------

Licensed under GPLv3
