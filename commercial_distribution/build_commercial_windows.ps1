# PowerShell Build Script for Invoice Generator (Commercial Distribution)
# This script packages the application for Windows using PyInstaller.

# 1. Set variables
$AppName = "InvoiceGeneratorPremium"
$ScriptFile = "..\invoice.py"
$DistPath = ".\dist_commercial"
$BuildPath = ".\build_commercial"

# 2. Clean previous builds
Write-Host "Cleaning up previous build directories..."
if (Test-Path $DistPath) {
    Remove-Item -Recurse -Force $DistPath
}
if (Test-Path $BuildPath) {
    Remove-Item -Recurse -Force $BuildPath
}

# 3. Run PyInstaller
Write-Host "Running PyInstaller to build the executable..."
pyinstaller --name $AppName `
    --onefile `
    --windowed `
    --distpath $DistPath `
    --workpath $BuildPath `
    --add-data "..\config.json;." `
    $ScriptFile

# 4. Check if build was successful
if ($LASTEXITCODE -ne 0) {
    Write-Host "PyInstaller build failed. See output for details."
    exit 1
}

Write-Host "Executable created successfully in $DistPath"

# 5. Prepare package for distribution
$PackageDir = ".\${AppName}_Windows_Commercial"
if (Test-Path $PackageDir) {
    Remove-Item -Recurse -Force $PackageDir
}
New-Item -ItemType Directory -Path $PackageDir

# 6. Copy necessary files to the package directory
Write-Host "Copying files to the package directory..."
Copy-Item -Path "$DistPath\$AppName.exe" -Destination $PackageDir
Copy-Item -Path "..\LICENSE.txt" -Destination $PackageDir
Copy-Item -Path "..\Windows_README.txt" -Destination "$PackageDir\README.txt"
Copy-Item -Path "..\screenshot1.png" -Destination $PackageDir

# The default config.json is now bundled inside the EXE by PyInstaller.
# The app will create a user-specific config in %APPDATA% on first run.

# 7. Create a ZIP archive for distribution
$ZipFileName = "${AppName}_Windows_Commercial.zip"
if (Test-Path $ZipFileName) {
    Remove-Item $ZipFileName
}
Compress-Archive -Path "$PackageDir\*" -DestinationPath $ZipFileName

Write-Host "Commercial package created: $ZipFileName"
Write-Host "Build process complete!"
