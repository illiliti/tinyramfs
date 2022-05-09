tinyramfs(8) "tinyramfs" "2022-05-09"

# NAME
*tinyramfs* - create an initramfs

# SYNOPSIS
*tinyramfs* [*-dfhl*] [*-c* file] [*-k* kern] [*-m* path] <output>

# DESCRIPTION
The tinyramfs utility generates an initramfs image for loading kernel modules, 
unlocking encrypted drives, mounting needed filesystems, etc.

# OPTIONS
*-c* <file>
	Use <file> as configuration, instead of /etc/tinyramfs/config.

*-d*
<<<<<<< HEAD
	Enable debug mode; print every command tinyramfs executes to standard error.
=======
	Enable debug mode; print every command tinyramfs executes to standard 
error.
>>>>>>> 3967410 (doc/*: minor formating changes to man pages)

*-f*
	Overwrite the output file if it already exists.

*-h*
	Show a summary of options accepted by tinyramfs.

*-k* <kern>
<<<<<<< HEAD
	Set the kernel version to <kern>. This way tinyramfs knows which kernel modules to use.
=======
	Set the kernel version to <kern>. This way tinyramfs knows which kernel 
	modules to use.
>>>>>>> 3967410 (doc/*: minor formating changes to man pages)

*-l*
	Use helper scripts in $PWD/lib/, instead of /lib/tinyramfs/.

*-m* <path>
	Look for kernel modules in <path>, instead of /lib/modules/.

# FILES
/lib/tinyramfs/hook.d/
	tinyramfs hooks

# SEE ALSO
*tinyramfs*(8)

# AUTHORS
tinyramfs by illiliti *https://github.com/illiliti* ++
man page by fluorescent_haze *https://github.com/fluorescent-haze*
