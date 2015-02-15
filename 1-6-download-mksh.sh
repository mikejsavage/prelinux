#! /bin/bash

set -e

version=R50d
dir=mksh-$version
archive=$dir.tgz

curl https://www.mirbsd.org/MirOS/dist/mir/mksh/$archive -o $archive
tar xf $archive
