# PowerShell script to build InvoiceGeneratorPremium with a timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$buildName = "InvoiceGeneratorPremium_$timestamp"

Write-Host "Creating build: $buildName.exe" -ForegroundColor Cyan

# Create clean build folder if it doesn't exist
$buildDir = ".\clean_build_$timestamp"
if (-not (Test-Path $buildDir)) {
    New-Item -Path $buildDir -ItemType Directory | Out-Null
}

# Copy necessary files
Copy-Item -Path "invoice.py" -Destination $buildDir
Copy-Item -Path "config.json" -Destination $buildDir
Copy-Item -Path "requirements.txt" -Destination $buildDir

# Change to build directory
Push-Location $buildDir

# Install PyInstaller if not already installed
Write-Host "Checking PyInstaller installation..." -ForegroundColor Yellow
$pyinstallerInstalled = python -c "try: import PyInstaller; print('1'); except ImportError: print('0')" | Out-String
if ($pyinstallerInstalled.Trim() -eq "0") {
    Write-Host "Installing PyInstaller..." -ForegroundColor Yellow
    python -m pip install pyinstaller
}

# Build the executable
Write-Host "Building executable..." -ForegroundColor Green
python -m PyInstaller --clean --onefile --windowed --name $buildName invoice.py

# Check if build was successful
if (Test-Path ".\dist\$buildName.exe") {
    # Create destination directory if it doesn't exist
    if (-not (Test-Path "..\dist_new")) {
        New-Item -Path "..\dist_new" -ItemType Directory | Out-Null
    }
    
    # Copy executable back to main directory
    Copy-Item ".\dist\$buildName.exe" -Destination "..\dist_new\$buildName.exe"
    
    Write-Host "`nBuild completed successfully!" -ForegroundColor Green
    Write-Host "Executable created at: ..\dist_new\$buildName.exe" -ForegroundColor Green
} else {
    Write-Host "`nBuild failed. Check for errors above." -ForegroundColor Red
}

# Return to original directory
Pop-Location

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
