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
| Tag: Creator | `nurgazy_sydykov@epam.com` |

---

## 📁 File Structure

```
task03/
├── main.tf              # Azure resource definitions (RG, Storage, VNet, Subnets)
├── variables.tf         # Variable declarations with descriptions and types
├── terraform.tfvars     # Variable values (resource names, location, email)
├── outputs.tf           # Output definitions (RG ID, Storage endpoint, VNet ID)
├── versions.tf          # Terraform version & Azure provider requirements
└── README.md            # This file
```

### File Descriptions

| File | Purpose |
|------|---------|
| **main.tf** | Defines all Azure resources: Resource Group, Storage Account, Virtual Network, and 2 Subnets |
| **variables.tf** | Declares all input variables (rg_name, rg_location, storageaccount_name, vnet_name, subnet names, student_email) |
| **terraform.tfvars** | Provides actual values for variables (resource names, location, tags) |
| **outputs.tf** | Specifies outputs to display: RG ID, Storage blob endpoint, VNet ID |
| **versions.tf** | Sets Terraform >= 1.5.7 and Azure provider >= 3.110.0, < 4.0.0 |

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

**This will:**
- Create Resource Group
- Create Storage Account with LRS replication
- Create Virtual Network
- Create two Subnets (frontend & backend)
- Apply tag: `Creator = nurgazy_sydykov@epam.com`

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

After successful deployment, the following resources exist in Azure:

#### 1. **Resource Group**
- Location: East US
- Tag: `Creator = nurgazy_sydykov@epam.com`

#### 2. **Storage Account**
- Type: Standard LRS (Locally Redundant Storage)
- Location: East US (inherited from RG)
- Tag: `Creator = nurgazy_sydykov@epam.com`

#### 3. **Virtual Network**
- Address Space: 10.0.0.0/16
- Location: East US (inherited from RG)
- Tag: `Creator = nurgazy_sydykov@epam.com`

#### 4. **Subnets**
Two subnet resources:

**Subnet 1: Frontend**
- Address Prefix: 10.0.1.0/24
- Parent VNet: Virtual Network created above

**Subnet 2: Backend**
- Address Prefix: 10.0.2.0/24
- Parent VNet: Virtual Network created above

### Terraform Outputs

```
rg_id = "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}"
sa_blob_endpoint = "https://{storage-account-name}.blob.core.windows.net/"
vnet_id = "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Network/virtualNetworks/{vnet-name}"
```

---

**Last Updated:** August 22, 2026  
**Task Executor:** Nurgazy A. Sydykov (nurgazy_sydykov@epam.com)
