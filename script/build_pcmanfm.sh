#!/bin/bash
set -e

# === Configuration ===
PREFIX="$HOME/.local/pcmanfm-gtk3"
BUILD_DIR="$HOME/build-pcmanfm"
LIBFM_REPO="https://github.com/lxde/libfm.git"
PCMANFM_REPO="https://github.com/lxde/pcmanfm.git"

# === Ensure dependencies are installed ===
echo "Checking for required packages..."
sudo apt update
sudo apt install -y build-essential git automake autoconf libtool \
  intltool gtk-doc-tools valac pkg-config \
  libgtk-3-dev libglib2.0-dev libmenu-cache-dev libexif-dev

# === Prepare build directory ===
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# === Clone and build libfm ===
rm -rf libfm
git clone "$LIBFM_REPO"
cd libfm

./autogen.sh
./configure --prefix="$PREFIX" --with-gtk=3 --disable-nls --sysconfdir="$PREFIX/etc"
make -j$(nproc)
sudo make install
cd ..

# === Clone and build pcmanfm ===
rm -rf pcmanfm
git clone "$PCMANFM_REPO"
cd pcmanfm

./autogen.sh
./configure --prefix="$PREFIX" --with-gtk=3 PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"  --disable-nls --sysconfdir="$PREFIX/etc"
make -j$(nproc)
sudo make install
cd ..

# === Add environment setup to .bashrc if not already present ===
ENV_SETUP="export PATH=\"$PREFIX/bin:\$PATH\"
export LD_LIBRARY_PATH=\"$PREFIX/lib:\$LD_LIBRARY_PATH\"
export XDG_DATA_DIRS=\"$PREFIX/share:\$XDG_DATA_DIRS\""

if ! grep -q "$PREFIX" ~/.bashrc; then
  echo -e "\n# PCManFM GTK3 build environment" >> ~/.bashrc
  echo "$ENV_SETUP" >> ~/.bashrc
  echo "Environment added to ~/.bashrc. Restart your terminal or run:"
  echo "$ENV_SETUP"
else
  echo "Environment variables already present in ~/.bashrc"
fi

echo
echo "✅ Build and installation complete!"
echo "To run PCManFM from your local build, either:"
echo "1. Restart your terminal, or"
echo "2. Temporarily run:"
echo "$ENV_SETUP"
echo
echo "Then run: pcmanfm"
