#!/bin/bash
set -e

# === Configuration ===
BUILD_DIR="$HOME/build-xarchiver"
REPO="https://github.com/leonkasovan/xarchiver.git"

# === Prepare build directory ===
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# === Clone and build pcmanfm ===
rm -rf xarchiver
git clone "$REPO"
cd xarchiver

./autogen.sh
./configure --disable-nls --disable-doc
make -j$(nproc)
sudo mv /usr/bin/xarchiver /usr/bin/xarchiver_old
sudo make install
cd ..

echo "✅ Build and installation xarchiver complete!"
