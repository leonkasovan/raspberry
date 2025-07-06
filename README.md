# Raspberry Pi 5

Firmware update
```
sudo apt update
sudo apt full-upgrade
sudo rpi-eeprom-update
sudo reboot

sudo rpi-eeprom-config -e
Add the configuration SDRAM_BANKLOW=1
```

Overclock (Conservative)
```
sudo nano /boot/firmware/config.txt
[pi5]
arm_freq=2700         # CPU clock in MHz (e.g., 3000 = 3.0GHz)
gpu_freq=600          # GPU frequency
over_voltage=3        # +60mV (range: 0–15 for safety)
```

Overclock (Moderate)
```
sudo nano /boot/firmware/config.txt
[pi5]
arm_freq=3000         # CPU clock in MHz (e.g., 3000 = 3.0GHz)
gpu_freq=750          # GPU frequency
over_voltage=6        # +60mV (range: 0–15 for safety)
```

Monitor
```
watch -n 1 '
echo "CPU:   $(vcgencmd measure_clock arm)"
echo "GPU:   $(vcgencmd measure_clock v3d)"
echo "TEMP:  $(vcgencmd measure_temp)"
echo "THTLD: $(vcgencmd get_throttled)"
'
```

For booting from USB SSD NVME using any OS, edit config.txt
```
usb_max_current_enable=1 # will force the Pi5 to allow full current to USB devices and disable the confimr boot from USB prompt
os_check=0 # Skip check for The installed operating system (OS) does not indicate support for Raspberry Pi 5
arm_boost=1           # Enable turbo mode (auto-boost when needed)
```

Manual install Desktop Env (XFCE4)
```
sudo apt install xfce4 lightdm chromium

sudo nano /etc/lightdm/lightdm.conf
[Seat:*]
autologin-user=pi         # Replace with your actual username
autologin-session=xfce    # Match your session name

sudo raspi-config
System Options -> Boot -> Desktop GUI
System Options -> Auto Login -> 
```

# Recommended OS
1. Raspberry Pi OS
2. Batocera
3. Recalbox
