# Task 04 - Azure VM with Nginx (Terraform)

This directory contains Terraform configuration to create an Azure Linux Virtual Machine with a public IP and install Nginx using a remote-exec provisioner.

Files created in task04/
- versions.tf     - provider and terraform version constraints
- variables.tf    - all input variables (types and descriptions)
- terraform.tfvars - non-sensitive input values and the admin password (sensitive)
- main.tf         - resource definitions
- outputs.tf      - outputs (vm_public_ip and vm_fqdn)

How to use
1. Authenticate to Azure (for example `az login`).
2. Switch to this branch and directory:
   git checkout task04
   cd task04
3. Initialize Terraform:
   terraform init
4. Validate and plan:
   terraform plan
5. Apply:
   terraform apply

Notes
- The file terraform.tfvars in this commit contains the admin password as requested. If you prefer not to store the password in the repo, remove it and enter it interactively when running `terraform apply`.
- Ensure the `domain_name_label` in terraform.tfvars is unique across Azure (it forms part of the public IP FQDN).
- This configuration intentionally does not configure a remote backend (per task requirement).
