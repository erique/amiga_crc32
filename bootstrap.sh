#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

set -xe

git clone --depth 1 https://github.com/erique/vbcc_vasm_vlink.git /tmp/vbcc
cd /tmp/vbcc

./test.sh

wget http://aminet.net/dev/misc/NDK3.2.lha
7z x NDK3.2.lha -obuild/ndk32

cp -r build $SCRIPT_DIR/tools

cd $SCRIPT_DIR
rm -rf /tmp/vbcc
