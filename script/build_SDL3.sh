#!/bin/bash

sudo apt update
sudo apt install cmake
sudo apt install libwayland-dev libdrm-dev libegl1-mesa-dev libgbm-dev libpipewire-0.3-dev libxkbcommon-dev libpulse-dev

git clone https://github.com/libsdl-org/SDL SDL3
cd SDL3
cmake -S . -B build \
	-DSDL_STATIC=ON \
	-DSDL_WAYLAND_LIBDECOR=OFF \
	-DSDL_WAYLAND_LIBDECOR_SHARED=OFF \
	-DSDL_PIPEWIRE=ON \
	-DSDL_PIPEWIRE_SHARED=ON \
	-DSDL_ALSA=OFF \
	-DSDL_ALSA_SHARED=OFF \
	-DCMAKE_INSTALL_PREFIX=$HOME/usr
cmake --build build -- -j8
cmake --install build
