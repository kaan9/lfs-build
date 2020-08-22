#!/bin/sh

# MAKEFLAGS='-j13 -pipe'

export CC='musl-gcc -static'
export LDFLAGS='-static --static'

for file in gcc/config/{linux,i386/linux{,64}}.h
do
	cp -uv $file{,.orig}
	sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' -e 's@/usr@/tools@g' $file.orig > $file
       	echo '
	#undef STANDARD_STARTFILE_PREFIX_1
	#undef STANDARD_STARTFILE_PREFIX_2
	#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
	#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
	touch $file.orig
done

case $(uname -m) in x86_64) sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64 ; ;; esac

../configure					\
	--target=$LFS_TGT			\
	--prefix=/tools				\
	--with-glibc-verison=2.11		\
	--with-sysroot=$LFS			\
	--with-newlib				\
	--without-headers			\
	--with-local-prefix=/tools		\
	--with-native-system-header-dir=/tools/include \
	--with-lib-path=/tools/lib		\
	--disable-multilib			\
	--disable-decimal-float			\
	--disable-threads			\
	--disable-libatomic			\
	--disable-libgomp			\
	--disable-libquadmath			\
	--disable-libssp			\
	--disable-libstdcxx			\
	--disable-libvtv			\
	--disable-libitm			\
	--disable-nls				\
	--enable-static				\
	--disable-shared			\
	--enable-languages=c,c++

#make configure-host
#make LDFLAGS='-all-static'
