#!/bin/bash

sudo cp /home/dietpi/.local/pcmanfm-gtk3/lib/libfm-extra.so.4.2.0 /usr/lib/aarch64-linux-gnu/
sudo cp /home/dietpi/.local/pcmanfm-gtk3/lib/libfm-gtk3.so.4.2.0 /usr/lib/aarch64-linux-gnu/
sudo cp /home/dietpi/.local/pcmanfm-gtk3/lib/libfm.so.4.2.0 /usr/lib/aarch64-linux-gnu/
sudo ldconfig
cd /usr/bin
sudo mv pcmanfm pcmanfm_old
sudo cp /home/dietpi/.local/pcmanfm-gtk3/bin/pcmanfm .
reboot

#sudo rm /usr/lib/aarch64-linux-gnu/libfm-extra.so.4.2.0
#sudo rm /usr/lib/aarch64-linux-gnu/libfm-gtk3.so.4.2.0
#sudo rm /usr/lib/aarch64-linux-gnu/libfm.so.4.2.0
#sudo ldconfig

