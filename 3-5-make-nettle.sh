#! /bin/bash

set -e

cd nettle
./configure -C \
	--prefix= \
	--disable-shared \
	--disable-documentation \
	CC=musl-gcc
make
make install DESTDIR="$PWD"/../deps

cd ..
