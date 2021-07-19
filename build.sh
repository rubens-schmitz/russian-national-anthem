# fix: usr/bin not found
chmod -x debian/dirs debian/russianlordsprayer.install

# fix: src.pro not found
cp src/russiannationalanthem.pro src/src.pro

# build package
sudo dpkg-buildpackage -rfakeroot

# clean
rm src/src.pro
