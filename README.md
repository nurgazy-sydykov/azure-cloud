# Task 06 — Azure Three-Tier Database Solution

## Overview

Terraform project deploying a three-tier Azure solution:

- Azure Resource Group
- Azure SQL Server and Database
- SQL Firewall Rules
- Linux App Service Plan
- Linux Web App (.NET 8.0)
- Random SQL administrator password
- Credentials stored in an existing Azure Key Vault
- Secure SQL connection string passed to the Web App

**Region:** West Europe

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

## Project Structure

```text
task06/
├── modules/
│   ├── sql/
│   └── webapp/
├── locals.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars
├── variables.tf
└── versions.tf
```

## SQL and Key Vault

The SQL module creates the SQL Server, Database, firewall rules, random password, and Key Vault secrets.

Required firewall rules:

```text
AllowAzureServices
allow-verification-ip
```

The SQL password must be generated with `random_password` and never hardcoded.

The existing Key Vault is referenced as a data source and is not recreated.

## Web App

The Linux Web App must use:

- .NET 8.0
- HTTPS only
- `DefaultConnection` SQL connection string
- Sensitive SQL connection string received from the SQL module

## Deployment

```bash
az login
az account show
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Verification

Check outputs:

```bash
terraform output
```

Expected:

```text
app_hostname
sql_server_fqdn
```

Verify the resource group contains:

```text
cmaz-3o15j4kj-mod6-asp
cmaz-3o15j4kj-mod6-app
cmaz-3o15j4kj-mod6-sql
cmaz-3o15j4kj-mod6-sql-db
```

Verify Key Vault contains:

```text
sql-admin-name
sql-admin-password
```

Verify the Web App contains `DefaultConnection` pointing to:

```text
cmaz-3o15j4kj-mod6-sql.database.windows.net
cmaz-3o15j4kj-mod6-sql-db
```

