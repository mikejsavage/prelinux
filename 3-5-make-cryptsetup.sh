#! /bin/bash

set -e

cd cryptsetup
./configure -C \
	--prefix= \
	--enable-static-cryptsetup \
	--disable-shared \
	--disable-nls \
	--with-crypto-backend=kernel \
	CC=musl-gcc \
	CFLAGS="-I$PWD/../deps/include -L$PWD/../deps/lib" # lol linux developers
	LDFLAGS="-L$PWD/../deps/lib"

# `make` will once again build all the objects with musl-gcc then
# attempt to link them with the globally installed libs
# so we have to fix their goddamn fucking shit yet again

cd lib
make
cd ..
cd src
make cryptsetup.static
cd ..
cd ..

strip cryptsetup/src/cryptsetup.static
