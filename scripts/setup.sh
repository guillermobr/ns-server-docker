#!/bin/sh

echo "Starting Natural Selection server setup..."

# Check if NS is already installed
if [ ! -f /temp/mods/ns/liblist.gam ]; then
  echo "Installing Natural Selection v3.3b9..."
  mkdir -p /temp/mods
  wget -q https://github.com/ENSL/NS/releases/download/v3.3b9/ns_v33b9_full.zip -O /tmp/ns.zip
  unzip -oq /tmp/ns.zip -d /temp/mods
  rm /tmp/ns.zip
  echo "✓ Natural Selection installed"
else
  echo "✓ Natural Selection already installed, skipping..."
fi

echo "🎉 Setup complete! Server is ready to start."

# Check if Metamod is already installed
if [ ! -f /data/ns/addons/metamod/dlls/metamod.so ]; then
  echo "Installing Metamod-R..."
  mkdir -p /data/ns/addons/metamod/dlls
  wget -q https://github.com/rehlds/Metamod-R/releases/download/1.3.0.149/metamod-bin-1.3.0.149.zip -O /tmp/metamod.zip
  unzip -oq /tmp/metamod.zip -d /data/ns/addons/metamod
  rm /tmp/metamod.zip
  echo "✓ Metamod-R installed"
else
  echo "✓ Metamod-R already installed, skipping..."
fi

# Check if AMX Mod X is already installed
if [ ! -f /data/ns/addons/amxmodx/dlls/amxmodx_mm_i386.so ]; then
  echo "Installing AMX Mod X..."
  wget -q https://www.amxmodx.org/release/amxmodx-1.8.2-base-linux.tar.gz -O /tmp/amx.tar.gz
  tar -xf /tmp/amx.tar.gz -C /data/ns
  rm /tmp/amx.tar.gz
  echo "✓ AMX Mod X installed"
else
  echo "✓ AMX Mod X already installed, skipping..."
fi

echo "🎉 Setup complete! Server is ready to start."
