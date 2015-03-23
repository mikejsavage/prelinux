#! /bin/bash

set -e

version=3.0
dir=nettle-$version
archive=$dir.tar.gz

curl https://ftp.gnu.org/gnu/nettle/$archive -o $archive
tar xf $archive
mv $dir nettle
