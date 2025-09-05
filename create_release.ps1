# Create Release Package Script
# This script creates a clean release package with all necessary files

# Set error handling
$ErrorActionPreference = "Stop"
$timestamp = Get-Date -Format "yyyyMMdd-HHmm"
$releaseName = "InvoiceGeneratorPremium_$timestamp"
$releaseDir = ".\releases\$releaseName"
$zipFile = ".\releases\$releaseName.zip"

# Ensure we're in the correct directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

try {
    # Create release directory
    Write-Host "Creating release directory: $releaseDir"
    if (Test-Path $releaseDir) {
        Remove-Item -Path $releaseDir -Recurse -Force
    }
    $null = New-Item -ItemType Directory -Force -Path $releaseDir

    # Copy source files
    $sourceFiles = @(
        "invoice.py",
        "mac_compatibility.py", 
        "requirements.txt",
        "LICENSE.txt",
        "README.md",
        "screenshot1.png"
    )

    Write-Host "`nCopying source files..."
    foreach ($file in $sourceFiles) {
        if (Test-Path $file) {
            Write-Host "  - $file"
            Copy-Item -Path $file -Destination "$releaseDir\" -Force
        } else {
            Write-Warning "  - Warning: $file not found"
        }
    }

    # Copy commercial distribution files
    $commercialDir = "$releaseDir\commercial_distribution"
    Write-Host "`nCopying commercial distribution files..."
    if (Test-Path ".\commercial_distribution") {
        $null = New-Item -ItemType Directory -Force -Path $commercialDir
        Copy-Item -Path ".\commercial_distribution\*" -Destination $commercialDir -Recurse -Force
        Write-Host "  - Copied commercial distribution files"
    } else {
        Write-Warning "  - Warning: commercial_distribution directory not found"
    }

    # Create ZIP archive
    Write-Host "`nCreating ZIP archive: $zipFile"
    if (Test-Path $zipFile) {
        Remove-Item -Path $zipFile -Force
    }
    
    # Use Compress-Archive with full path to avoid long path issues
    $compressArgs = @{
        Path = "$releaseDir\*"
        DestinationPath = $zipFile
        CompressionLevel = "Optimal"
        Force = $true
    }
    Compress-Archive @compressArgs

    # Verify the ZIP was created
    if (Test-Path $zipFile) {
        $zipSize = (Get-Item $zipFile).Length / 1MB
        Write-Host "`n✅ Release package created successfully!" -ForegroundColor Green
        Write-Host "   Location: $(Resolve-Path $zipFile)" -ForegroundColor Cyan
        Write-Host "   Size: {0:N2} MB" -f $zipSize -ForegroundColor Cyan
    } else {
        throw "Failed to create ZIP file"
    }
}
catch {
    Write-Host "`n❌ Error creating release package:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
finally {
    # Clean up the temporary directory
    if (Test-Path $releaseDir) {
        Remove-Item -Path $releaseDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}
