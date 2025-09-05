#!/bin/bash

# macOS Build Script for Invoice Generator (Commercial Distribution)
# This script packages the application for macOS using PyInstaller.

# 1. Set variables
APP_NAME="InvoiceGeneratorPremium"
SCRIPT_FILE="../invoice.py"
ICON_FILE="../invoice_icon.icns"
DIST_PATH="./dist_commercial_mac"
BUILD_PATH="./build_commercial_mac"

# 2. Clean previous builds
echo "Cleaning up previous build directories..."
rm -rf "$DIST_PATH"
rm -rf "$BUILD_PATH"

# 3. Run PyInstaller
echo "Running PyInstaller to build the .app bundle..."
pyinstaller --name "$APP_NAME" \
    --onefile \
    --windowed \
    --icon "$ICON_FILE" \
    --distpath "$DIST_PATH" \
    --workpath "$BUILD_PATH" \
    --add-data "../config.json:." \
    --add-data "../invoice_icon.icns:." \
    "$SCRIPT_FILE"

# 4. Check if build was successful
if [ $? -ne 0 ]; then
    echo "PyInstaller build failed. See output for details."
    exit 1
fi

echo "Application bundle created successfully in $DIST_PATH"

# 5. Prepare package for distribution
PACKAGE_DIR="./${APP_NAME}_macOS_Commercial"
rm -rf "$PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR"

# 6. Copy necessary files to the package directory
echo "Copying files to the package directory..."
cp -R "$DIST_PATH/$APP_NAME.app" "$PACKAGE_DIR/"
cp "../LICENSE.txt" "$PACKAGE_DIR/"
cp "../README.md" "$PACKAGE_DIR/README.md"
cp "../screenshot1.png" "$PACKAGE_DIR/"

# The default config.json is now bundled inside the .app by PyInstaller.
# The app will create a user-specific config in ~/Library/Application Support/ on first run.

# 7. Create a ZIP archive for distribution
ZIP_FILE_NAME="${APP_NAME}_macOS_Commercial.zip"
rm -f "$ZIP_FILE_NAME"

(cd "$PACKAGE_DIR" && zip -r "../$ZIP_FILE_NAME" .)

echo "Commercial package created: $ZIP_FILE_NAME"
echo "Build process complete!"
