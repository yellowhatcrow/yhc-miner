#!/bin/bash

if [ "$OS" = "Windows_NT" ]; then
    ./mingw64.sh
    exit 0
fi

# Linux build

make clean || echo "clean"

_exec_style="${1}"

if [ -f "bin/pre-install.sh" ];
then
	case $_exec_style in
		-f|-force|--force) ./bin/pre-install.sh --force;;
		*) ./bin/pre-install.sh;;
	esac
else
	printf "\033[35mError:\033[0m\t\033[41mMissing 'pre-install.sh' script!!!\033[0m\n"
fi

rm -f config.status
./autogen.sh || echo done


# Debian 7.7 / Ubuntu 14.04 (gcc 4.7+)
extracflags="$extracflags -Ofast -flto -fuse-linker-plugin -ftree-loop-if-convert-stores"

if [ ! "0" = `cat /proc/cpuinfo | grep -c avx` ]; then
    # march native doesn't always works, ex. some Pentium Gxxx (no avx)
    extracflags="$extracflags -march=native"
fi

./configure --with-crypto --with-curl CFLAGS="-O2 $extracflags -DUSE_ASM -pg"

make -j 4

strip -s yhcminer

