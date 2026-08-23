# Task 03 - Azure Infrastructure with Terraform

Deploy a complete Azure infrastructure using Terraform, including Resource Group, Storage Account, Virtual Network, and two Subnets.

**Executed by:** nurgazy_sydykov@epam.com

---

## 📋 Project Parameters

| Parameter | Value |
|-----------|-------|
| Resource Group Name | `***` |
| Storage Account Name | `***` |
| Virtual Network Name | `***` |
| VNet Address Space | `***` |
| Subnet 1 (Frontend) | `***` |
| Subnet 2 (Backend) | `***` |
| Location | `***` |
| Tag: Creator | `***` |

---

## 📁 File Structure

```
task03/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── versions.tf
└── README.md
```

### File Descriptions

| File | Purpose |
|------|---------|
| **main.tf** | Contains all Azure resource definitions including Resource Group, Storage Account with Standard LRS configuration, Virtual Network with specified address space, and two Subnets (frontend and backend) with their respective address prefixes. All resources are configured with tags for tracking and management. |
| **variables.tf** | Defines all input variables required for the infrastructure deployment. Each variable includes a description and type definition. Variables declared: rg_name, rg_location, storageaccount_name, vnet_name, subnet1_name, subnet2_name, and student_email. No default values are set, requiring explicit values in terraform.tfvars. |
| **terraform.tfvars** | Provides the actual values for all variables defined in variables.tf. Contains the specific resource names, Azure region location, and student email for tagging purposes. This file should be customized with your own values before deployment. |
| **outputs.tf** | Defines output values that will be displayed after successful deployment. Includes Resource Group ID, Storage Account blob service primary endpoint URL, and Virtual Network ID. Each output includes a description for clarity. |
| **versions.tf** | Specifies Terraform version requirements (>= 1.5.7) and Azure provider version constraints (>= 3.110.0, < 4.0.0). Contains Azure provider configuration block. Ensures compatibility and predictable behavior across different environments. |

---

## 🚀 Prerequisites

Install the following tools:

- **Azure CLI** - [Install here](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- **Terraform** - [Install here](https://www.terraform.io/)
- **Git** - [Install here](https://git-scm.com/)

Verify installations:

```bash
az version
terraform version
git --version
```

---

## 🔑 Azure CLI Sign In

Before deploying, authenticate with Azure:

```bash
# Login to Azure (opens browser)
az login

# Verify you're logged in and see your subscription
az account show

# List all subscriptions (if you have multiple)
az account list

# Set active subscription (if needed)
az account set --subscription "<subscription-id>"
```

---

## 📝 Step-by-Step Deployment

### Step 1: Navigate to Task Directory

```bash
cd task03
```

### Step 2: Initialize Terraform

Downloads Azure provider and prepares working directory:

```bash
terraform init
```

### Step 3: Validate Configuration

Checks syntax and configuration correctness:

```bash
terraform validate
```

### Step 4: Format Check (Optional)

Ensures code follows Terraform standards:

```bash
terraform fmt -check
```

### Step 5: Plan Deployment

Preview all changes before applying:

```bash
terraform plan -out=tfplan
```

**Output shows:**
- Resources to be created
- Resource properties
- Tags to be applied

### Step 6: Apply Configuration

Create actual Azure resources:

```bash
terraform apply tfplan
```

### Step 7: View Outputs

Display deployment results:

```bash
terraform output
```

**Expected outputs:**
- `rg_id` - Resource Group ID
- `sa_blob_endpoint` - Storage Account blob service URL
- `vnet_id` - Virtual Network ID

---

## 🗑️ Destroy Resources

Remove all Azure resources created by Terraform:

```bash
terraform destroy
```

**Confirmation:** Type `yes` when prompted to confirm deletion

All resources in the resource group will be deleted:
- ✅ Storage Account deleted
- ✅ Virtual Network deleted
- ✅ Subnets deleted
- ✅ Resource Group deleted

---

## 📊 Deployment Results

### Resources Created

| Resource Type | Name | Details |
|---|---|---|
| **Resource Group** | `***` | Location: `***`, Tag: Creator = `***` |
| **Storage Account** | `***` | Type: Standard LRS, Location: `***` (inherited from RG), Tag: Creator = `***` |
| **Virtual Network** | `***` | Address Space: `***`, Location: `***` (inherited from RG), Tag: Creator = `***` |
| **Subnet 1** | `***` | Address Prefix: `***`, Parent VNet: `***` |
| **Subnet 2** | `***` | Address Prefix: `***`, Parent VNet: `***` |

### Terraform Outputs

| Output | Value |
|---|---|
| `rg_id` | `***` |
| `sa_blob_endpoint` | `***` |
| `vnet_id` | `***` |

---

**Last Updated:** 2026-08-23  
**Task Executor:** Nurgazy A. Sydykov (nurgazy_sydykov@epam.com)
