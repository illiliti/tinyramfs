# initramfs
Just another one implemetation of initramfs

Features
--------
- POSIX compliance
- Easy configuration
- LUKS
- LVM
- mdev,mdevd and eudev

Dependencies
------------
### Basic
```
busybox
kmod
```
### Optional
```
cryptsetup - LUKS support
lvm2 - LVM support
util-linux - PARTUUID support
```

Installation
------------
```
git clone https://github.com/illiliti/initramfs
cd initramfs
```

Configuration
-------------
TODO

License
-------
Licensed under GPLv3

Exceptions:

The "mdev.conf" configuration file is modified version from "mdev-like-a-boss" project, Copyright (c) 2012-2020, Piotr Karbowski <piotr.karbowski@gmail.com>.
Please consult the license notice in the file for terms and conditions.

The "storage-device" script from "mdev-like-a-boss" project, Copyright (c) 2012-2020, Piotr Karbowski <piotr.karbowski@gmail.com>.
Please consult the license notice in the file for terms and conditions.
