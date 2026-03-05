# 💼 Salesforce CPQ Lite — Opportunity-to-Order System

A mid-level Salesforce Developer project that demonstrates a complete **Configure-Price-Quote (CPQ)** workflow built natively on the Salesforce platform.

---

## 📌 Project Overview

This project implements a full **Opportunity-to-Order** system allowing sales teams to:
- Create price quotes linked to Opportunities
- Add line items with automatic price calculation
- Submit quotes for approval when total exceeds $1,000
- Generate and send professional PDF quotes by email

---

## 🏗️ Data Model

```
Opportunity (Standard)
      │
      │ Lookup
      ▼
   Quote__c
      │
      │ Master-Detail
      ▼
Quote_Line_Item__c
```

### Quote__c (Custom Object)
| Field | Type | Description |
|-------|------|-------------|
| Opportunity__c | Lookup | Links to Opportunity |
| Status__c | Picklist | Draft / Pending Approval / Approved / Rejected |
| Subtotal__c | Currency | Sum of all line items |
| Discount__c | Percent | Discount percentage |
| Tax__c | Percent | Tax percentage |
| Total_Amount__c | Currency | Final calculated total |

### Quote_Line_Item__c (Custom Object)
| Field | Type | Description |
|-------|------|-------------|
| Quote__c | Master-Detail | Links to Quote |
| Product_Name__c | Text | Name of the product |
| Quantity__c | Number | Quantity ordered |
| Unit_Price__c | Currency | Price per unit |
| Line_Total__c | Currency | Quantity × Unit Price |

---

## ⚙️ Components Built

### 🔷 Apex Classes
- **`QuoteCalculator.cls`** — Calculates line totals, subtotal, discount, tax, and final total automatically
- **`QuoteEmailSender.cls`** — Generates a PDF from the Visualforce page and sends it by email with attachment

### ⚡ Apex Trigger
- **`QuoteLineItemTrigger.trigger`** — Fires on insert, update, and delete of line items to auto-trigger calculations

### 📄 Visualforce Page
- **`QuotePDF.page`** — Renders a professional quote document as a downloadable PDF

### 🔐 Approval Process
- **`Quote Approval Process`** — Auto-submits quotes for manager approval when Total Amount exceeds $1,000. Locks the record during review.

---

## 🚀 How to Deploy

### Prerequisites
- Salesforce CLI installed
- VS Code with Salesforce Extension Pack
- A Salesforce Developer Org

### Steps

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/salesforce-cpq-lite.git
cd salesforce-cpq-lite

# Authorize your Salesforce org
sf org login web --alias my-dev-org

# Deploy all metadata
sf project deploy start --source-dir force-app
```

---

## 🧠 Skills Demonstrated

| Skill | Usage |
|-------|-------|
| **Apex Classes** | Business logic, email service |
| **Apex Triggers** | Event-driven automation |
| **SOQL** | Querying related objects |
| **Visualforce** | PDF document generation |
| **Approval Processes** | Multi-step record approval |
| **Custom Objects & Fields** | Data modeling |
| **Salesforce DX (SFDX)** | Source-driven development |
| **Git / GitHub** | Version control |

---

## 📸 Project Flow

```
1. Salesperson creates a Quote linked to an Opportunity
         ↓
2. Adds Line Items (products, quantity, price)
         ↓
3. Trigger fires → QuoteCalculator auto-calculates totals
         ↓
4. If Total > $1,000 → Approval Process kicks in
         ↓
5. Manager Approves or Rejects the Quote
         ↓
6. On Approval → PDF generated & emailed automatically
```

---

## 👨‍💻 Author

Built as a portfolio project to demonstrate mid-level Salesforce Developer skills including Apex, automation, and document generation.

---

## 📜 License
MIT
