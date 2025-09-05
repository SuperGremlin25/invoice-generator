# Invoice Generator Premium

A professional desktop application for creating and managing invoices with a modern user interface. This premium version generates polished PDF invoices, supports company branding, and includes enhanced features for exporting, emailing, and future CRM integration.

![Screenshot](screenshot1.png)

---

## 🚀 Features

- **Premium UI**: Modern interface with professional styling and premium color theme.
- **Tabbed Interface**: Clean, organized UI with tabs for invoice creation, reports, contacts, and settings.
- **Professional Invoices**: Generate polished PDF invoices with your company's branding.
- **Real-time Totals**: View subtotal, tax, and total calculations directly in the interface.
- **Company Settings**: Save your company details (name, address, logo, etc.) to a `config.json` file for easy reuse.
- **Logo Upload**: Easily upload and display your company logo on invoices.
- **Dynamic Item Management**: Add or remove invoice items on the fly.
- **Automatic Calculations**: Instantly calculates subtotals, taxes, and totals.
- **Export to Excel/CSV**: Export invoice data for accounting and analysis.
- **Email Invoices**: Send PDF invoices directly from the application (requires SMTP configuration).
- **Future Premium Features**: Placeholder tabs for CRM and reporting functionality (coming soon).

## 🛠️ Setup

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/GUI-Invoice-Generator.git
    cd GUI-Invoice-Generator
    ```

2.  **Create a virtual environment** (recommended):
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
    ```

3.  **Install dependencies** from `requirements.txt`:
    ```bash
    pip install -r requirements.txt
    ```

## 🚀 Usage

1.  **Run the application**:
    ```bash
    python invoice.py
    ```

2.  **Configure Company Settings**:
    - Go to the **Company Settings** tab.
    - Fill in your company's details and upload a logo.
    - Click **Save Settings**. Your details will be saved to `config.json` and automatically loaded next time.

3.  **Create an Invoice**:
    - In the **Create Invoice** tab, fill in the customer's name, invoice number, and date.
    - Add items with their quantity and price.
    - Click **Generate PDF** to create the invoice.
    - Use **Export to Excel/CSV** to save the data in a spreadsheet.
    - Click **Email Invoice** to send the PDF as an attachment. You will be prompted for recipient details and your SMTP credentials.

## 📦 Packaging

### Commercial Distribution

For commercial distribution, use the dedicated build scripts located in the `commercial_distribution` directory. These scripts create packages that store user configurations in the appropriate system-wide application data folders, ensuring a clean and professional user experience.

#### Windows Commercial Build

Use the PowerShell script in the `commercial_distribution` folder:

```powershell
# Navigate to the commercial distribution directory
cd commercial_distribution

# Run the build script
powershell -ExecutionPolicy Bypass -File .\build_commercial_windows.ps1
```

This will generate a zipped package named `InvoiceGeneratorPremium_Windows_Commercial.zip` containing the executable and all necessary files.

#### macOS Commercial Build

Use the shell script in the `commercial_distribution` folder:

```bash
# Navigate to the commercial distribution directory
cd commercial_distribution

# Make the script executable
chmod +x build_commercial_mac.sh

# Run the build script
./build_commercial_mac.sh
```

This will generate a zipped package named `InvoiceGeneratorPremium_macOS_Commercial.zip` containing the `.app` bundle and other files.

---

### Development Builds

You can create standalone executables for both Windows and macOS for development purposes.

You can create standalone executables for both Windows and macOS.

### Windows Build

#### Option 1: PowerShell Script (Recommended)

Use the included PowerShell script which creates a clean build with a timestamped filename:

```powershell
powershell -ExecutionPolicy Bypass -File build_premium.ps1
```

This script will:
- Create a clean build environment
- Build the executable with a unique timestamped name
- Place the final executable in the `dist_new` folder

#### Option 2: Manual PyInstaller Command

1. **Install PyInstaller**:
   ```bash
   pip install pyinstaller
   ```

2. **Run the build command**:
   ```bash
   pyinstaller --onefile --windowed --name "InvoiceGeneratorPremium" invoice.py
   ```

### macOS Build

#### Option 1: Shell Script (Recommended)

Use the included shell script to create a macOS application:

```bash
# Make the script executable
chmod +x build_mac.sh

# Run the build script
./build_mac.sh
```

This script will:
- Create a clean build environment
- Build the application with a unique timestamped name
- Place the final executable in the `dist_mac` folder

#### Option 2: Manual PyInstaller Command

1. **Install PyInstaller**:
   ```bash
   pip3 install pyinstaller
   ```

2. **Run the build command**:
   ```bash
   python3 -m PyInstaller --windowed --onefile --name "InvoiceGeneratorPremium" invoice.py
   ```

3. **Make the executable runnable**:
   ```bash
   chmod +x dist/InvoiceGeneratorPremium
   ```

### Creating a proper macOS .app bundle

For a more native macOS experience, you can convert the executable into a proper .app bundle using [Platypus](https://sveinbjorn.org/platypus):

1. **Install Platypus**:
   ```bash
   brew install platypus
   ```

2. **Create the .app bundle**:
   ```bash
   platypus -a 'Invoice Generator Premium' -o 'Text' -I 'com.digitalinsurgent.invoicegenerator' -f dist_mac/InvoiceGeneratorPremium -i app_icon.png -y dist_mac/InvoiceGeneratorPremium.app
   ```

## 📜 License

This project is licensed under the [MIT License](LICENSE).

Copyright (c) 2025 Digital Insurgent Media
Copyright (c) 2025 Khaled Mahmoud

This project is a premium white-labeled solution maintained by Digital Insurgent Media, based on the original project by Khaled Mahmoud (k5602).
