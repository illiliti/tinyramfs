tinyramfs.hooks(7)

# NAME

Tinyramfs - hooks and related stuff

# DESCRIPTION

Hooks can be located in */usr/share/tinyramfs/hooks* (system path) and
*/etc/tinyramfs/hooks* (user path). Tinyramfs also allows you to specify custom
location via *-H* option. See *tinyramfs*(8) for more information.

Hooks provides a way to extend build and init process. Hooks must be written in
POSIX shell. Bashisms and other non-portable extensions are forbidden. In order
to write hooks you must know about hook structure.

- <hook> - directory of hook scripts
	- <hook>           - invoked in build process.
	- <hook>.init      - invoked in init process.
	- <hook>.init.late - invoked after root filesystem was mounted.

## MAN PAGE SYNTAX

```
- B: extension can be used in build process
- I: extension can be used in init process
- BI: extension can be used in both processes
```

# EXTENSIONS

Tinyramfs also provides some extensions and environment variables to easily
interact with build and init system.

## BI: print <message>

	Print message to stdout.

## BI: panic [message]

	If message was not specified, then tinyramfs will print default error
	message. otherwise message will be printed.

## B: copy_module <full path>

	Copy kernel module by path to tinyramfs working directory.

## B: copy_binary <name or full path>

	If full path was specified and it's has executable bit, then it's will
	be copied to /bin location of tinyramfs working directory.
	
	If name was specified, then tinyramfs will try to find command by name
	in PATH. If it's success, command will be copied to /bin location of
	tinyramfs working directory. Otherwise error message will appear.

## B: copy_file <file> <destination> <mode> <strip>

	<file> must be full path to file.

	<destination> must be full path where <file> should be stored. Tinyramfs
	will automatically create all leading directories if they aren't exist
	already. Also no need to prepend path of tinyramfs working directory.

	<mode> permissions in octal format.

	<strip> if was set to 1, then tinyramfs will attempt to run strip
	on file. Tinyramfs will silently ignore errors if strip doesn't
	exists or failed to strip binary.

## I: resolve_device <UUID|LABEL|/dev/\*|PARTUUID>

	Sets *device* variable to full path of resolved UUID|LABEL|/dev/\*|PARTUUID

# VARIABLES

```
- BI: debug - 1 if debug mode enabled
- I: break  - breakpoint for debugging
- B: tmpdir - full path of tinyramfs working directory (initramfs rootfs in future)
- B: kernel - kernel version
- B: moddir - modules directory
- B: init   - path to init script
- B: helper - path to device-helper script
- B: config - config location
- B: output - output path
- BI: see tinyramfs.config(5)
```

# EXAMPLES

This example will show how to handle soft dependencies of ext4 module.
Create */etc/tinyramfs/hooks/ext4* directory and copy below scripts with
appropriate names to that directory. After that, prepend *ext4* to *hooks*
option in tinyrams config.

## ext4

```
print "Copying ext4 dependencies"

for _mod in crc32c libcrc32c; do
    copy_module "$_mod"
done
```

## ext4.init

```
modprobe -a crc32c libcrc32c
```

# SEE ALSO

*tinyramfs*(8) *tinyramfs.config*(5) *tinyramfs.cmdline*(7) *tinyramfs.hooks*(7)
