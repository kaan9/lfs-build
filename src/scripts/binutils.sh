#!/bin/sh

# MAKEFLAGS='-j13 -pipe'

export CC='musl-gcc -static'
export LDFLAGS='-static --static'

../configure				\
	--target=$LFS_TGT		\
	--prefix=/tools			\
	--with-sysroot=$LFS		\
	--with-lib-path=/tools/lib	\
	--disable-nls			\
	--disable-multilib		\
	--disable-werror		\
	--enable-static			\
	--disable-shared

make configure-host
make LDFLAGS='-all-static'
