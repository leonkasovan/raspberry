#!/bin/bash
# Build SDL2 Library for RG40XX with (Anbernic) Stock OS using fbdev video backend

mkdir -p $HOME/usr
git clone https://github.com/od-contrib/SDL2-fbdev.git
cd SDL2-fbdev

./autogen.sh
./configure --prefix=$HOME/usr --enable-video-fbdev --enable-video-opengles --enable-arm-simd --enable-arm-neon \
--disable-oss --disable-jack --disable-pulseaudio --disable-sndio --disable-diskaudio --disable-dummyaudio \
--disable-video-wayland --disable-video-x11 --disable-video-dummy --disable-video-opengl --disable-video-vulkan
make -j8
make install

echo "Adding \"$HOME/usr/lib/pkgconfig\" to PKG_CONFIG_PATH ... [done]"
LINE='export PKG_CONFIG_PATH=$HOME/usr/lib/pkgconfig:$PKG_CONFIG_PATH'
FILE="$HOME/.profile"
# Check if the line is already present
grep -qxF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
echo "Usage:"
echo "  pkg-config sdl2 --libs --cflags"

