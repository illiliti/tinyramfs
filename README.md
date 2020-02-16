# initramfs
Just another one implemetation of initramfs

Features
--------
- POSIX compliance
- Easy configuration
- LUKS
- LVM
- mdev,mdevd and eudev

Installation
------------
Requirements:
* busybox
  - --install [-s] [DIR]
  - mdev
  - uevent
  - switch_root
  - mount
  - umount
  - blkid
* kmod
* cryptsetup - LUKS 
* lvm2 - LVM
* util-linux - PARTUUID 

Download & Setup:
```
git clone https://github.com/illiliti/initramfs
cd initramfs
```
TODO

Configuration
-------------
TODO

License
-------
Licensed under GPLv3

Exceptions:

The "mdev.conf" configuration file is modified version from "mdev-like-a-boss" project, Copyright (c) 2012-2020, Piotr Karbowski <piotr.karbowski@gmail.com>.
Please consult the license notice in the file for terms and conditions.

The "storage-device" script is modified version from "mdev-like-a-boss" project, Copyright (c) 2012-2020, Piotr Karbowski <piotr.karbowski@gmail.com>.
Please consult the license notice in the file for terms and conditions.
