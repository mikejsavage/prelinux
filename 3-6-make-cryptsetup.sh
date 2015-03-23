#! /bin/bash

set -e

cd cryptsetup
./configure -C \
	--prefix= \
	--enable-static-cryptsetup \
	--disable-shared \
	--disable-nls \
	--with-crypto-backend=nettle \
	CC=musl-gcc \
	CFLAGS="-I$PWD/../deps/include -L$PWD/../deps/lib" # for some reason we need this
	LDFLAGS="-L$PWD/../deps/lib"

# `make` will once again build all the objects with musl-gcc then
# attempt to link them with the globally installed libs
# so let's do it by hand

cd lib
make
cd ..
cd src
make cryptsetup.static
cd ..
cd ..

strip cryptsetup/src/cryptsetup.static
