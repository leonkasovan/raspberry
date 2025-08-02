#!/bin/bash

wget --content-disposition "https://code.visualstudio.com/sha/download?build=stable&os=linux-arm64"
mkdir -p $HOME/Apps

# extract code-stable-arm64-1752099789.tar.gz to $HOME/Apps
tar -xzf code-stable-arm64-*.tar.gz -C $HOME/Apps

# remove code-stable-arm64-1752099789.tar.gz
rm code-stable-arm64-*.tar.gz

# create a symlink to the code executable in /usr/local/bin
if [ ! -f "/usr/local/bin/code" ]; then
    sudo ln -s $HOME/Apps/VSCode-linux-arm64/bin/code /usr/local/bin
fi

# create a desktop entry for VSCode (if needed)
if [ ! -f "/usr/share/applications/code.desktop" ]; then
cat << EOF | sudo tee /usr/share/applications/code.desktop
[Desktop Entry]
Name=Visual Studio Code
Type=Application
Exec=/usr/local/bin/code
Icon=$HOME/Apps/VSCode-linux-arm64/resources/app/resources/linux/code.png
Categories=Development;IDE;
Terminal=false
EOF
fi