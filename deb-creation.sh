#!/bin/bash

if [ ! -d tabula ]; then
	wget https://github.com/tabulapdf/tabula/releases/download/v1.2.1/tabula-jar-1.2.1.zip
	unzip tabula-jar-1.2.1.zip

	mkdir tabula/icons
	wget https://github.com/tabulapdf/tabula/raw/master/build/icons/tabula.png -P tabula/icons
fi

if [ -d tabula ]; then
	echo "Packaging Tabula"
	rm -rf deb-package
	rm tabula.deb
	mkdir deb-package
	mkdir -p deb-package/opt/tabula
	rsync -av --progress tabula/* deb-package/opt/tabula/ --exclude-from=deb-exclude
	rsync -av --progress DEBIAN/ deb-package/DEBIAN/
	chmod -R 0755 deb-package
	dpkg-deb --build deb-package
	mv deb-package.deb tabula.deb
fi
