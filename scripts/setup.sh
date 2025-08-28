#!/bin/sh

echo "Starting Natural Selection server setup..."

# Install required packages
apk add --no-cache unzip wget

# Install Natural Selection
echo "Installing Natural Selection v3.3b9..."
mkdir -p /temp/mods
wget -q https://github.com/ENSL/NS/releases/download/v3.3b9/ns_v33b9_full.zip -O /tmp/ns.zip
unzip -oq /tmp/ns.zip -d /temp/mods
echo "✓ Natural Selection installed"

# Install Metamod
echo "Installing Metamod-R..."
mkdir -p /temp/mods/ns/addons/metamod/dlls
wget -q https://github.com/rehlds/Metamod-R/releases/download/1.3.0.149/metamod-bin-1.3.0.149.zip -O /tmp/metamod.zip
unzip -oq /tmp/metamod.zip -d /tmp/metamod
find /tmp/metamod -name "*metamod*.so" -exec cp {} /temp/mods/ns/addons/metamod/dlls/metamod_i386.so \;
echo "✓ Metamod installed"

# Create empty plugins.ini
mkdir -p /temp/mods/ns/addons/metamod
echo "# Metamod plugins - add plugins here" > /temp/mods/ns/addons/metamod/plugins.ini

# Fix permissions
chmod -R 755 /temp/mods/ns

echo "🎉 Setup complete! Server is ready to start."
