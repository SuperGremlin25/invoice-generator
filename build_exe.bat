@echo off
echo Building Invoice Generator Premium Edition...
echo.

REM Check if Python is available
where python >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python not found. Please install Python and try again.
    goto :EOF
)

REM Create a virtual environment if it doesn't exist
if not exist venv (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate virtual environment
call venv\Scripts\activate

REM Install requirements
echo Installing requirements...
pip install -r requirements.txt

REM Build the executable
echo Building executable with PyInstaller...
pyinstaller --onefile --windowed --name "Invoice Generator Premium" invoice.py

echo.
echo Build completed! You can find the executable in the dist folder.
echo.

REM Deactivate virtual environment
deactivate

pause
