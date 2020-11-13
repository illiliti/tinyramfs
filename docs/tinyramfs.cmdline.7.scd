tinyramfs.cmdline(7)

# NAME

Tinyramfs - kernel command-line parameters

# DESCRIPTION

Tinyramfs provides a way to control configuration dynamically via
kernel parameters without needing to regenerate initramfs image. 

## MAN PAGE SYNTAX

```
|   - OR
... - can be repeated
```

# GENERAL PARAMETERS

*debug*=1

	Enable debug mode.

*break*=breakpoint

	Specify breakpoint where shell should be invoked. Useful for
	debugging. List of builtin breakpoints:

	- root
	- boot

	Hooks can provide their own breakpoints. See source code of hooks
	for more information.

*root*=UUID|LABEL|/dev/\*|PARTUUID

	Specify which way tinyramfs will use to look up root filesystem.

	- UUID     - lookup device by uuid
	- LABEL    - lookup device by label
	- /dev/\*   - lookup device by full path
	- PARTUUID - lookup device by partition uuid

	Initramfs must contain *blkid*(8) for ability to use UUID, LABEL,
	PARTUUID. Note that PARTUUID only supported in util-linux *blkid*(8).

*root_type*|*rootfstype*=type

	Explicitly set root filesystem type. Kernel must support specified type.
	
*rootdelay*=delay

	Specify maximum number of seconds to wait for root device. Default is 30.

*root_opts*|*rootflags*=opts
	
	See *fstab*(5) fourth field.

# HOOKS PARAMETERS

Initramfs must contain appropriate hooks for ability to use below parameters.

## LIVE

*live_disk*=LABEL

	Specify LABEL from the live disk to boot from.

*live_img_file*=/path/to/pseudo-fs

	Specify location to the pseudo-fs image file.

*live_ram_opts*=opts

	Options for ram mountpoint.

*live_sfs_opts*=opts

	Options for pseudo-fs mountpoint.

## LVM

*lvm_tag*=tag

	Specify LVM tag which will be used to trigger LVM. This option will be
	ignored if *lvm_name*/*lvm_group* was specified.

*lvm_name*=name

	Specify LVM name which will be used to trigger LVM. *lvm_group* must be
	specified.

*lvm_group*=group

	Specify LVM group which will be used to trigger LVM.

*lvm_discard*=1

	Pass issue_discards to lvm. Leave empty to disable. Useful for SSD's.

## LUKS

*luks_name*=name

	Specify which name will be registered to mapping table after cryptsetup
	unlocks LUKS root.

*luks_root*=UUID|LABEL|/dev/\*|PARTUUID

	See *root* for details.

*luks_discard*=1

	Pass --allow-discards to *cryptsetup*. Leave empty to disable. Useful for
	SSD's, but you must know that security will be decreased.

# EXAMPLES

## ROOT

```
vmlinuz initrd=\initramfs root=/dev/sda1 ...
```

## DISABLE DISCARD

```
vmlinuz initrd=\\initramfs luks_discard= lvm_discard= ...
```

## PASS ARGUMENTS TO REAL INIT

```
vmlinuz initrd=\\initramfs ... -- args
```

## BOOT FROM RAM IN LIVE CD
```
vmlinuz initrd=\\initramfs ram
```

# SEE ALSO

*tinyramfs*(8) *tinyramfs.config*(5) *tinyramfs.hooks*(7)
tinyramfs.config(5)
