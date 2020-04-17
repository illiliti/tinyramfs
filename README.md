Tinyramfs
=========

**Currently tinyramfs is incomplete, don't expect that everything is working**

Features
--------

- No `local`'s, no bashisms, only POSIX shell
- Easy configuration
- mdev, mdevd, eudev
- LUKS
- LVM

Dependencies
------------

* POSIX shell
* POSIX utilities
* `switch_root`
* `readlink`
* `install`
* `setsid`
* `mount`
* `cpio`
* `gzip`
  - Required by default
* `strip`
  - Optional
* `blkid`
  - Required for mdev/mdevd
* `mdev` OR `mdevd` OR `eudev`
  - systemd-udevd not tested
* `lvm2`
  - Required for LVM support
* `cryptsetup`
  - Required for LUKS support
* `kmod` OR `busybox modutils` with [this patch](https://gist.github.com/illiliti/ef9ee781b5c6bf36d9493d99b4a1ffb6) (already included in KISS Linux)
  - Not required for monolithic kernel (builtin modules)

Notes
-----

* busybox and toybox blkid doesn't support PARTUUID
* zsh (in POSIX mode) showing some errors, but working fine
* cp -P is broken in toybox, see [here](https://github.com/landley/toybox/issues/174)

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

Static via config
-----------------

See [config](config)

Dynamic via kernel parameters
-----------------------------

TODO finalize and document kernel command-line parameters

Thanks
------

[E5ten](https://github.com/E5ten)
[dylanaraps](https://github.com/dylanaraps)

License
-------

Licensed under GPLv3
