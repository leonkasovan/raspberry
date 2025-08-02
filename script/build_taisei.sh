#!/bin/bash
sudo apt meson install libfluidsynth-dev fluidsynth libgme-dev libxmp-dev

meson setup --wipe build/ -Dbuild.pkg_config_path=$HOME/usr/lib/pkgconfig -Dr_default=gles30 -Ddeveloper=true \
	-Dr_gles30=enabled -Dr_gl33=disabled  -Dshader_transpiler=enabled -Dinstall_relocatable=enabled \
	-Dtests=disabled

# prepare (compressed) game data
python3 -m venv venv # Create the virtual environment
source venv/bin/activate # Activate it
pip install zstandard # Now install zstandard

meson compile -C build/
meson install -C build/
