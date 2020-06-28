PREFIX     = /usr
SYSCONFDIR = /etc
BINDIR     = ${PREFIX}/bin
DATADIR    = ${PREFIX}/share

install:
	mkdir -p \
		${DESTDIR}${DATADIR}/tinyramfs/hooks \
		${DESTDIR}${SYSCONFDIR}/tinyramfs \
		${DESTDIR}${BINDIR}
	cp -R hooks/*         ${DESTDIR}${DATADIR}/tinyramfs/hooks/
	cp init device-helper ${DESTDIR}${DATADIR}/tinyramfs
	chmod -R 644     	  ${DESTDIR}${DATADIR}/tinyramfs
	cp config 		 	  ${DESTDIR}${SYSCONFDIR}/tinyramfs
	chmod 600 		 	  ${DESTDIR}${SYSCONFDIR}/tinyramfs/config
	cp tinyramfs 	 	  ${DESTDIR}${BINDIR}/tinyramfs
	chmod 755    	 	  ${DESTDIR}${BINDIR}/tinyramfs

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/tinyramfs
	rm -rf ${DESTDIR}${DATADIR}/tinyramfs
