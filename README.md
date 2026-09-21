# Task 08.2 — Azure Container Applications and AKS

This task deploys the same Redis-connected Flask application to Azure
Container Apps (ACA) and Azure Kubernetes Service (AKS).

## Architecture

```mermaid
flowchart TB
    source[Application source<br/>Flask + Redis client]
    archive[archive_file<br/>application.tar.gz]
    storage[(Azure Storage Account<br/>app-content container)]
    acr[(Azure Container Registry)]
    acrTask[ACR Task<br/>build and push image]
    image[Container image<br/>cmtr-3o15j4kj-mod8b-app:latest]

    rg[Resource Group<br/>cmtr-3o15j4kj-mod8b-rg]
    redis[Azure Container Instance<br/>Redis 6379]
    redisIp[Redis public IP / FQDN]
    kv[(Azure Key Vault)]
    redisSecrets[redis-password<br/>redis-hostname]

    acaEnv[Azure Container App Environment]
    aca[Azure Container App<br/>Hello from ACA]
    aks[Azure Kubernetes Service]
    csi[Secrets Store CSI Driver]
    k8s[Kubernetes Deployment + LoadBalancer Service<br/>Hello from K8S]

    source --> archive
    archive --> storage
    storage -->|Blob URL + SAS token| acrTask
    acrTask --> acr
    acr --> image

    rg --> storage
    rg --> redis
    rg --> acr
    rg --> kv
    rg --> acaEnv
    rg --> aks

    redis --> redisIp
    redis -->|hostname and generated password| redisSecrets
    redisSecrets --> kv

    image --> aca
    image --> k8s
    kv -->|Managed identity secret references| aca
    kv --> csi
    csi --> k8s
    redisIp -->|REDIS_URL:6379| aca
    redisIp -->|REDIS_URL:6379| k8s
    acaEnv --> aca
    aks --> csi
    aks --> k8s
```

## Components

- **Storage Account** archives the `application` directory as a `tar.gz` blob.
- **ACR Task** uses the blob URL and SAS token as its build context, then
  pushes the application image to Azure Container Registry.
- **Redis ACI** runs the Redis image from Microsoft Artifact Registry with a
  generated password and exposes port `6379` through a public IP and DNS name.
- **Key Vault** stores the Redis hostname and password.
- **ACA** uses a user-assigned managed identity to read Key Vault secrets and
  pull the application image from ACR.
- **AKS** uses a managed identity, the Secrets Store CSI Driver, and Kubernetes
  manifests to read Key Vault secrets and pull the application image from ACR.
- **Kubernetes Service** exposes the AKS application through a public
  load-balancer IP.

## Terraform layout

```text
task08_b/
├── application/
├── k8s-manifests/
├── modules/
│   ├── aca/
│   ├── aci_redis/
│   ├── acr/
│   ├── aks/
│   ├── k8s/
│   ├── keyvault/
│   └── storage/
├── locals.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars
├── variables.tf
└── versions.tf
```

## Outputs

After applying the configuration, Terraform exposes:

- `redis_fqdn` — Redis ACI DNS name.
- `aca_fqdn` — ACA application DNS name.
- `aks_lb_ip` — public IP address of the AKS application.

## Deployment

From the `task08_b` directory:

```powershell
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
```

