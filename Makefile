.POSIX:

PREFIX     = /usr
BINDIR     = ${PREFIX}/bin
DATADIR    = ${PREFIX}/share
MANDIR     = ${PREFIX}/share/man

install:
	mkdir -p ${DESTDIR}${DATADIR}/tinyramfs \
		     ${DESTDIR}${MANDIR}/man5 \
		     ${DESTDIR}${BINDIR}
	cp -R hooks      ${DESTDIR}${DATADIR}/tinyramfs
	cp device-helper ${DESTDIR}${DATADIR}/tinyramfs
	cp init          ${DESTDIR}${DATADIR}/tinyramfs
	cp tinyramfs     ${DESTDIR}${BINDIR}/tinyramfs
	cp docs/tinyramfs.5 ${DESTDIR}${MANDIR}/man5

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/tinyramfs
	rm -rf ${DESTDIR}${DATADIR}/tinyramfs
