# Azure Windows Server 2022 — IIS Web Server Setup

## 1. Overview

This project provisions a Windows Server 2022 Virtual Machine in Microsoft Azure and configures it as a custom IIS web server.

The following tasks are completed:

- Azure subscription activation using Visual Studio Professional benefits
- Azure subscription configuration
- Service Principal creation
- Resource Group creation
- Windows Server 2022 Virtual Machine deployment
- Network configuration for RDP and HTTP
- IIS Web Server installation
- ASP.NET 4.8 configuration
- Custom `.aspx` test page creation
- Web server validation

---

## 2. Task Parameters

| Parameter | Value |
|---|---|
| Subscription | `nurgazy_sydykov@epam.com` |
| Resource Group | `cmaz-3o15j4kj-mod1-rg` |
| Virtual Machine | `cmaz-3o15j4kj-mod1-vm` |
| Operating System | Windows Server 2022 |
| VM Size | Appropriate size according to requirements |
| Region | Selected based on Microsoft Azure Pricing Calculator |
| DNS Name Label | `cmaz3o15j4kjmod1vm` |
| Administrator | `azureadmin` |
| Tag | `Creator=nurgazy_sydykov@epam.com` |

---

## 3. Prerequisites

The following requirements are needed:

- Active Microsoft account
- Visual Studio Professional subscription/benefit
- Active Azure monthly credits
- Azure Portal access
- Azure CLI
- RDP client
- Windows Server 2022 VM

---

## 4. Activate Azure Subscription

1. Open the Microsoft Visual Studio subscription benefits page.
2. Locate the Azure monthly credits benefit.
3. Activate the Azure subscription using the Visual Studio Professional benefit.
4. Rename the subscription to:

```text
nurgazy_sydykov@epam.com
```

5. Verify that the subscription is active.

---

## 5. Create Service Principal

Set the subscription ID:

```bash
SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
```

Create a Service Principal with Contributor permissions:

```bash
az ad sp create-for-rbac \
  --name "new-sp" \
  --role Contributor \
  --scopes /subscriptions/$SUBSCRIPTION_ID
```

Grant User Access Administrator permissions:

```bash
az role assignment create \
  --assignee $SP_APP_ID \
  --role "User Access Administrator" \
  --scope /subscriptions/$SUBSCRIPTION_ID
```

> The Service Principal credentials should be stored securely and must not be committed to the repository.

---

## 6. Set Azure Subscription Context

Select the required subscription:

```bash
az account set --subscription "nurgazy_sydykov@epam.com"
```

Verify the active subscription:

```bash
az account show
```

---

## 7. Create Resource Group

Define the required variables:

```bash
RG_NAME="cmaz-3o15j4kj-mod1-rg"
LOCATION="<SELECTED_REGION>"
VM_NAME="cmaz-3o15j4kj-mod1-vm"
ADMIN_USER="azureadmin"
```

Create the Resource Group:

```bash
az group create \
  --name $RG_NAME \
  --location $LOCATION
```

---

## 8. Provision Windows Server 2022 VM

Create the Virtual Machine:

```bash
az vm create \
  --resource-group $RG_NAME \
  --name $VM_NAME \
  --image Win2022AzureEdition \
  --admin-username $ADMIN_USER \
  --public-ip-sku Standard \
  --tags Creator="nurgazy_sydykov@epam.com"
```

The VM must use Windows Server 2022 and an Azure VM size appropriate for the task requirements.

---

## 9. Configure Network Ports

Open RDP port 3389:

```bash
az vm open-port \
  --resource-group $RG_NAME \
  --name $VM_NAME \
  --port 3389 \
  --priority 1000
```

Open HTTP port 80:

```bash
az vm open-port \
  --resource-group $RG_NAME \
  --name $VM_NAME \
  --port 80 \
  --priority 1001
```

Port usage:

| Port | Protocol | Purpose |
|---|---|---|
| 3389 | TCP | Remote Desktop |
| 80 | TCP | HTTP / IIS |

---

## 10. Connect to the Virtual Machine

1. Open Azure Portal.
2. Navigate to the Virtual Machine.
3. Select **Connect → RDP**.
4. Download the RDP file.
5. Connect using the configured administrator account:

```text
Username: azureadmin
```

The administrator password is the password specified during VM creation.

---

## 11. Install IIS

Open **Server Manager** inside the Windows Server VM.

Navigate to:

**Manage → Add Roles and Features**

Select:

**Role-based or feature-based installation**

Select the local server and install:

**Web Server (IIS)**

Required IIS components:

- Web Server
- Common HTTP Features
- Application Development
- .NET Extensibility 4.8
- ASP.NET 4.8
- ISAPI Extensions
- ISAPI Filters

Complete the installation and restart the server if required.

---

## 12. Verify IIS Installation

Open a web browser inside the VM and navigate to:

```text
http://localhost
```

The default IIS welcome page should be displayed.

IIS can also be verified using PowerShell:

```powershell
Get-WindowsFeature Web-Server
```

The IIS Web Server role should have the status:

```text
Installed
```

---

## 13. Create Custom ASP.NET Page

Create the following file:

```text
C:\inetpub\wwwroot\server.aspx
```

Use the following content:

```aspx
<html>
  <body>
    <p>
      <b>The current server:</b>
      <%Response.Write(My.Computer.Name.ToString())%>
    </p>
  </body>
</html>
```

The page uses ASP.NET server-side processing to display the current Windows Server computer name.

---

## 14. Configure IIS for ASP.NET

Open **IIS Manager**.

Navigate to:

**Sites → Default Web Site**

Verify that ASP.NET 4.8 and the required application development components are installed.

Verify that the application pool is configured to support ASP.NET 4.8.

If required, restart IIS:

```cmd
iisreset
```

---

## 15. Test the Custom Web Page

From the VM, open:

```text
http://localhost/server.aspx
```

The page should display:

```text
The current server: <SERVER_NAME>
```

The server name should correspond to the Windows Server VM hostname.

From an external machine, use the VM public IP:

```text
http://<PUBLIC_IP>/server.aspx
```

If DNS has been configured using the required DNS label, the page can also be accessed using the corresponding Azure DNS hostname.

---

## 16. Validation Checklist

- [ ] Azure Visual Studio Professional benefit activated
- [ ] Azure subscription renamed correctly
- [ ] Service Principal created
- [ ] Contributor role assigned
- [ ] User Access Administrator role assigned
- [ ] Correct subscription selected
- [ ] Resource Group created
- [ ] Windows Server 2022 VM created
- [ ] Required VM tag configured
- [ ] RDP port 3389 opened
- [ ] HTTP port 80 opened
- [ ] RDP connection verified
- [ ] IIS Web Server installed
- [ ] .NET Extensibility 4.8 installed
- [ ] ASP.NET 4.8 installed
- [ ] ISAPI Extensions installed
- [ ] ISAPI Filters installed
- [ ] `server.aspx` created
- [ ] IIS restarted
- [ ] `http://localhost/server.aspx` tested
- [ ] External HTTP access tested

---

## 17. Expected Result

The final Azure environment should contain:

```text
Azure Subscription
└── Resource Group
    └── cmaz-3o15j4kj-mod1-rg
        └── Windows Server 2022 VM
            └── cmaz-3o15j4kj-mod1-vm
                └── IIS Web Server
                    └── server.aspx
```

The custom ASP.NET page must be accessible through IIS and display the current Windows Server hostname.

---

## 18. Security Considerations

- Do not commit Service Principal credentials to source control.
- Do not store administrator passwords in the README.
- Use strong credentials for the VM administrator account.
- RDP port 3389 should preferably be restricted to trusted source IP addresses.
- Remove unnecessary Azure resources after completing the task if they are no longer required to avoid unnecessary Azure credit consumption.

---

## 19. Completion Criteria

The task is considered complete when the Windows Server 2022 VM is running in the specified Resource Group, IIS is configured with the required ASP.NET components, and the custom `server.aspx` page successfully responds through HTTP and displays the server name.