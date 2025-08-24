#!/bin/bash
set -e

CHROOT_DIR=~/focal
HOST_UID=$(id -u)
HOST_GID=$(id -g)
HOST_USER=$(id -un)
HOST_HOME=$(eval echo ~$HOST_USER)

mount_chroot() {
    echo "[*] Mounting system directories..."

    # Bind /dev and /dev/pts from host
    sudo mount --bind /dev $CHROOT_DIR/dev
    sudo mkdir -p $CHROOT_DIR/dev/pts
    sudo mount --bind /dev/pts $CHROOT_DIR/dev/pts

    # Ensure /dev/ptmx exists
    if [ ! -e $CHROOT_DIR/dev/ptmx ]; then
        sudo mknod -m 666 $CHROOT_DIR/dev/ptmx c 5 2
    fi

    # Mount /proc and /sys
    sudo mount --bind /proc $CHROOT_DIR/proc
    sudo mount --bind /sys  $CHROOT_DIR/sys

    # Copy DNS config
    sudo cp /etc/resolv.conf $CHROOT_DIR/etc/resolv.conf
}

umount_chroot() {
    echo "[*] Unmounting system directories..."
    sudo umount -l $CHROOT_DIR/sys  || true
    sudo umount -l $CHROOT_DIR/proc || true
    sudo umount -l $CHROOT_DIR/dev/pts || true
    sudo umount -l $CHROOT_DIR/dev     || true
}

trap umount_chroot EXIT

mount_chroot

# 1️⃣ Create matching group and user inside chroot
sudo chroot $CHROOT_DIR /bin/bash -c "
getent group $HOST_GID || groupadd -g $HOST_GID $HOST_USER
id -u $HOST_USER &>/dev/null || useradd -m -u $HOST_UID -g $HOST_GID -s /bin/bash $HOST_USER
"

# 2️⃣ Copy Xauthority for XWayland
export DISPLAY=${DISPLAY:-:0}
export XAUTHORITY=${XAUTHORITY:-$HOME/.Xauthority}

if [ -f "$XAUTHORITY" ]; then
    sudo mkdir -p $CHROOT_DIR/home/$HOST_USER
    sudo cp "$XAUTHORITY" $CHROOT_DIR/home/$HOST_USER/.Xauthority
    sudo chown $HOST_UID:$HOST_GID $CHROOT_DIR/home/$HOST_USER/.Xauthority
fi

# 3️⃣ Enter chroot as same user
echo "[*] Entering Ubuntu 20.04 chroot as user $HOST_USER. Type 'exit' to leave."
sudo chroot --userspec=$HOST_UID:$HOST_GID $CHROOT_DIR /bin/bash -c "
export HOME=/home/$HOST_USER
export DISPLAY=$DISPLAY
export XAUTHORITY=/home/$HOST_USER/.Xauthority
cd \$HOME
exec bash --login
"
