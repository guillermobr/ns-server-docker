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

# Mods installation disabled for now
echo "✓ Skipping Metamod and AMX Mod X installation (disabled)"

echo "🎉 Setup complete! Server is ready to start."
