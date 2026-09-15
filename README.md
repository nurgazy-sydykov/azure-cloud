# Task 08 — Cloud-Native and Containerized Applications on Azure

## 📌 Overview
This project provisions a full cloud-native application environment on **Microsoft Azure** using **Terraform**.  
It builds and deploys a containerized Python application to both **Azure Container Instance (ACI)** and **Azure Kubernetes Service (AKS)**, with secrets stored in **Azure Key Vault** and caching handled by **Azure Redis Cache**.  
The application connects securely to Redis via SSL and demonstrates connectivity by incrementing a counter on page refresh.

---

## 🏗️ Infrastructure Components
- **Resource Group** — Central container for all resources.
- **Azure Container Registry (ACR)**  
  - Stores Docker images.  
  - Includes a Task to build the image from source code using a Git PAT.  
  - Scheduled builds via Task Schedule.
- **Azure Key Vault**  
  - Stores Redis hostname and primary key as secrets.  
  - Access policies for current user and AKS.
- **Azure Redis Cache**  
  - Basic C SKU, capacity 2.  
  - Secrets automatically pushed to Key Vault.
- **Azure Kubernetes Service (AKS)**  
  - Managed cluster with CSI driver enabled.  
  - Role assignment for pulling images from ACR.  
  - Key Vault access policy for secrets.
- **Azure Container Instance (ACI)**  
  - Runs the app container with environment variables and secure secrets.  
  - Public IP and DNS FQDN for external access.
- **Kubernetes Manifests**  
  - Deployment, Service, and SecretProviderClass applied via `kubectl` provider.  
  - Wait-for blocks ensure resources are healthy before Terraform completes.

---

## 📂 Project Structure

```bash
task08/
├── application/
│   ├── Dockerfile
│   ├── app.py
│   └── requirements.txt
├── k8s-manifests/
│   ├── deployment.yaml.tftpl
│   ├── secret-provider.yaml.tftpl
│   └── service.yaml
├── modules/
│   ├── aci/
│   ├── acr/
│   ├── aks/
│   ├── keyvault/
│   └── redis/
├── locals.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars
├── variables.tf
└── versions.tf
```

---

## ⚙️ Configuration
### Variables
Defined in `variables.tf`:
- `name_prefix` — Base prefix for resource names (e.g. `cmtr-3o15j4kj-mod8`).
- `location` — Azure region.
- `tags` — Common tags applied to resources.
- `git_pat` — Sensitive Git Personal Access Token for ACR Task.

### Locals
Derived names in `locals.tf`:
- `rg_name`, `aci_name`, `acr_name`, `aks_name`, `keyvault_name`, `redis_name`.

### Outputs
Defined in `outputs.tf`:
- `aci_fqdn` — FQDN of app in ACI.
- `aks_lb_ip` — LoadBalancer IP of app in AKS.

---

## 🚀 Deployment Steps

### 1. Initialize Terraform:
```bash
terraform init
```
### 2. Validate configuration:
```bash
terraform validate
```
### 3. Plan deployment:
```bash
terraform plan
```
Enter your Git PAT when prompted for git_pat.
### 4. Apply configuration:
```bash
terraform apply
```
Deployment may take up to 30 minutes.

---

## ✅ Verification

- ACI App: Accessible via FQDN output (`aci_fqdn`).
Displays: `Hello from ACI`.
- AKS App: Accessible via LoadBalancer IP (`aks_lb_ip`).
Displays: `Hello from K8S`.
- Redis Connectivity: Refreshing either page increments the visit counter, proving successful Redis integration.

---

## 📌 Notes
- All resources are tagged with `Creator=nurgazy_sydykov@epam.com`.
- Secrets are stored securely in `Key Vault`.
- Redis communicates only via SSL port `6380`.
- No backend is defined — Terraform uses local backend by default.
- `local-exec` provisioners and `prevent_destroy` lifecycle attributes are prohibited.
- Run `terraform fmt` before committing to ensure clean formatting.