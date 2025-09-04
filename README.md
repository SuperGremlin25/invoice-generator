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

To create a standalone executable for Windows, you can use one of the provided build scripts.

### Option 1: PowerShell Script (Recommended)

Use the included PowerShell script which creates a clean build with a timestamped filename:

```powershell
powershell -ExecutionPolicy Bypass -File build_premium.ps1
```

This script will:
- Create a clean build environment
- Build the executable with a unique timestamped name
- Place the final executable in the `dist_new` folder

### Option 2: Manual PyInstaller Command

1. **Install PyInstaller**:
   ```bash
   pip install pyinstaller
   ```

2. **Run the build command**:
   ```bash
   pyinstaller --onefile --windowed --name "InvoiceGeneratorPremium" invoice.py
   ```

3. **Find the executable** in the `dist` folder that PyInstaller creates.

## 📜 License

This project is licensed under the [MIT License](LICENSE).

Copyright (c) 2025 Digital Insurgent Media
Copyright (c) 2025 Khaled Mahmoud

This project is a premium white-labeled solution maintained by Digital Insurgent Media, based on the original project by Khaled Mahmoud (k5602).
