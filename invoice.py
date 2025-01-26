import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from tkcalendar import DateEntry
from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Image
from reportlab.lib.styles import getSampleStyleSheet
import pandas as pd
import os
from datetime import datetime

# ---------------------------- Constants & Globals ----------------------------
LANGUAGE = "English"
items = []  # List to hold invoice items
theme = "light"  

# ---------------------------- PDF Generation ----------------------------
def generate_pdf():
    customer_name = entry_customer_name.get()
    invoice_number = entry_invoice_number.get()
    invoice_date = entry_invoice_date.get()
    tax_rate = float(entry_tax.get() or 0)
    
    subtotal = sum(float(item[1]) * float(item[2]) for item in items)
    tax = subtotal * (tax_rate / 100)
    total = subtotal + tax

    filename = f"Invoice_{invoice_number}.pdf"
    doc = SimpleDocTemplate(filename, pagesize=letter)
    
    styles = getSampleStyleSheet()
    story = []
    
    company_info = [
        ["Invoice Number:", invoice_number],
        ["Date:", invoice_date],
        ["Customer:", customer_name]
    ]
    
    item_data = [["Item", "Quantity", "Price", "Total"]]
    for item in items:
        total = float(item[1]) * float(item[2])
        item_data.append([item[0], item[1], f"EGP {item[2]}", f"EGP {total:.2f}"])
    
    totals = [
        ["Subtotal:", f"EGP {subtotal:.2f}"],
        [f"Tax ({tax_rate}%):", f"EGP {tax:.2f}"],
        ["Total:", f"EGP {total:.2f}"]
    ]
    
    story.append(Paragraph("INVOICE", styles['Title']))
    story.append(logo)  # Optional
    story.append(Table(company_info))
    story.append(Paragraph("Items:", styles['Heading2']))
    
    item_table = Table(item_data)
    item_table.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.grey),
        ('TEXTCOLOR', (0,0), (-1,0), colors.whitesmoke),
        ('ALIGN', (0,0), (-1,-1), 'CENTER'),
        ('FONTSIZE', (0,0), (-1,0), 12),
        ('BOTTOMPADDING', (0,0), (-1,0), 12),
        ('BACKGROUND', (0,1), (-1,-1), colors.beige),
        ('GRID', (0,0), (-1,-1), 1, colors.grey)
    ]))
    
    story.append(item_table)
    story.append(Table(totals))
    
    doc.build(story)
    messagebox.showinfo("Success", f"Invoice saved as {filename}")
    os.startfile(filename)

# ---------------------------- GUI Functions ----------------------------
def add_item():
    item = entry_item.get()
    quantity = entry_quantity.get()
    price = entry_price.get()
    
    if not (item and quantity and price):
        messagebox.showerror("Error", "All fields are required!")
        return
    
    items.append([item, quantity, price])
    update_items_table()
    clear_item_fields()

def remove_item():
    if not items:
        return
    items.pop()
    update_items_table()

def clear_item_fields():
    entry_item.delete(0, tk.END)
    entry_quantity.delete(0, tk.END)
    entry_price.delete(0, tk.END)

def update_items_table():
    for row in items_table.get_children():
        items_table.delete(row)
    for idx, item in enumerate(items, start=1):
        items_table.insert("", "end", values=(idx, item[0], item[1], item[2]))

def toggle_theme():
    global theme
    theme = "dark" if theme == "light" else "light"
    root.configure(bg= "#2d2d2d" if theme == "dark" else "white")
    style.theme_use("clam")

#UI
root = tk.Tk()
root.title("Advanced Invoice Generator")
root.geometry("900x700")

style = ttk.Style()
style.theme_use("clam")
style.configure("TButton", padding=6, font=("Arial", 10))
style.configure("TLabel", font=("Arial", 10))

frame_left = ttk.Frame(root)
frame_left.pack(side="left", fill="both", expand=True, padx=10, pady=10)

frame_right = ttk.Frame(root)
frame_right.pack(side="right", fill="both", expand=True, padx=10, pady=10)

# Customer Details
ttk.Label(frame_left, text="Customer Name:").grid(row=0, column=0, sticky="w")
entry_customer_name = ttk.Entry(frame_left)
entry_customer_name.grid(row=0, column=1, pady=5)

ttk.Label(frame_left, text="Invoice Number:").grid(row=1, column=0, sticky="w")
entry_invoice_number = ttk.Entry(frame_left)
entry_invoice_number.grid(row=1, column=1, pady=5)

ttk.Label(frame_left, text="Invoice Date:").grid(row=2, column=0, sticky="w")
entry_invoice_date = DateEntry(frame_left, date_pattern="yyyy-mm-dd")
entry_invoice_date.grid(row=2, column=1, pady=5)

ttk.Label(frame_left, text="Tax Rate (%):").grid(row=3, column=0, sticky="w")
entry_tax = ttk.Entry(frame_left)
entry_tax.grid(row=3, column=1, pady=5)

ttk.Label(frame_right, text="Item:").grid(row=0, column=0, sticky="w")
entry_item = ttk.Entry(frame_right)
entry_item.grid(row=0, column=1, pady=5)

ttk.Label(frame_right, text="Quantity:").grid(row=1, column=0, sticky="w")
entry_quantity = ttk.Entry(frame_right)
entry_quantity.grid(row=1, column=1, pady=5)

ttk.Label(frame_right, text="Price (EGP):").grid(row=2, column=0, sticky="w")
entry_price = ttk.Entry(frame_right)
entry_price.grid(row=2, column=1, pady=5)

ttk.Button(frame_right, text="Add Item", command=add_item).grid(row=3, column=0, pady=10)
ttk.Button(frame_right, text="Remove Last Item", command=remove_item).grid(row=3, column=1, pady=10)

columns = ("#", "Item", "Quantity", "Price")
items_table = ttk.Treeview(frame_left, columns=columns, show="headings", height=10)
items_table.heading("#", text="#")
items_table.heading("Item", text="Item")
items_table.heading("Quantity", text="Quantity")
items_table.heading("Price", text="Price (EGP)")
items_table.grid(row=4, column=0, columnspan=2, pady=10)

ttk.Button(root, text="Generate Invoice", command=generate_pdf).pack(pady=20)

ttk.Button(root, text="Toggle Dark/Light", command=toggle_theme).pack()

root.mainloop()