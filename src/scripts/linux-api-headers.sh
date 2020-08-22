#!/bin/bash
#  MAKEFLAGS='-j9 -pipe'
make mrproper

make headers
find usr/include \( -name .install -o -name ..install.cmd \) -delete # why is this necessary?

cp -rv usr/include/* /tools/include
rm -v /tools/include/Makefile
