# PowerShell script to clean up the repository for GitHub

Write-Host "Cleaning up repository for GitHub..." -ForegroundColor Cyan

# Define files and directories to keep
$essentialFiles = @(
    "invoice.py",
    "config.json",
    "requirements.txt",
    "README.md",
    "LICENSE",
    "screenshot1.png",
    "build_premium.ps1",
    "dist_new\InvoiceGeneratorPremium*.exe"  # Keep the latest executable
)

# Create clean directory structure
Write-Host "Creating a clean directory structure..." -ForegroundColor Yellow

# Clean up build artifacts
if (Test-Path -Path "build") {
    Write-Host "Removing build directory..." -ForegroundColor Yellow
    Remove-Item -Path "build" -Recurse -Force
}

# Clean up PyInstaller cache
Get-ChildItem -Path "." -Filter "*.spec" | ForEach-Object {
    Write-Host "Removing $($_.Name)..." -ForegroundColor Yellow
    Remove-Item -Path $_.FullName -Force
}

# Clean up Python cache files
Get-ChildItem -Path "." -Filter "__pycache__" -Recurse | ForEach-Object {
    Write-Host "Removing Python cache: $($_.FullName)..." -ForegroundColor Yellow
    Remove-Item -Path $_.FullName -Recurse -Force
}

# Clean up old build files
if (Test-Path -Path "clean_build*") {
    Write-Host "Removing temporary build directories..." -ForegroundColor Yellow
    Remove-Item -Path "clean_build*" -Recurse -Force
}

# Remove old backup files
Get-ChildItem -Path "." -Filter "*.bak" | ForEach-Object {
    Write-Host "Removing backup file: $($_.Name)..." -ForegroundColor Yellow
    Remove-Item -Path $_.FullName -Force
}

# Remove virtual environment
if (Test-Path -Path "venv") {
    Write-Host "Removing virtual environment..." -ForegroundColor Yellow
    Remove-Item -Path "venv" -Recurse -Force
}

Write-Host "`nRepository cleaned successfully!" -ForegroundColor Green
Write-Host "To push to GitHub, run the following commands:" -ForegroundColor Cyan
Write-Host "
# Initialize git repository if not already done
git init

# Add all files to git
git add .

# Commit your changes
git commit -m 'Initial commit of Invoice Generator Premium'

# Add your GitHub repository as a remote
git remote add origin https://github.com/SuperGremlin25/invoice-generator.git

# Push your code to GitHub
git push -u origin main
" -ForegroundColor White

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
