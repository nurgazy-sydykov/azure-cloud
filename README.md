# Task 06 — Three-Tier Database Solution with Azure Linux App Service and Azure SQL Database

## Overview

This Terraform project deploys a Three-Tier Database solution in Microsoft Azure using reusable Terraform modules.

The solution contains:

- Azure Resource Group
- Azure SQL Logical Server
- Azure SQL Database
- Azure SQL Firewall Rules
- Azure App Service Plan for Linux
- Azure Linux Web App with .NET 8.0
- Randomly generated SQL administrator password
- SQL administrator credentials stored in an existing Azure Key Vault
- SQL Database connection string passed securely from the `sql` module to the `webapp` module

The infrastructure is deployed to **West Europe**.

---

## Architecture

```text
Internet
   |
   v
Azure Linux Web App
   |
   | ADO.NET SQL authentication connection string
   v
Azure SQL Database
   |
   v
Azure SQL Logical Server

SQL administrator credentials
   |
   v
Existing Azure Key Vault
```

The Azure SQL firewall allows:

1. Connections from Azure services.
2. Connections from the verification IP address `18.153.146.156`.

---

## Task Parameters

| Parameter | Value |
|---|---|
| Region | `West Europe` |
| Name prefix | `cmaz-3o15j4kj-mod6` |
| Existing Key Vault Resource Group | `cmaz-3o15j4kj-mod6-kv-rg` |
| Existing Key Vault | `cmaz-3o15j4kj-mod6-kv` |
| Resource Group | `cmaz-3o15j4kj-mod6-rg` |
| SQL admin username secret | `sql-admin-name` |
| SQL admin password secret | `sql-admin-password` |
| SQL Server | `cmaz-3o15j4kj-mod6-sql` |
| SQL Database | `cmaz-3o15j4kj-mod6-sql-db` |
| SQL Database SKU | `S2` |
| Verification firewall rule | `allow-verification-ip` |
| Verification IP | `18.153.146.156` |
| App Service Plan | `cmaz-3o15j4kj-mod6-asp` |
| App Service Plan SKU | `P0v3` |
| Web App | `cmaz-3o15j4kj-mod6-app` |
| .NET version | `8.0` |
| Tag | `Creator=nurgazy_sydykov@epam.com` |

---

## Project Structure

```text
task06
├── modules
│   ├── sql
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── webapp
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

## Resource Naming

Resource names must be generated in `locals.tf` using the input variable `name_prefix` and Terraform functions such as `format()` or `join()`.

Example:

```hcl
locals {
  rg_name         = format("%s-rg", var.name_prefix)
  sql_server_name = format("%s-sql", var.name_prefix)
  sql_db_name     = format("%s-sql-db", var.name_prefix)
  asp_name        = format("%s-asp", var.name_prefix)
  app_name        = format("%s-app", var.name_prefix)

  tags = {
    Creator = "nurgazy_sydykov@epam.com"
  }
}
```

With:

```hcl
name_prefix = "cmaz-3o15j4kj-mod6"
```

the generated values are:

```text
cmaz-3o15j4kj-mod6-rg
cmaz-3o15j4kj-mod6-sql
cmaz-3o15j4kj-mod6-sql-db
cmaz-3o15j4kj-mod6-asp
cmaz-3o15j4kj-mod6-app
```

---

# SQL Module

The `modules/sql` module is responsible for creating and configuring the database tier.

It should contain:

- `azurerm_mssql_server`
- `azurerm_mssql_database`
- `azurerm_mssql_firewall_rule`
- `random_password`
- `azurerm_key_vault_secret`

## SQL Administrator

The SQL administrator username can be supplied through an input variable.

Example:

```hcl
sql_admin_username = "sqladminuser"
```

The administrator password must **not** be hardcoded.

Generate it inside the SQL module:

```hcl
resource "random_password" "sql_admin" {
  length           = 20
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}
```

The generated password is used by the Azure SQL Server and stored in Key Vault.

---

## Azure SQL Server

Example configuration:

```hcl
resource "azurerm_mssql_server" "this" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_admin.result

  tags = var.tags
}
```

---

## Azure SQL Database

The database uses the requested `S2` service level.

```hcl
resource "azurerm_mssql_database" "this" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.this.id
  sku_name  = var.sql_db_sku

  tags = var.tags
}
```

Expected value:

```hcl
sql_db_sku = "S2"
```

---

## SQL Firewall Rules

### Allow Azure Services

Azure SQL uses the special address `0.0.0.0` to enable the **Allow Azure services and resources to access this server** firewall configuration.

```hcl
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
```

### Allow Verification IP

```hcl
resource "azurerm_mssql_firewall_rule" "verification" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}
```

For automatic verification:

```hcl
allowed_ip_address = "18.153.146.156"
```

For local testing, this value may temporarily be changed to the public IP address of the development machine.

Before submitting the task for automatic verification, restore:

```text
18.153.146.156
```

---

## Store SQL Credentials in Existing Key Vault

The existing Key Vault is obtained in the root module:

```hcl
data "azurerm_key_vault" "existing" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}
```

Its ID is passed to the SQL module:

```hcl
key_vault_id = data.azurerm_key_vault.existing.id
```

The SQL module stores the credentials:

```hcl
resource "azurerm_key_vault_secret" "sql_admin_name" {
  name         = var.sql_admin_name_secret_name
  value        = var.sql_admin_username
  key_vault_id = var.key_vault_id

  tags = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.sql_admin_password_secret_name
  value        = random_password.sql_admin.result
  key_vault_id = var.key_vault_id

  tags = var.tags
}
```

Expected secret names:

```text
sql-admin-name
sql-admin-password
```

---

## SQL Connection String

The SQL module must generate a sensitive ADO.NET connection string using SQL authentication.

Example:

```hcl
output "sql_connection_string" {
  value = format(
    "Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.this.fully_qualified_domain_name,
    azurerm_mssql_database.this.name,
    var.sql_admin_username,
    random_password.sql_admin.result
  )

  sensitive = true
}
```

The SQL module should also expose its server FQDN:

```hcl
output "sql_server_fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}
```

---

# Web App Module

The `modules/webapp` module contains:

- Azure App Service Plan
- Azure Linux Web App

---

## App Service Plan

```hcl
resource "azurerm_service_plan" "this" {
  name                = var.asp_name
  resource_group_name = var.resource_group_name
  location            = var.location

  os_type  = "Linux"
  sku_name = var.asp_sku

  tags = var.tags
}
```

Required SKU:

```hcl
asp_sku = "P0v3"
```

---

## Linux Web App

The Linux Web App uses .NET 8.0:

```hcl
resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }

  tags = var.tags
}
```

The module variable carrying the SQL connection string must be sensitive:

```hcl
variable "sql_connection_string" {
  description = "ADO.NET SQL Database connection string."
  type        = string
  sensitive   = true
}
```

The Web App hostname output:

```hcl
output "app_hostname" {
  value = azurerm_linux_web_app.this.default_hostname
}
```

---

# Root Module

The root `main.tf` orchestrates the complete infrastructure.

Conceptually:

```hcl
resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

data "azurerm_key_vault" "existing" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

module "sql" {
  source = "./modules/sql"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  sql_server_name = local.sql_server_name
  sql_db_name     = local.sql_db_name
  sql_db_sku      = var.sql_db_sku

  sql_admin_username             = var.sql_admin_username
  sql_admin_name_secret_name     = var.sql_admin_name_secret_name
  sql_admin_password_secret_name = var.sql_admin_password_secret_name

  key_vault_id = data.azurerm_key_vault.existing.id

  firewall_rule_name = var.firewall_rule_name
  allowed_ip_address = var.allowed_ip_address

  tags = local.tags
}

module "webapp" {
  source = "./modules/webapp"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  asp_name       = local.asp_name
  asp_sku        = var.asp_sku
  app_name       = local.app_name
  dotnet_version = var.dotnet_version

  sql_connection_string = module.sql.sql_connection_string

  tags = local.tags
}
```

This establishes the dependency chain:

```text
Resource Group
     |
     +--> SQL module
     |      |
     |      +--> generated SQL credentials
     |      +--> SQL Server
     |      +--> SQL Database
     |      +--> firewall rules
     |      +--> Key Vault secrets
     |      +--> sensitive connection string
     |
     +--> Web App module
            |
            +--> App Service Plan
            +--> Linux Web App
            +--> SQL connection string
```

---

# Root Outputs

`outputs.tf` should contain:

```hcl
output "sql_server_fqdn" {
  description = "Azure SQL Server fully qualified domain name."
  value       = module.sql.sql_server_fqdn
}

output "app_hostname" {
  description = "Linux Web App hostname."
  value       = module.webapp.app_hostname
}
```

Expected Terraform outputs:

```text
sql_server_fqdn
app_hostname
```

---

# Example terraform.tfvars

```hcl
name_prefix = "cmaz-3o15j4kj-mod6"

location = "West Europe"

key_vault_resource_group_name = "cmaz-3o15j4kj-mod6-kv-rg"
key_vault_name                = "cmaz-3o15j4kj-mod6-kv"

sql_admin_username             = "sqladminuser"
sql_admin_name_secret_name     = "sql-admin-name"
sql_admin_password_secret_name = "sql-admin-password"

sql_db_sku = "S2"

firewall_rule_name = "allow-verification-ip"
allowed_ip_address = "18.153.146.156"

asp_sku        = "P0v3"
dotnet_version = "8.0"
```

---

# Provider Configuration

A typical `versions.tf` can contain:

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

If the training environment or automated verifier requires a specific AzureRM version, use the version required by the course instead of changing it only to match this example.

---

# Prerequisites

Required software:

- Terraform
- Azure CLI
- Azure subscription with permission to create resources
- Permission to read the existing Key Vault
- Permission to create/update secrets in the existing Key Vault

Authenticate to Azure:

```bash
az login
```

Check the active subscription:

```bash
az account show
```

If necessary:

```bash
az account set --subscription "<subscription-id>"
```

---

# Deployment

Navigate to the project:

```bash
cd task06
```

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt -recursive
```

Validate it:

```bash
terraform validate
```

Create the execution plan:

```bash
terraform plan
```

Deploy:

```bash
terraform apply
```

Confirm the deployment when requested.

---

# Verification

## 1. Verify Terraform Outputs

Run:

```bash
terraform output
```

The output should include:

```text
app_hostname
sql_server_fqdn
```

Open the Web App using:

```text
https://<app_hostname>
```

The application must be publicly reachable.

---

## 2. Verify Azure Resources

The resource group:

```text
cmaz-3o15j4kj-mod6-rg
```

should contain:

- App Service Plan: `cmaz-3o15j4kj-mod6-asp`
- Linux Web App: `cmaz-3o15j4kj-mod6-app`
- SQL Server: `cmaz-3o15j4kj-mod6-sql`
- SQL Database: `cmaz-3o15j4kj-mod6-sql-db`

The existing Key Vault remains in:

```text
cmaz-3o15j4kj-mod6-kv-rg
```

and is not recreated by this project.

---

## 3. Verify Key Vault Secrets

The Key Vault:

```text
cmaz-3o15j4kj-mod6-kv
```

should contain:

```text
sql-admin-name
sql-admin-password
```

Example Azure CLI commands:

```bash
az keyvault secret show \
  --vault-name cmaz-3o15j4kj-mod6-kv \
  --name sql-admin-name \
  --query value \
  --output tsv
```

For the password:

```bash
az keyvault secret show \
  --vault-name cmaz-3o15j4kj-mod6-kv \
  --name sql-admin-password \
  --query value \
  --output tsv
```

Do not include the returned password in screenshots, Git commits, README files, or other public output.

---

## 4. Verify SQL Firewall

The SQL Server should contain two firewall rules:

```text
AllowAzureServices
allow-verification-ip
```

The verification rule must allow:

```text
18.153.146.156
```

For local testing, change `allowed_ip_address` to your current public IP and run:

```bash
terraform apply
```

Before automatic verification, change it back to:

```text
18.153.146.156
```

and run `terraform apply` again.

---

## 5. Verify Web App Database Connection String

In Azure Portal:

```text
App Services
→ cmaz-3o15j4kj-mod6-app
→ Settings / Configuration
→ Connection strings
```

Verify that the Web App contains:

```text
DefaultConnection
```

with SQL/Azure SQL connection type.

The connection string should point to:

```text
cmaz-3o15j4kj-mod6-sql.database.windows.net
```

and database:

```text
cmaz-3o15j4kj-mod6-sql-db
```

---

## 6. Connect to the SQL Database

Retrieve the SQL administrator username and password from Key Vault.

Server:

```text
cmaz-3o15j4kj-mod6-sql.database.windows.net
```

Database:

```text
cmaz-3o15j4kj-mod6-sql-db
```

Authentication:

```text
SQL Authentication
```

You can connect using:

- Azure Data Studio
- SQL Server Management Studio
- Azure Portal Query Editor

Your current public IP must be allowed by the SQL Server firewall if connecting from your local machine.

---

# Security Notes

## Sensitive Terraform Outputs

The SQL connection string must be declared as a sensitive output:

```hcl
sensitive = true
```

The receiving Web App module variable must also be sensitive.

This prevents Terraform from displaying the value normally in CLI output.

However, **Terraform sensitive values are still stored in Terraform state**.

Therefore:

- Never commit `terraform.tfstate` to Git.
- Never commit `.terraform/`.
- Never hardcode SQL passwords.
- Do not print the connection string as a non-sensitive output.
- Do not expose Key Vault secret values in logs or screenshots.
- Protect remote state if a remote Terraform backend is used.

Recommended `.gitignore`:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
crash.log
crash.*.log
*.tfplan
.terraform.lock.hcl
```

Depending on project requirements, `.terraform.lock.hcl` may be intentionally committed. Follow the repository/course policy.

---

# Key Vault Permissions

Terraform must have permission to create secrets in the existing Key Vault.

If the vault uses Azure RBAC, the identity executing Terraform typically requires an appropriate Key Vault secrets role.

If it uses Key Vault access policies, the Terraform identity requires secret permissions that include at least:

```text
Get
Set
```

If `terraform apply` returns `403 Forbidden`, verify the current Azure identity and its Key Vault permissions.

---

# Useful Commands

Format all Terraform files:

```bash
terraform fmt -recursive
```

Validate configuration:

```bash
terraform validate
```

Preview changes:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

Display normal outputs:

```bash
terraform output
```

Destroy the resources created by this configuration:

```bash
terraform destroy
```

The existing Key Vault is referenced through a Terraform data source and therefore should not be destroyed by this project.

---

# Expected Result

After successful deployment:

```text
Resource Group
└── cmaz-3o15j4kj-mod6-rg
    ├── cmaz-3o15j4kj-mod6-asp
    ├── cmaz-3o15j4kj-mod6-app
    ├── cmaz-3o15j4kj-mod6-sql
    └── cmaz-3o15j4kj-mod6-sql-db
```

Existing Key Vault:

```text
cmaz-3o15j4kj-mod6-kv-rg
└── cmaz-3o15j4kj-mod6-kv
    ├── sql-admin-name
    └── sql-admin-password
```

The Web App must be accessible from the public Internet and contain a valid Azure SQL Database connection string.

The SQL administrator password must be randomly generated by Terraform and must not be manually hardcoded.

---

# Final Checklist

Before submitting for verification, confirm:

- [ ] `terraform fmt -recursive` completes successfully
- [ ] `terraform validate` completes successfully
- [ ] `terraform plan` completes successfully
- [ ] `terraform apply` completes successfully
- [ ] Resource names are generated from `name_prefix`
- [ ] Resource Group is `cmaz-3o15j4kj-mod6-rg`
- [ ] SQL Server is `cmaz-3o15j4kj-mod6-sql`
- [ ] SQL Database is `cmaz-3o15j4kj-mod6-sql-db`
- [ ] SQL Database SKU is `S2`
- [ ] App Service Plan is `cmaz-3o15j4kj-mod6-asp`
- [ ] App Service Plan SKU is `P0v3`
- [ ] Web App is `cmaz-3o15j4kj-mod6-app`
- [ ] Linux Web App uses .NET `8.0`
- [ ] Key Vault is referenced as an existing resource
- [ ] `sql-admin-name` exists in Key Vault
- [ ] `sql-admin-password` exists in Key Vault
- [ ] SQL password is generated using `random_password`
- [ ] Azure services SQL firewall rule exists
- [ ] `allow-verification-ip` firewall rule exists
- [ ] Verification IP is `18.153.146.156`
- [ ] `sql_connection_string` is sensitive
- [ ] Web App receives SQL connection string
- [ ] `sql_server_fqdn` output exists
- [ ] `app_hostname` output exists
- [ ] Required `Creator` tag is applied
- [ ] Terraform state is not committed to Git
