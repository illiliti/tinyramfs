tinyramfs(8)

# NAME

Tinyramfs - tiny initramfs written in POSIX shell

# SYNOPSIS

*tinyramfs* [option ...]

# DESCRIPTION

Tinyramfs is a simple, extensible and modular initramfs generator tool written
with focus on portability.

# OPTIONS

*-m*, *--modules* <directory>

	Specify directory where modules stored. Default is */lib/modules*.
	
*-s*, *--sources* <directory>
	
	Specify directory where tinyramfs stored files such as *device-helper*
	and *init*. Default is */usr/share/tinyramfs*.

*-o*, *--output* <output>

	Specify output location where initramfs image will be stored.

*-c*, *--config* <config>

	Specify config location. Default is */etc/tinyramfs/config*.

*-k*, *--kernel* <version>

	Specify kernel version. Useful for bootstraping future system with modular
	kernel. Default is current kernel version.

*-H*, *--hooks* <directory>

	Specify additional hooks location. Default is */usr/share/tinyramfs/hooks*
	and */etc/tinyramfs/hooks*.
	
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
