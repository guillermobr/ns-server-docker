#!/bin/sh

echo "Starting Natural Selection server setup..."

# Install required packages
apk add --no-cache unzip wget

# Check if NS is already installed
if [ ! -f /temp/mods/ns/liblist.gam ]; then
  echo "Installing Natural Selection v3.3b9..."
  mkdir -p /temp/mods
  if [ ! -f /tmp/ns.zip ]; then
    echo "Downloading Natural Selection v3.3b9..."
    wget -q https://github.com/ENSL/NS/releases/download/v3.3b9/ns_v33b9_full.zip -O /tmp/ns.zip
  else
    echo "✓ Using existing NS download"
  fi
  unzip -oq /tmp/ns.zip -d /temp/mods
  echo "✓ Natural Selection installed"
else
  echo "✓ Natural Selection already installed, skipping..."
fi

# Install Metamod
echo "Installing Metamod-R..."
mkdir -p /temp/mods/ns/addons/metamod/dlls
if [ ! -f /tmp/metamod.zip ]; then
  echo "Downloading Metamod-R..."
  wget -q https://github.com/rehlds/Metamod-R/releases/download/1.3.0.149/metamod-bin-1.3.0.149.zip -O /tmp/metamod.zip
else
  echo "✓ Using existing Metamod download"
fi
unzip -oq /tmp/metamod.zip -d /tmp/metamod
# Find the metamod file (it might be in a subdirectory)
find /tmp/metamod -name "metamod*" -type f -exec cp {} /temp/mods/ns/addons/metamod/dlls/metamod_i386.so \;
rm -rf /tmp/metamod

# Verify metamod was copied
if [ -f /temp/mods/ns/addons/metamod/dlls/metamod_i386.so ]; then
  echo "✓ Metamod binary found at: /temp/mods/ns/addons/metamod/dlls/metamod_i386.so"
  ls -la /temp/mods/ns/addons/metamod/dlls/
else
  echo "✗ Metamod binary not found!"
  echo "Contents of /tmp after metamod extraction:"
  find /tmp -name "*metamod*" -type f 2>/dev/null || echo "No metamod files found"
fi

# Create plugins.ini
mkdir -p /temp/mods/ns/addons/metamod
echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" > /temp/mods/ns/addons/metamod/plugins.ini

# Create liblist.gam that points to Metamod
echo "Creating liblist.gam with Metamod..."
cat > /temp/mods/ns/liblist.gam << 'EOF'
game "Natural Selection"
url_info "www.natural-selection.org"
url_dl ""
version "3.3.9"
size "184000000"
svonly "0"
secure "1"
type "multiplayer_only"
cldll "1"
hlversion "1110"
nomodels "0"
nohimodel "1"
mpentity "info_player_start"
gamedll "addons/metamod/dlls/metamod_i386.so"
gamedll_linux "addons/metamod/dlls/metamod_i386.so"
gamedll_osx "addons/metamod/dlls/metamod_i386.so"
trainmap "tr_tau"
icon "ns"
EOF

# Verify the liblist.gam file
echo "Verifying liblist.gam content:"
echo "File size: $(wc -c < /temp/mods/ns/liblist.gam) bytes"
echo "Content:"
cat /temp/mods/ns/liblist.gam
echo "--- End of liblist.gam ---"

echo "✓ Metamod configuration created"

# Install AMX Mod X
if [ ! -f /temp/mods/ns/addons/amxmodx/dlls/amxmodx_mm_i386.so ]; then
  echo "Installing AMX Mod X..."
  mkdir -p /temp/mods/ns/addons/amxmodx

  # Download base package
  if [ ! -f /tmp/amxx-base.tar.gz ]; then
    echo "Downloading AMX Mod X base..."
    wget -q https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-base-linux.tar.gz -O /tmp/amxx-base.tar.gz
  else
    echo "✓ Using existing AMX Mod X base download"
  fi
  if [ -f /tmp/amxx-base.tar.gz ] && [ -s /tmp/amxx-base.tar.gz ]; then
    tar -xzf /tmp/amxx-base.tar.gz -C /temp/mods/ns/addons/amxmodx --strip-components=1
    echo "✓ Base package extracted"
  else
    echo "Failed to download AMX Mod X base package"
  fi

  # Download Half-Life addon
  if [ ! -f /tmp/amxx-hl.tar.gz ]; then
    echo "Downloading AMX Mod X Half-Life addon..."
    wget -q https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-hlsdk-linux.tar.gz -O /tmp/amxx-hl.tar.gz
  else
    echo "✓ Using existing AMX Mod X Half-Life download"
  fi
  if [ -f /tmp/amxx-hl.tar.gz ] && [ -s /tmp/amxx-hl.tar.gz ]; then
    tar -xzf /tmp/amxx-hl.tar.gz -C /temp/mods/ns/addons/amxmodx --strip-components=1
    echo "✓ Half-Life addon extracted"
  else
    echo "Failed to download AMX Mod X Half-Life addon"
  fi

  # Set permissions if file exists
  if [ -f /temp/mods/ns/addons/amxmodx/dlls/amxmodx_mm_i386.so ]; then
    chmod +x /temp/mods/ns/addons/amxmodx/dlls/amxmodx_mm_i386.so
    # Fix all permissions for AMX Mod X directory
    chmod -R 755 /temp/mods/ns/addons/amxmodx
    chown -R 1000:1000 /temp/mods/ns/addons/amxmodx 2>/dev/null || true
    echo "✓ AMX Mod X installed"
  else
    echo "✗ AMX Mod X installation failed"
  fi
else
  echo "✓ AMX Mod X already installed, skipping..."
fi

# Fix all permissions for the entire NS directory
echo "Fixing permissions..."
chmod -R 755 /temp/mods/ns
chown -R 1000:1000 /temp/mods/ns 2>/dev/null || true

echo "🎉 Setup complete! Server is ready to start."
