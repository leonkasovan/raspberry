#!/bin/bash

sudo rm /usr/lib/aarch64-linux-gnu/libfm-extra.so.4.2.0
sudo rm /usr/lib/aarch64-linux-gnu/libfm-gtk3.so.4.2.0
sudo rm /usr/lib/aarch64-linux-gnu/libfm.so.4.2.0
sudo ldconfig
cd /usr/bin
sudo mv pcmanfm_old pcmanfm
reboot
