#!/bin/bash

mkdir -p $HOME/usr

git clone https://github.com/libsdl-org/SDL_mixer.git SDL3_mixer
cd SDL3_mixer
cmake -S . -B build \
	-DCMAKE_BUILD_TYPE=Release \
	-DSDL_STATIC=ON \
	-DSDL_CPU_ARM64=ON \
	-DCMAKE_INSTALL_PREFIX=$HOME/usr
cmake --build build -- -j8
cmake --install build

echo "Adding \"$HOME/usr/lib/pkgconfig\" to PKG_CONFIG_PATH ... [done]"
LINE='export PKG_CONFIG_PATH=$HOME/usr/lib/pkgconfig:$PKG_CONFIG_PATH'
FILE="$HOME/.profile"
# Check if the line is already present
grep -qxF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
echo "Usage:"
echo "  pkg-config sdl3-mixer --libs --cflags"
