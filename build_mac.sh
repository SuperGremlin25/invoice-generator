#!/bin/bash

# Build script for Invoice Generator Premium for macOS
# This script creates a standalone macOS application

echo "=== Building Invoice Generator Premium for macOS ==="

# Create timestamp for unique naming
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BUILD_NAME="InvoiceGeneratorPremium_${TIMESTAMP}"

# Create clean build directory
BUILD_DIR="./mac_build_${TIMESTAMP}"
mkdir -p "$BUILD_DIR"

echo "Creating build directory: $BUILD_DIR"

# Copy necessary files
cp invoice.py "$BUILD_DIR/"
cp config.json "$BUILD_DIR/"
cp requirements.txt "$BUILD_DIR/"

if [ -f "screenshot1.png" ]; then
    cp screenshot1.png "$BUILD_DIR/"
fi

# Change to build directory
cd "$BUILD_DIR" || { echo "Failed to change to build directory"; exit 1; }

echo "Installing required packages..."
# Check if virtual environment should be created
python3 -m pip install -r requirements.txt
python3 -m pip install pyinstaller

echo "Building macOS application..."
# Build macOS app
python3 -m PyInstaller --windowed \
    --name "$BUILD_NAME" \
    --icon="../app_icon.icns" \
    --add-data "config.json:." \
    --clean \
    --onefile \
    invoice.py

# Create dist_mac directory in the parent folder if it doesn't exist
mkdir -p ../dist_mac

# Copy the app to the dist_mac folder
if [ -f "dist/$BUILD_NAME" ]; then
    cp "dist/$BUILD_NAME" "../dist_mac/"
    cp "../config.json" "../dist_mac/"
    echo "✅ Build completed successfully!"
    echo "Application created at: dist_mac/$BUILD_NAME"
else
    echo "❌ Build failed. Check for errors above."
fi

# Return to original directory
cd .. || exit

echo ""
echo "To make the application executable, run:"
echo "chmod +x dist_mac/$BUILD_NAME"
echo ""
echo "To create a proper macOS .app bundle, you can use:"
echo "platypus -a 'Invoice Generator Premium' -o 'Text' -p /usr/bin/python3 -V '1.0' -I 'com.digitalinsurgent.invoicegenerator' -f dist_mac/$BUILD_NAME -i app_icon.png -y dist_mac/InvoiceGeneratorPremium.app"
echo "(requires installing Platypus: brew install platypus)"
