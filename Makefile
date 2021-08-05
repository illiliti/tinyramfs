.POSIX:

PREFIX = /usr/local
BINDIR = ${PREFIX}/bin
LIBDIR = ${PREFIX}/lib

install:
	mkdir -p ${DESTDIR}${BINDIR}
	mkdir -p ${DESTDIR}${LIBDIR}/tinyramfs
	cp -f tinyramfs     ${DESTDIR}${BINDIR}/
	cp -f lib/init.sh   ${DESTDIR}${LIBDIR}/tinyramfs/
	cp -f lib/helper.sh ${DESTDIR}${LIBDIR}/tinyramfs/
	cp -f lib/common.sh ${DESTDIR}${LIBDIR}/tinyramfs/
	cp -R hook          ${DESTDIR}${LIBDIR}/tinyramfs/hook.d

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/tinyramfs
	rm -rf ${DESTDIR}${LIBDIR}/tinyramfs

check:
	(cd test && ${MAKE})

.PHONY: install uninstall check
