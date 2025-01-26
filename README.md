# Invoice Generator

A Python-based desktop application for creating professional invoices with a user-friendly GUI. Generates PDF invoices with tax calculations, supports dark/light themes, and allows dynamic item management.

![Screenshot Placeholder](screenshot1.png)  

---

## 📋 Features
- **GUI Interface**: Built with Tkinter for easy input and navigation.
- **PDF Generation**: Uses ReportLab to create clean, formatted invoices.
- **Tax Calculation**: Automatically calculates subtotal, tax, and total amounts.
- **Dark/Light Theme**: Toggle between themes for better readability.
- **Item Management**: Add or remove items dynamically.
- **Pre-filled Fields**: Invoice number, date, and customer details.
- **Multi-Platform**: Works on Windows, macOS, and Linux.

## ⚙️ Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/invoice-generator.git
   cd invoice-generator
   ```
2. **Install dependencies**:
   ```bash
   pip install tkinter reportlab pandas tkcalendar
   ```

## 🚀 Usage
1. Run the script:
   ```bash
   python invoice.py
   ```
2. Fill in customer details (name, invoice number, date, tax rate).
3. Add items (name, quantity, price) using the **Add Item** button.
4. Remove items with the **Remove Last Item** button.
5. Click **Generate Invoice** to create a PDF (saved as `Invoice_[number].pdf`).
6. Toggle themes using the **Toggle Dark/Light** button.

## 📝 Notes
- **Logo Support**: To add a company logo, modify the `generate_pdf()` function and include an `Image` object from ReportLab.
- **OS Compatibility**: The `os.startfile()` call works on Windows. For Linux/macOS, manually open the generated PDF.
## 📜 License
Open-source under the [MIT License](LICENSE).

---

Feel free to contribute by submitting issues or pull requests!  
🔧 Built with Tkinter.
