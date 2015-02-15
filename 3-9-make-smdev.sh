#! /bin/bash

set -e

make -C smdev/ CC=musl-gcc LDFLAGS="-s -static"
