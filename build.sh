#!/bin/bash

rem="0.4.6"
re="0.4.14"
opus="1.1"
baresip="0.4.15"

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
    my_extra_lflags=""
else
    my_extra_lflags="-framework SystemConfiguration -framework CoreFoundation"
fi

-framework SystemConfiguration -framework CoreFoundation 


rm -Rf baresip-$baresip re rem re-$re rem-$rem opus-$opus

wget -N "http://www.creytiv.com/pub/re-0.4.14.tar.gz"
tar -xzf re-${re}.tar.gz
ln -s re-$re re
cd re; make libre.a; cd ..

wget -N "http://www.creytiv.com/pub/rem-0.4.6.tar.gz"
tar -xzf rem-${rem}.tar.gz
ln -s rem-$rem rem
cd rem; make librem.a; cd ..

wget -N "http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz"
tar -xzf opus-${opus}.tar.gz
cd opus-$opus; ./configure; make; cd ..
mkdir opus; cp opus-$opus/.libs/libopus.a opus/
mkdir -p my_include/opus
cp opus-$opus/include/*.h my_include/opus/ 

wget -N "http://www.creytiv.com/pub/baresip-0.4.15.tar.gz"
tar -xzf baresip-${baresip}.tar.gz
cd baresip-$baresip;

make LIBRE_SO=../re LIBREM_PATH=../rem STATIC=1 \
    MODULES="opus stdio ice menu g711 turn stun uuid auloop contact" \
    EXTRA_CFLAGS="-I ../my_include" EXTRA_LFLAGS="$my_extra_lflags -L ../opus"
cd ..

if [ "$TRAVIS_OS_NAME" == "linux" ]; then
ldd baresip-$baresip/baresip
else
otool -L baresip-$baresip/baresip
fi
baresip-$baresip/baresip -t
