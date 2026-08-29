# Task 05 – Highly Available Azure Web Apps with Traffic Manager

## 📌 Overview
This project demonstrates how to build a **highly available solution** on Azure using Terraform.  
It provisions:
- **Three Resource Groups** in different regions
- **Two App Service Plans** (Standard S1 tier)
- **Two Windows Web Apps** hosted in separate regions
- **One Azure Traffic Manager Profile** to route traffic between the two Web Apps using the **Performance routing method**

The solution ensures high availability by distributing traffic across multiple regions and restricting access to only trusted sources.

---

## 🗂️ Directory Structure

```
task05/
├── modules/
│   ├── app_service/          # Windows Web App module
│   ├── app_service_plan/     # App Service Plan module
│   ├── resource_group/       # Resource Group module
│   └── traffic_manager/      # Traffic Manager module
├── main.tf                   # Root orchestration
├── outputs.tf                # Root outputs
├── terraform.tfvars          # Variable values
├── variables.tf              # Variable definitions
└── versions.tf               # Terraform & provider versions
```

---

## ⚙️ Modules

### Resource Group (`modules/resource_group`)
- Deploys an Azure Resource Group
- Accepts `name`, `location`, and `tags`

### App Service Plan (`modules/app_service_plan`)
- Deploys an Azure App Service Plan
- Configurable SKU and worker count
- Linked to a Resource Group

### App Service (`modules/app_service`)
- Deploys a Windows Web App
- Configured with **IP restrictions**:
  - Allow traffic from **Traffic Manager service tag**
  - Allow traffic from **verification agent IP (18.153.146.156)**
  - Deny all other traffic by default

### Traffic Manager (`modules/traffic_manager`)
- Deploys a Traffic Manager Profile
- Routing method: **Performance**
- Endpoints created dynamically via `for_each` from App Services

---

## 📑 Variables
Defined in `variables.tf`:

- **Resource Groups**: `map(object({ name, location }))`
- **App Service Plans**: `map(object({ name, sku, worker_count, rg_key }))`
- **App Services**: `map(object({ name, rg_key, asp_key }))`
- **Traffic Manager**: `object({ name, routing_method })`

Values are provided in `terraform.tfvars`.

---

## 🏗️ Deployment Flow
1. **RG1** → App Service Plan 1 → Windows Web App 1  
2. **RG2** → App Service Plan 2 → Windows Web App 2  
3. **RG3** → Traffic Manager Profile with endpoints pointing to Web App 1 and Web App 2  

All resources are tagged with:
Creator = [***user tag***]

---

## 📤 Outputs
After deployment, Terraform will output:
- **Traffic Manager FQDN** → `traffic_manager_fqdn`

This FQDN can be used to access the highly available web solution.

---

## 🚀 Usage
```bash
# Initialize Terraform (downloads providers, sets up backend)
terraform init

# Format code (ensures all .tf files are clean and consistent)
terraform fmt

# Validate Terraform code (checks syntax and configuration correctness)
terraform validate

# Review the plan (shows what resources will be created/changed/destroyed)
terraform plan

# Apply the configuration (actually provisions resources in Azure)
terraform apply

# Destroy Terraform-managed resources (tears down everything created)
terraform destroy
```

---

## 📖 Architecture Diagram
```mermaid
graph TD
    subgraph RG1[Resource Group 1 - West Europe]
        ASP1[App Service Plan 1 (S1, 2 workers)]
        APP1[Windows Web App 1]
        ASP1 --> APP1
    end

    subgraph RG2[Resource Group 2 - North Europe]
        ASP2[App Service Plan 2 (S1, 1 worker)]
        APP2[Windows Web App 2]
        ASP2 --> APP2
    end

    subgraph RG3[Resource Group 3 - East US]
        TM[Traffic Manager Profile (Performance Routing)]
    end

    TM --> APP1
    TM --> APP2
```
---
