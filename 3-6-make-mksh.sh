#! /bin/bash

set -e

cd mksh
chmod +x ./Build.sh
CC=musl-gcc LDFLAGS="-s -static" ./Build.sh
cd ..
