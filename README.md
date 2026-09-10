# Task 06 – Azure Three-Tier Azure Solution with Terraform

## 📌 Overview
This project provisions a **three-tier solution** in Azure using Terraform modules:
- **SQL Tier**: Azure SQL Server + Azure SQL Database with firewall rules, random admin password, and secrets stored in Key Vault.
- **App Tier**: Azure App Service Plan (Linux) + Linux Web App running .NET 8.0, configured with a secure connection string to the SQL Database.
- **Infrastructure Layer**: Resource Group, orchestration of modules, and outputs.

The solution ensures:
- Secure credential management via Azure Key Vault.
- Modular, reusable Terraform code.
- Compliance with task requirements (no hardcoding, no local-exec, no prevent_destroy).

---

## Architecture

```text
Internet
   |
   v
Azure Linux Web App
   |
   v
Azure SQL Database
   |
   v
Azure SQL Server

SQL credentials -> Existing Azure Key Vault
```

## Required Configuration

| Parameter | Value |
|---|---|
| Name prefix | `cmaz-3o15j4kj-mod6` |
| Resource Group | `cmaz-3o15j4kj-mod6-rg` |
| Key Vault | `cmaz-3o15j4kj-mod6-kv` |
| SQL Server | `cmaz-3o15j4kj-mod6-sql` |
| SQL Database | `cmaz-3o15j4kj-mod6-sql-db` |
| SQL SKU | `S2` |
| App Service Plan | `cmaz-3o15j4kj-mod6-asp` |
| App Service SKU | `P0v3` |
| Web App | `cmaz-3o15j4kj-mod6-app` |
| .NET | `8.0` |
| Verification IP | `18.153.146.156` |
| Key Vault secrets | `sql-admin-name`, `sql-admin-password` |

## 📂 Project Structure

```
task06/
├── modules/
│   ├── sql/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── webapp/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars
├── variables.tf
└── versions.tf
```
---

## ⚙️ Configuration Details

### Resource Names
All names are generated dynamically in `locals.tf` using the prefix:

name_prefix = "cmaz-3o15j4kj-mod6"

Resulting names:
- Resource Group: `cmaz-3o15j4kj-mod6-rg`
- SQL Server: `cmaz-3o15j4kj-mod6-sql`
- SQL Database: `cmaz-3o15j4kj-mod6-sql-db`
- App Service Plan: `cmaz-3o15j4kj-mod6-asp`
- Web App: `cmaz-3o15j4kj-mod6-app`
- Key Vault: `cmaz-3o15j4kj-mod6-kv`

### SQL Admin Credentials
- Username: defined in `terraform.tfvars`
- Password: generated via `random_password` in SQL module
- Both stored in existing Key Vault:
  - Secret name for username: `sql-admin-name`
  - Secret name for password: `sql-admin-password`

### Firewall Rules
- Allow Azure services (`0.0.0.0`)
- Allow verification agent IP: `18.153.146.156`
---

## 📤 Outputs
- `sql_server_fqdn`: Fully qualified domain name of SQL Server
- `app_hostname`: Public hostname of the Linux Web App
- `sql_connection_string`: Sensitive ADO.NET connection string (passed internally)

---

## 🚀 Usage

### 1. Initialize
```bash
terraform init
```

### 2. Validate
```bash
terraform validate
```

### 3. Plan
```bash
terraform plan
```

### 4. Apply
```bash
terraform apply
```