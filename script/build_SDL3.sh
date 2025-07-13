#!/bin/bash

git clone https://github.com/libsdl-org/SDL SDL3
cd SDL3
cmake -S . -B build \
#	-DSDL_ROCKCHIP=ON \
#	-DSDL_ARMNEON=ON \
	-DSDL_STATIC=ON \
	-DSDL_WAYLAND_LIBDECOR=OFF \
	-DSDL_WAYLAND_LIBDECOR_SHARED=OFF \
	-DSDL_PIPEWIRE=ON \
	-DSDL_PIPEWIRE_SHARED=ON \
	-DSDL_ALSA=OFF \
	-DSDL_ALSA_SHARED=OFF \
	-DSDL_LIBURING=ON \
	-DCMAKE_INSTALL_PREFIX=$HOME/usr
cmake --build build
cmake --install build

git clone https://github.com/love2d/love.git
cmake -B build -S. -DCMAKE_PREFIX_PATH=$HOME/usr --install-prefix=$HOME/usr
cmake --build build
cmake --install build