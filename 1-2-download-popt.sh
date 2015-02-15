#! /bin/bash

set -e

version=1.16
dir=popt-$version
archive=$dir.tar.gz

curl http://rpm5.org/files/popt/$archive -o $archive
tar xf $archive
mv $dir popt
