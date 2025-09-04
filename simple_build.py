import os
import subprocess
import sys

def main():
    print("Building Invoice Generator Premium Edition...")
    
    # Get the path to the Python executable used to run this script
    python_exe = sys.executable
    print(f"Using Python executable: {python_exe}")
    
    # Install PyInstaller if needed
    try:
        print("Checking for PyInstaller...")
        subprocess.run([python_exe, "-m", "pip", "install", "PyInstaller"], check=True)
        print("PyInstaller installed successfully")
    except Exception as e:
        print(f"Error installing PyInstaller: {e}")
        return
        
    # Run PyInstaller to create the executable
    try:
        print("Building executable...")
        subprocess.run([
            python_exe, 
            "-m", 
            "PyInstaller", 
            "--onefile", 
            "--windowed", 
            "--name", 
            "InvoiceGeneratorPremium", 
            "invoice.py"
        ], check=True)
        print("Build completed successfully!")
        
        # Check if file was created
        exe_path = os.path.join("dist", "InvoiceGeneratorPremium.exe")
        if os.path.exists(exe_path):
            print(f"Executable created at: {os.path.abspath(exe_path)}")
        else:
            print("Warning: Executable file was not found where expected")
    except Exception as e:
        print(f"Error building executable: {e}")

if __name__ == "__main__":
    main()
    input("Press Enter to exit...")
