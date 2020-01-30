# initramfs
Just another one implemetation of initramfs

### Features
- POSIX compliant
- Easy configuration without complexity
- LUKS detached header and keyfile
- LVM
- busybox mdev,mdevd and eudev are supported

### Installation
Simply run as root generate script. Then move generated initramfs to /boot directory and update your bootloader

### Dependencies
#### Basic
`busybox kmod util-linux`
#### Optional
`cryptsetup lvm2 device-mapper`

### License
Licensed under GPLv3

Exceptions:

The "mdev.conf" configuration file is modified version from "mdev-like-a-boss" project, Copyright (c) 2012-2020, Piotr Karbowski <piotr.karbowski@gmail.com>
Please consult the license notice in the file for terms and conditions.

The "storage-device" script from "mdev-like-a-boss" project, Copyright (c) 2012-2020, Piotr Karbowski <piotr.karbowski@gmail.com>
Please consult the license notice in the file for terms and conditions.
