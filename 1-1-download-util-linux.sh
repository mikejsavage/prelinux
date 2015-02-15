#! /bin/bash

set -e

version=2.25.2
dir=util-linux-$version
archive=$dir.tar.gz

curl https://kernel.org/pub/linux/utils/util-linux/v${version%.*}/$archive -o $archive
tar xf $archive
mv $dir util-linux
