#! /bin/bash

set -e

[[ -d ports ]] || ./2-1-clone-ports.sh
[[ -d sbase ]] || ./2-2-clone-sbase.sh
[[ -d ubase ]] || ./2-3-clone-ubase.sh
[[ -d smdev ]] || ./2-4-clone-smdev.sh
