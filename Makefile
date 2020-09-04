.POSIX:

PREFIX     = /usr
SYSCONFDIR = /etc
BINDIR     = ${PREFIX}/bin
DATADIR    = ${PREFIX}/share
MANDIR     = ${PREFIX}/share/man

install:
	mkdir -p ${DESTDIR}${SYSCONFDIR}/tinyramfs \
		     ${DESTDIR}${DATADIR}/tinyramfs \
		     ${DESTDIR}${MANDIR}/man5 \
		     ${DESTDIR}${BINDIR}
	cp config        ${DESTDIR}${SYSCONFDIR}/tinyramfs
	cp -R hooks      ${DESTDIR}${DATADIR}/tinyramfs
	cp device-helper ${DESTDIR}${DATADIR}/tinyramfs
	cp init          ${DESTDIR}${DATADIR}/tinyramfs
	cp tinyramfs     ${DESTDIR}${BINDIR}/tinyramfs
	cp docs/tinyramfs.5 ${DESTDIR}${MANDIR}/man5

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/tinyramfs
	rm -rf ${DESTDIR}${DATADIR}/tinyramfs
