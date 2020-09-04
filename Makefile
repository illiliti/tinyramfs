.POSIX:

PREFIX     = /usr
BINDIR     = ${PREFIX}/bin
DATADIR    = ${PREFIX}/share
MANDIR     = ${PREFIX}/share/man

install:
	mkdir -p ${DESTDIR}${DATADIR}/tinyramfs \
		     ${DESTDIR}${MANDIR}/man5 \
		     ${DESTDIR}${MANDIR}/man8 \
		     ${DESTDIR}${BINDIR}
	cp -R hooks      ${DESTDIR}${DATADIR}/tinyramfs
	cp device-helper ${DESTDIR}${DATADIR}/tinyramfs
	cp init          ${DESTDIR}${DATADIR}/tinyramfs
	cp tinyramfs     ${DESTDIR}${BINDIR}/tinyramfs
	cp docs/tinyramfs.8 ${DESTDIR}${MANDIR}/man8
	cp docs/tinyramfs.config.5 ${DESTDIR}${MANDIR}/man5

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/tinyramfs
	rm -rf ${DESTDIR}${DATADIR}/tinyramfs
	rm -f  ${DESTDIR}${MANDIR}/man8/tinyramfs.8
	rm -f  ${DESTDIR}${MANDIR}/man5/tinyramfs.config.5
