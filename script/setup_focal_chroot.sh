#!/bin/bash
set -e

CHROOT_DIR=~/focal
ROOTFS_URL="https://partner-images.canonical.com/core/focal/current/ubuntu-focal-core-cloudimg-arm64-root.tar.gz"
ROOTFS_TAR="ubuntu-focal-rootfs.tar.gz"

# 1️⃣ Download rootfs if not exists
mkdir -p $CHROOT_DIR
if [ ! -f $ROOTFS_TAR ]; then
    echo "[*] Downloading Ubuntu 20.04 ARM64 rootfs..."
    wget -O $ROOTFS_TAR $ROOTFS_URL
fi

# 2️⃣ Extract rootfs
echo "[*] Extracting rootfs into $CHROOT_DIR ..."
sudo tar -xpf $ROOTFS_TAR -C $CHROOT_DIR

# 3️⃣ Mount required system directories for chroot
echo "[*] Mounting system directories..."
sudo mount --bind /dev  $CHROOT_DIR/dev
sudo mount --bind /dev/pts $CHROOT_DIR/dev/pts
sudo mount --bind /proc $CHROOT_DIR/proc
sudo mount --bind /sys  $CHROOT_DIR/sys
sudo cp /etc/resolv.conf $CHROOT_DIR/etc/resolv.conf

# 4️⃣ Create a temporary script inside chroot to run installs
CHROOT_SETUP_SCRIPT="$CHROOT_DIR/setup_inside_chroot.sh"
cat <<'EOF' | sudo tee $CHROOT_SETUP_SCRIPT
#!/bin/bash
set -e
export LANG=C.UTF-8

echo "[*] Updating apt sources..."
apt update

echo "[*] Installing apt-utils to avoid debconf warnings..."
DEBIAN_FRONTEND=noninteractive apt install -y apt-utils

echo "[*] Installing core utilities..."
DEBIAN_FRONTEND=noninteractive apt install -y dialog locales sudo wget gnupg software-properties-common

echo "[*] Generating locale..."
locale-gen en_US.UTF-8

echo "[*] Installing build tools + GUI libraries..."
DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential git cmake pkg-config \
    x11-apps xauth x11-utils \
    mesa-utils libgl1-mesa-dri libgl1-mesa-glx

echo "[*] Cleanup..."
apt clean
rm -f /setup_inside_chroot.sh

echo "[*] Chroot setup complete. You can now run GUI apps."
EOF

# 5️⃣ Make script executable
sudo chmod +x $CHROOT_SETUP_SCRIPT

# 6️⃣ Run the script inside chroot
echo "[*] Running setup inside chroot..."
sudo chroot $CHROOT_DIR /bin/bash -c "/setup_inside_chroot.sh"

# 7️⃣ Inform user
echo "[*] Ubuntu 20.04 chroot setup complete!"
echo "Use the enter_focal_chroot.sh script to enter the environment safely."
