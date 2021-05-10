tinyramfs(8)

# NAME

Tinyramfs - tiny initramfs written in POSIX shell

# SYNOPSIS

*tinyramfs* [option]...

# DESCRIPTION

Tinyramfs is a simple, extensible and modular initramfs generator tool written
with focus on portability.

# OPTIONS

*-o*, *--output* <file>

	Specify output location where initramfs image will be stored.

*-c*, *--config* <file>

	Specify config location. Default is */etc/tinyramfs/config*.

*-k*, *--kernel* <version>

	Specify kernel version. Useful for bootstraping future system with modular
	kernel. Default is current kernel version.

*-m*, *--modules* <directory>

	Specify directory where modules stored. Default is */lib/modules*.
	This option has no effect if *monolith* or *hostonly* were enabled in config.

*-H*, *--hooks* <directory>

	Specify additional hooks location. Default is */usr/share/tinyramfs/hooks*
	and */etc/tinyramfs/hooks*.
	
*-D*, *--helper* <file>

	Specify location to device helper. Default is */usr/share/tinyramfs/device-helper*.

*-I*, *--init* <file>

	Specify location to init script. Default is */usr/share/tinyramfs/init*.

*-d*, *--debug*

	Enable debug mode. Useful for reporting bugs in build stage.

*-f*, *--force*

	Forcefully overwrite initramfs image.

# NOTES

If you have modular kernel and you use *busybox modrobe* to handle modules, you
must note that *busybox modprobe* doesn't have ability to install soft
dependencies of modules (i.e modules.softdep). You must install them yourself
using hooks. See *tinyramfs.hooks*(7) how to do it.

# SEE ALSO

*tinyramfs.config*(5) *tinyramfs.cmdline*(7) *tinyramfs.hooks*(7)
