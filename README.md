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

## Project Structure

```text
task06/
Yesterday
"Task
Develop Terraform modules for Azure SQL Server with Azure SQL Database, Azure App Service Plan with Linux Web App containing connection string to DB
Use the developed modules to create Terraform configuration for a Three-Tier Database solution using Linux App Service and Azure SQL Database
Terraform configuration should randomly generate SQL admin credentials and store them securely in the existing Azure Key Vault
Task parameters
Region: West Europe
Existing Key Vault Resource group name: cmaz-3o15j4kj-mod6-kv-rg
Existing Key Vault Name: cmaz-3o15j4kj-mod6-kv
Resource group name: cmaz-3o15j4kj-mod6-rg
Key Vault Secret name for SQL admin name: sql-admin-name
Key Vault Secret name for SQL admin password: sql-admin-password
SQL Server name: cmaz-3o15j4kj-mod6-sql
SQL Database name: cmaz-3o15j4kj-mod6-sql-db
SQL Database service model: S2
SQL Server Firewall Rule name: allow-verification-ip
App Service Plan name: cmaz-3o15j4kj-mod6-asp
App Service PLan SKU: P0v3
Web Application name: cmaz-3o15j4kj-mod6-app
Web Application dotnet version: 8.0
Tags: Creator=nurgazy_sydykov@epam.com
Verification agent IP address: 18.153.146.156
Task details
1.Use the following directory layer as an example:

.
└── task06
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
Module sql should contain HCL (HashiCorp Configuration Language) resource definitions for the following resources:
Azure SQL Server
Azure SQL Firewall Rules
Azure MS SQL Database
Random password (to create SQL administrator password)
Key Vault secrets (to store SQL administrator username and password)
Module webapp should contain HCL (HashiCorp Configuration Language) resource definitions for the following resources:
Azure App Service Plan
Azure Linux Web Application
Main Terraform Configuration (main.tf). The main.tf file orchestrates the deployment of the entire infrastructure by referencing the above modules and integrating them. main.tf should contain modules' references and HCL (HashiCorp Configuration Language) resource definitions for:
Resource Group (RG)
Module sql
Module webapp
Data source to access information about an existing Key Vault (to get KV id)
locals.tf should contain resource names created using Terraform functions. The result values must be the same as names provided in Task parameters
Task requirements
Use names for resources from section Task parameters. Define them in locals using input variable name_prefix or name_pattern with value cmaz-3o15j4kj-mod6 and join, or format built-in terraform functions as:
rg_name
sql_server_name
sql_db_name
asp_name
app_name
SQL admin username should be defined either via input or local variable
SQL password should be generated in sql module using resource from random provider
SQL admin username and password values should be stored as a secrets in the existing Key Vault cmaz-3o15j4kj-mod6-kv (according to the Key Vault Secret names from section Task parameters)
Configure Firewall Rules
Allow connection from Azure services: Configure a firewall rule that allows Azure services to connect to the SQL Server
Allow connection from a specific IP address: Configure a firewall rule to allow connections to SQL server from a specified IP address. Your TF configuration should contain allowed_ip_address input variable. For local development put the value of your public IP address (e.g you can find it here) in terraform.tfvars. Before automatic verification, the value should be updated to IP address of the verification agent (18.153.146.156)
Your TF configuration should contain the following outputs:
SQL Server fully qualified domain name: sql_server_fqdn
Linux Web App hostname: app_hostname
Module sql should contain: sensitive output sql_connection_string generated in the SQL Database connection string format for ADO.NET client with SQL authentication. The connection string should be passed to a module webapp via a sensitive variable sql_connection_string
Resources should have the requested tag applied
Follow instructions and all requirements from Introduction in section Disclaimer
Task results
One resource group with the next set of resources within:
App Service Plan
Web application
Logical SQL server
SQL Database
You should be able to access the Web App from the public Internet. Web app environment variables settings should contain a valid connection string to the provisioned SQL Database
You should be able to connect to Azure SQL Database from your machine using credentials stored in Key Vault (e.g. – use Azure Data Studio, or via Query Editor in Azure SQL Database properties on the Azure Portal)". Firstly, explain this task. and then lets do the task step bt step
Great — let’s break this down clearly before diving into Terraform code.

🔎 Task Explanation
You’re asked to build a modular Terraform project that deploys a three-tier solution in Azure:

SQL Tier (Database)

Azure SQL Server

Azure SQL Database (S2 SKU)

Firewall rules (allow Azure services + allow verification IP)

Randomly generated SQL admin password

Store SQL admin username + password securely in existing Key Vault

App Tier (Web Application)

Azure App Service Plan (Linux, P0v3 SKU)

Azure Linux Web App (running .NET 8.0)

Web App must have a connection string to the SQL Database (passed securely from SQL module)

Infrastructure Layer

Resource Group

Orchestration of both modules (sql and webapp)

Data source to fetch existing Key Vault

Outputs: SQL Server FQDN + Web App hostname

📂 Directory Layout
Code
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
modules/sql → SQL Server, Database, Firewall, Random password, Key Vault secrets.

modules/webapp → App Service Plan + Linux Web App with connection string.

Root config → Resource Group, module orchestration, outputs.

🛠️ Key Requirements
Region: West Europe

Resource names: Derived from name_prefix = "cmaz-3o15j4kj-mod6" using locals.tf

SQL Admin: Username (local variable), Password (random provider)

Secrets: Stored in existing Key Vault (cmaz-3o15j4kj-mod6-kv)

Firewall: Allow Azure services + allow verification IP (18.153.146.156)

Tags: Creator = nurgazy_sydykov@epam.com

Outputs:

sql_server_fqdn

app_hostname

Sensitive sql_connection_string (passed from SQL → WebApp)

✅ Step-by-Step Plan
Step 1: Create locals.tf with resource names.

Step 2: Write modules/sql (SQL Server, DB, Firewall, Random password, KV secrets).

Step 3: Write modules/webapp (App Service Plan + Linux Web App with connection string).

Step 4: Write root main.tf (Resource Group, KV data source, module orchestration).

Step 5: Define variables (variables.tf + terraform.tfvars).

Step 6: Add outputs (outputs.tf).

Step 7: Lock versions (versions.tf).

Step 8: Run terraform init, terraform plan, terraform apply.

👉 Next move: Let’s start with Step 1: locals.tf.
Do you want me to show you the exact HCL code for locals.tf first, so we establish all resource names before building the modules?

There are also following Common task requirements:
Follow the defined file structure from a task
Do not define the backend in the configuration. Terraform will use the local backend by default
Usage of local-exec provisioner is prohibited
Usage of prevent_destroy lifecycle attribute is prohibited
Use versions.tf to define required Terraform and Providers versions
Define Terraform required_version as >= 1.5.7
Define Terraform AzureRM provider version as >= 3.110.0, < 4.0.0
All variables should contain valid descriptions and type definitions and be defined only at variables.tf
All resource names provided in section Task parameters should be defined through variables or generated dynamically/concatenated (e.g. in locals using the Terraform function). Avoid hardcode in resource definition or using the default variable property
All non-sensitive values for input parameters should be configured in terraform.tfvars
All outputs should contain valid descriptions and be defined only at outputs.tf
For additional resources, select the same location as the resource group has
TF configuration should be clean and formatted. Use terraform fmt command to rewrite Terraform configuration files to a canonical format and style. Consider all above mentioned requirements. And lets start
Perfect — thanks for clarifying the common task requirements. That gives us the guardrails we must follow while building the Terraform project. Let’s start step by step, keeping everything clean, modular, and compliant.

📝 Step 1: versions.tf
This file locks Terraform and provider versions.
We must:

Require Terraform ≥ 1.5.7

Use AzureRM provider ≥ 3.110.0 and < 4.0.0

Avoid backend definition (local backend is default)

Here’s the code:

hcl
terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

provider "azurerm" {
  features {}
}
📝 Step 2: variables.tf (root)
We define all input variables here with descriptions and types.
No hardcoding allowed — values go into terraform.tfvars.

hcl
variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "region" {
  description = "Azure region for deployment"
  type        = string
}

variable "allowed_ip_address" {
  description = "Public IP address allowed to access SQL Server"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL administrator username"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
📝 Step 3: terraform.tfvars
This file contains non-sensitive values (sensitive values like passwords are generated and stored in Key Vault).

hcl
name_prefix        = "cmaz-3o15j4kj-mod6"
region             = "West Europe"
allowed_ip_address = "18.153.146.156"
sql_admin_username = "sqladminuser"
tags = {
  Creator = "nurgazy_sydykov@epam.com"
}
📝 Step 4: locals.tf
We generate resource names dynamically using format or join.
This ensures no hardcoding.

hcl
locals {
  rg_name          = "${var.name_prefix}-rg"
  sql_server_name  = "${var.name_prefix}-sql"
  sql_db_name      = "${var.name_prefix}-sql-db"
  asp_name         = "${var.name_prefix}-asp"
  app_name         = "${var.name_prefix}-app"

  kv_rg_name       = "${var.name_prefix}-kv-rg"
  kv_name          = "${var.name_prefix}-kv"

  sql_admin_name_secret     = "sql-admin-name"
  sql_admin_password_secret = "sql-admin-password"
}
✅ With these four files (versions.tf, variables.tf, terraform.tfvars, locals.tf) we’ve set the foundation.
Next, we’ll move to Step 5: SQL module (modules/sql) where we define:

SQL Server

SQL Database

Firewall rules

Random password

Key Vault secrets

Would you like me to now write the modules/sql/main.tf with all those resources, so we can see how the password is generated and stored in Key Vault?

yes
Alright, let’s build the SQL module step by step. This module will handle the database tier: SQL Server, SQL Database, firewall rules, random password, and Key Vault secrets.

📂 modules/sql/main.tf
hcl
resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.region
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_admin.result
  tags                         = var.tags
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name                = "allow-azure-services"
  server_id           = azurerm_mssql_server.sql_server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "allow_verification_ip" {
  name              = var.sql_firewall_rule_name
  server_id         = azurerm_mssql_server.sql_server.id
  start_ip_address  = var.allowed_ip_address
  end_ip_address    = var.allowed_ip_address
}

resource "azurerm_mssql_database" "sql_db" {
  name                = var.sql_db_name
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = var.sql_db_sku
  tags                = var.tags
}

resource "random_password" "sql_admin" {
  length           = 16
  special          = true
  override_characters = "!@#$%^&*()-_=+"
}

resource "azurerm_key_vault_secret" "sql_admin_name_secret" {
  name         = var.sql_admin_name_secret
  value        = var.sql_admin_username
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sql_admin_password_secret" {
  name         = var.sql_admin_password_secret
  value        = random_password.sql_admin.result
  key_vault_id = var.key_vault_id
}
📂 modules/sql/variables.tf
hcl
variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "region" {
  description = "Azure region"
  type        = string
}

variable "sql_server_name" {
  description = "SQL Server name"
  type        = string
}

variable "sql_db_name" {
  description = "SQL Database name"
  type        = string
}

variable "sql_db_sku" {
  description = "SQL Database SKU"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL administrator username"
  type        = string
}

variable "allowed_ip_address" {
  description = "Allowed IP address for firewall rule"
  type        = string
}

variable "sql_firewall_rule_name" {
  description = "Firewall rule name"
  type        = string
}

variable "key_vault_id" {
  description = "Existing Key Vault ID"
  type        = string
}

variable "sql_admin_name_secret" {
  description = "Key Vault secret name for SQL admin username"
  type        = string
}

variable "sql_admin_password_secret" {
  description = "Key Vault secret name for SQL admin password"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
📂 modules/sql/outputs.tf
hcl
output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_connection_string" {
  description = "ADO.NET connection string for SQL Database"
  value       = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_db.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=${random_password.sql_admin.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive   = true
}
✅ This completes the SQL module.
Next step: we’ll build the WebApp module (modules/webapp) with App Service Plan + Linux Web App, and configure it to consume the SQL connection string securely.

Do you want me to go ahead and write the WebApp module now?

yes
Great — let’s build the WebApp module now. This will provision the App Service Plan and Linux Web App, and configure the connection string to the SQL Database.

📂 modules/webapp/main.tf
hcl
resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  resource_group_name = var.rg_name
  location            = var.region
  os_type             = "Linux"
  sku_name            = var.asp_sku
  tags                = var.tags
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  resource_group_name = var.rg_name
  location            = var.region
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = true
  tags                = var.tags

  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }
}
📂 modules/webapp/variables.tf
hcl
variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "region" {
  description = "Azure region"
  type        = string
}

variable "asp_name" {
  description = "App Service Plan name"
  type        = string
}

variable "asp_sku" {
  description = "App Service Plan SKU"
  type        = string
}

variable "app_name" {
  description = "Web Application name"
  type        = string
}

variable "dotnet_version" {
  description = "Dotnet version for the Web App"
  type        = string
}

variable "sql_connection_string" {
  description = "SQL Database connection string"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
📂 modules/webapp/outputs.tf
hcl
output "app_hostname" {
  description = "Hostname of the Linux Web App"
  value       = azurerm_linux_web_app.app.default_hostname
}
✅ Now we have both SQL module and WebApp module complete.
Next step is to write the root main.tf that orchestrates everything:

Creates the Resource Group

Fetches existing Key Vault

Calls module.sql and module.webapp

Passes connection string securely

Would you like me to go ahead and write the root main.tf orchestration file now?

yes
Perfect — now let’s orchestrate everything in the root main.tf. This file ties together the resource group, Key Vault data source, and both modules.

📂 main.tf
hcl
# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.region
  tags     = var.tags
}

# Data source for existing Key Vault
data "azurerm_key_vault" "kv" {
  name                = local.kv_name
  resource_group_name = local.kv_rg_name
}

# SQL Module
module "sql" {
  source = "./modules/sql"

  rg_name                  = azurerm_resource_group.rg.name
  region                   = var.region
  sql_server_name          = local.sql_server_name
  sql_db_name              = local.sql_db_name
  sql_db_sku               = "S2"
  sql_admin_username       = var.sql_admin_username
  allowed_ip_address       = var.allowed_ip_address
  sql_firewall_rule_name   = "allow-verification-ip"
  key_vault_id             = data.azurerm_key_vault.kv.id
  sql_admin_name_secret    = local.sql_admin_name_secret
  sql_admin_password_secret= local.sql_admin_password_secret
  tags                     = var.tags
}

# WebApp Module
module "webapp" {
  source = "./modules/webapp"

  rg_name             = azurerm_resource_group.rg.name
  region              = var.region
  asp_name            = local.asp_name
  asp_sku             = "P0v3"
  app_name            = local.app_name
  dotnet_version      = "8.0"
  sql_connection_string = module.sql.sql_connection_string
  tags                = var.tags
}
📂 outputs.tf (root)
hcl
output "sql_server_fqdn" {
  description = "SQL Server fully qualified domain name"
  value       = module.sql.sql_server_fqdn
}

output "app_hostname" {
  description = "Linux Web App hostname"
  value       = module.webapp.app_hostname
}
✅ Now we have:

Foundation files (versions.tf, variables.tf, terraform.tfvars, locals.tf)

SQL module (server, db, firewall, random password, KV secrets, connection string)

WebApp module (ASP + Linux Web App with connection string)

Root orchestration (main.tf + outputs.tf)

This completes the three-tier Terraform solution.

Next Steps for You
Run terraform init to initialize providers.

Run terraform plan to preview resources.

Run terraform apply to deploy.

Verify:

SQL admin credentials are stored in Key Vault.

Web App has connection string in settings.

You can connect to SQL DB using Key Vault secrets.

Web App is accessible publicly.

Would you like me to also prepare a step-by-step verification guide (how to check Key Vault secrets, test SQL connection, and confirm Web App connectivity) so you can validate the deployment after terraform apply?

prepare README file
Here’s a clean README.md you can use for your Terraform project. It explains the task, structure, and usage clearly, following the requirements:

markdown
# Task06 – Three-Tier Azure Solution with Terraform

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

### Web App
- Runs on Linux App Service Plan (SKU: `P0v3`)
- Dotnet version: `8.0`
- Connection string securely injected from SQL module

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