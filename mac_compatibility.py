# Mac compatibility helper for Invoice Generator Premium
# Import this module in invoice.py to handle platform-specific differences

import os
import sys
import platform

# Identify the current operating system
IS_MAC = platform.system() == 'Darwin'
IS_WINDOWS = platform.system() == 'Windows'
IS_LINUX = platform.system() == 'Linux'

def get_app_path():
    """Get the application path, handling the macOS .app bundle case"""
    if IS_MAC:
        # If packaged as a macOS app bundle
        if getattr(sys, 'frozen', False) and hasattr(sys, '_MEIPASS'):
            # PyInstaller creates a temp folder and stores path in _MEIPASS
            return os.path.dirname(sys.executable)
        else:
            return os.path.dirname(os.path.abspath(__file__))
    else:
        # Windows or Linux
        if getattr(sys, 'frozen', False):
            return os.path.dirname(sys.executable)
        else:
            return os.path.dirname(os.path.abspath(__file__))

def get_config_path():
    """Get the config file path, handling different OS conventions."""
    app_name = "InvoiceGeneratorPremium"

    if IS_WINDOWS:
        # Windows: %APPDATA%\InvoiceGeneratorPremium\config.json
        config_dir = os.path.join(os.getenv('APPDATA'), app_name)
    elif IS_MAC:
        # macOS: ~/Library/Application Support/InvoiceGeneratorPremium/config.json
        config_dir = os.path.join(os.path.expanduser('~/Library/Application Support'), app_name)
    else:
        # Linux/Other: ~/.config/InvoiceGeneratorPremium/config.json
        config_dir = os.path.join(os.path.expanduser('~/.config'), app_name)

    # Create the directory if it doesn't exist
    if not os.path.exists(config_dir):
        os.makedirs(config_dir, exist_ok=True)

    return os.path.join(config_dir, "config.json")

def set_ui_style(root):
    """Set UI styles based on platform"""
    if IS_MAC:
        # macOS-specific UI tweaks
        root.option_add('*Font', 'SF Pro 12')
        return {'bg': '#f0f0f0', 'pady': 8, 'padx': 12}
    else:
        # Windows/Linux style
        return {'bg': '#f0f0f0', 'pady': 5, 'padx': 10}

def setup_file_dialog_options():
    """Configure file dialog options for current platform"""
    if IS_MAC:
        return {'initialdir': os.path.expanduser('~/Documents')}
    else:
        return {'initialdir': os.path.expanduser('~')}

def get_temp_dir():
    """Get appropriate temp directory for platform"""
    if IS_MAC:
        return os.path.expanduser('~/Library/Caches/InvoiceGeneratorPremium')
    else:
        return os.path.join(os.environ.get('TEMP', os.path.expanduser('~')), 'InvoiceGeneratorPremium')
