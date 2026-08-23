# Task 04 - Azure VM with Nginx (Terraform)

## Description

Terraform configuration to provision an Azure Linux Virtual Machine with a public IP and install Nginx using a remote-exec provisioner. The configuration follows the task requirements: standalone subnet and NSG rules, standalone NIC↔NSG association, password-based SSH for the provisioner, provider/version constraints, and outputs for verification.

## Project parameters

| Parameter | Value |
|---|---|
| Resource group name | cmaz-3o15j4kj-mod4-rg |
| Virtual network name | cmaz-3o15j4kj-mod4-vnet |
| Subnet name | frontend |
| Network interface name | cmaz-3o15j4kj-mod4-nic |
| Network security group name | cmaz-3o15j4kj-mod4-nsg |
| NSG inbound HTTP rule | AllowHTTP |
| NSG inbound SSH rule | AllowSSH |
| Public IP name | cmaz-3o15j4kj-mod4-pip |
| DNS name label | cmaz-3o15j4kj-mod4-nginx |
| VM name | cmaz-3o15j4kj-mod4-vm |
| VM OS Version | ubuntu-24_04-lts |
| VM SKU | Standard_B2s_v2 |
| Tags: Creator | nurgazy_sydykov@epam.com |

## Repository file structure (root view)

.
├── README.md (this file)
└── task04/
    ├── versions.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── main.tf
    └── outputs.tf

## File descriptions

| File | Purpose |
|---|---|
| versions.tf | pins Terraform required_version (>= 1.5.7) and azurerm provider version constraints (>= 3.110.0, < 4.0.0). |
| variables.tf | declares all input variables used by the configuration. `vm_password` is marked sensitive = true. |
| terraform.tfvars | provides non-sensitive variable values and (currently) the `vm_password`. Remove the password line to avoid storing credentials in the repo. |
| main.tf | defines Azure resources: Resource Group, Virtual Network, standalone Subnet, Public IP, Network Security Group, standalone NSG rules, Network Interface, NIC→NSG association (standalone), and the Linux VM. Includes a `remote-exec` provisioner to install and start Nginx. |
| outputs.tf | declares outputs `vm_public_ip` and `vm_fqdn` (with descriptions) used to verify deployment. |

## Prerequisites / Verify installation

- Terraform CLI >= 1.5.7
  - Verify: `terraform version`
- Azure CLI
  - Verify: `az version`
- An SSH client (ssh)
  - Verify: `ssh -V`
- Network: ensure your IP can reach port 22 on the VM (NSG currently allows 0.0.0.0/0 for SSH per task requirements).

## Azure CLI sign-in

```bash
az login
# (optional) set subscription
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
```

## Step-by-step deployment (copyable commands)

1) Checkout branch and change directory

```bash
git fetch origin
git checkout task04
cd task04
```

2) Initialize Terraform

```bash
terraform init
```

3) Validate configuration (optional)

```bash
terraform validate
```

4) Review plan

```bash
terraform plan -out plan.tfplan
```

5) Apply the plan

```bash
terraform apply "plan.tfplan"
# or
terraform apply
```

6) Get outputs after apply completes

```bash
terraform output vm_public_ip
terraform output vm_fqdn
```

## Deployment verification

- Nginx home page (open in a browser):
  - `http://<vm_public_ip>` or `http://<vm_fqdn>`
- SSH into VM (password auth):

```bash
ssh azureuser@<vm_public_ip>
# enter the admin password provided in terraform.tfvars
```

## Security recommendations

- Remove the admin password from `terraform.tfvars` and use interactive input or a secrets manager for sensitive values.
- Prefer SSH public key authentication (`admin_ssh_key`) over password-based authentication for the VM.
- Restrict the NSG SSH rule to your specific IP/CIDR rather than 0.0.0.0/0.

