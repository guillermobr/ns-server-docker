#!/bin/sh

echo "Starting Natural Selection server setup..."

# Install required packages
apk add --no-cache unzip wget

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

# Install Metamod
if [ ! -f /temp/mods/ns/addons/metamod/dlls/metamod_i386.so ]; then
  echo "Installing Metamod-R..."
  mkdir -p /temp/mods/ns/addons/metamod/dlls
  wget -q https://github.com/rehlds/Metamod-R/releases/download/1.3.0.149/metamod-bin-1.3.0.149.zip -O /tmp/metamod.zip
  unzip -oq /tmp/metamod.zip -d /tmp/metamod
  cp /tmp/metamod/metamod_i386.so /temp/mods/ns/addons/metamod/dlls/
  rm -rf /tmp/metamod.zip /tmp/metamod

  # Create liblist.gam with metamod
  sed -i 's/gamedll_linux "dlls\/ns.so"/gamedll_linux "addons\/metamod\/dlls\/metamod_i386.so"/' /temp/mods/ns/liblist.gam

  # Create plugins.ini
  mkdir -p /temp/mods/ns/addons/metamod
  echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" > /temp/mods/ns/addons/metamod/plugins.ini
  echo "✓ Metamod installed"
else
  echo "✓ Metamod already installed, skipping..."
fi

# Install AMX Mod X
if [ ! -f /temp/mods/ns/addons/amxmodx/dlls/amxmodx_mm_i386.so ]; then
  echo "Installing AMX Mod X..."
  mkdir -p /temp/mods/ns/addons/amxmodx

  # Download base package
  wget -q https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-base-linux.tar.gz -O /tmp/amxx-base.tar.gz
  tar -xzf /tmp/amxx-base.tar.gz -C /temp/mods/ns/addons/amxmodx --strip-components=1

  # Download Half-Life addon
  wget -q https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-hlsdk-linux.tar.gz -O /tmp/amxx-hl.tar.gz
  tar -xzf /tmp/amxx-hl.tar.gz -C /temp/mods/ns/addons/amxmodx --strip-components=1

  rm /tmp/amxx-base.tar.gz /tmp/amxx-hl.tar.gz

  # Set permissions
  chmod +x /temp/mods/ns/addons/amxmodx/dlls/amxmodx_mm_i386.so
  echo "✓ AMX Mod X installed"
else
  echo "✓ AMX Mod X already installed, skipping..."
fiecho "🎉 Setup complete! Server is ready to start."
