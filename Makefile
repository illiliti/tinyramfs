PREFIX     = /usr
SYSCONFDIR = /etc
BINDIR     = ${PREFIX}/bin
DATADIR    = ${PREFIX}/share

install:
	install -Dm600 config        ${DESTDIR}${SYSCONFDIR}/tinyramfs/config
	install -Dm755 tinyramfs     ${DESTDIR}${BINDIR}/tinyramfs
	install -Dm755 init          ${DESTDIR}${DATADIR}/tinyramfs/init
	install -Dm755 device-helper ${DESTDIR}${DATADIR}/tinyramfs/device-helper

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/tinyramfs
	rm -rf ${DESTDIR}${DATADIR}/tinyramfs
