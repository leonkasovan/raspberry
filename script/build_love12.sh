#!/bin/bash

sudo apt install libfreetype6-dev libharfbuzz-dev libopenal-dev libmodplug-dev libtheora-dev libvorbis-dev libogg-dev zlib1g-dev libluajit-5.1-dev
git clone https://github.com/love2d/love.git love12
cd love12
cmake -B build -S. -DCMAKE_PREFIX_PATH=$HOME/usr --install-prefix=$HOME/usr
cmake --build build -- -j8
cmake --install build
