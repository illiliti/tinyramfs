Tinyramfs
=========

**Currently tinyramfs is incomplete, don't expect that everything is working**

Features
--------

- No `local`'s, no bashisms, only POSIX shell
- Easy configuration
- mdev, mdevd, eudev
- LUKS, LVM
- LUKS detached header and key embedded into initramfs

Dependencies
------------

* POSIX utilities ( find, mkdir, ... )
* POSIX shell
* `switch_root`
* `readlink`
* `install`
* `mount`
* `blkid`
* `cpio`
* `strip`
  - Optional
* `gzip`
  - Required by default
* `mdev` OR `mdevd` OR `eudev`
  - systemd-udevd not tested
* `lvm2`
  - Required for LVM support
* `cryptsetup`
  - Required for LUKS support
* `kmod` OR `busybox modutils` with [this patch](https://gist.github.com/illiliti/ef9ee781b5c6bf36d9493d99b4a1ffb6) (already included in KISS Linux)
  - Not required for monolithic kernel

Notes
-----

* busybox modutils doesn't handle soft dependencies (modules.softdep). You must manually include them using `modules` config option
* busybox and toybox blkid doesn't support PARTUUID. You must use util-linux blkid
* zsh (in POSIX mode) shows some errors in init stage. Just ignore these errors, it's harmless
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

Usage
-----

```
usage: tinyramfs [option]
       -o, --output <file> set initramfs output path
       -c, --config <file> set config file path
       -m, --moddir <dir>  set modules directory
       -k, --kernel <ver>  set kernel version
       -F, --files  <dir>  set files directory
       -d, --debug         enable debug mode
       -f, --force         overwrite initramfs image
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
