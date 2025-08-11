#!/bin/bash

mkdir -p ~/Projects
cd ~/Projects
git clone https://github.com/geany/geany.git
cd geany
git submodule update --init --recursive
./autogen.sh
./configure --prefix=/home/deck/usr --enable-binreloc
make -j$(nproc)
sudo mv /usr/bin/geany /usr/bin/geany_old
sudo make install
cd ..
