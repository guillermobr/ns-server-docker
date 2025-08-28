#!/bin/sh

echo "Starting Natural Selection server setup..."

# Install required packages
apk add --no-cache unzip wget

# Install Natural Selection
# Check if already unpacked in cache
if [ -d "/temp/cache/ns_unpacked/ns" ] && [ -n "$(find /temp/cache/ns_unpacked/ns -maxdepth 1 -type f 2>/dev/null)" ]; then
    echo "✓ Natural Selection already unpacked in cache, copying to target..."
    mkdir -p /temp/mods
    cp -r /temp/cache/ns_unpacked/* /temp/mods/
else
    echo "Installing Natural Selection v3.3b9..."
    # Download if not already downloaded
    if [ ! -f "/temp/cache/ns.zip" ]; then
        mkdir -p /temp/cache
        wget -q https://github.com/ENSL/NS/releases/download/v3.3b9/ns_v33b9_full.zip -O /temp/cache/ns.zip
    fi
    # Unpack to cache location first
    mkdir -p /temp/cache/ns_unpacked
    unzip -oq /temp/cache/ns.zip -d /temp/cache/ns_unpacked
    # Copy to target location
    mkdir -p /temp/mods
    cp -r /temp/cache/ns_unpacked/* /temp/mods/
    echo "✓ Natural Selection installed"
fi

chmod -R 755 /temp/mods/ns

# Copy mods folder if it exists
if [ -d "/mods" ] && [ -n "$(find /mods -maxdepth 1 -type f -o -type d 2>/dev/null | head -1)" ]; then
    echo "Copying mods folder to /temp/mods..."
    cp -r /mods/* /temp/mods/
    echo "✓ Mods folder copied"
fi

# Configure liblist.gam to use Metamod
if [ -f "/temp/mods/ns/liblist.gam" ]; then
    sed -i 's|gamedll_linux "addonsmetamoddllsmetamod.dll"|gamedll_linux "addons\metamod\dlls\metamod.dll"|g' /temp/mods/ns/liblist.gam
    sed -i 's|gamedll "dlls\ns.dll"|gamedll "addons\metamod\dlls\metamod.dll"|g' /temp/mods/ns/liblist.gam
    echo "✓ liblist.gam configured to use Metamod"
else
    echo "⚠ Warning: liblist.gam not found"
fi

echo "🎉 Setup complete! Server is ready to start."
