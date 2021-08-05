.POSIX:

.SUFFIXES:
.SUFFIXES: .test

TEST = bare luks lvm zfs

all: ${TEST}

.test:
	./$< > $@.out 2>&1

clean:
	rm -f *.out

.PHONY: all clean
