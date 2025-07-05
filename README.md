# Raspberry Pi 5

Firmware update
```
sudo apt update
sudo apt full-upgrade
sudo reboot

sudo rpi-eeprom-config -e
Add the configuration SDRAM_BANKLOW=1
```

For booting from USB SSD NVME using any OS, edit config.txt
```
# will force the Pi5 to allow full current to USB devices and disable the confimr boot from USB prompt
usb_max_current_enable=1

# Skip check for The installed operating system (OS) does not indicate support for Raspberry Pi 5
os_check=0
```

# Recommended OS
1. Raspberry Pi OS
2. Ubuntu 22.0
3. KDE Plasma
4. Batocera
5. Recalbox
