Task Description
Activate your Azure subscription using the Visual Studio Professional benefit, provision a Windows Server 2022 Virtual Machine via Azure Portal, and configure a custom IIS web server setup with required roles and a test .aspx page.

Task Parameters
Parameter	Value
Subscription name	nurgazy_sydykov@epam.com
Resource group name	cmaz-3o15j4kj-mod1-rg
VM name	cmaz-3o15j4kj-mod1-vm
VM size	Appropriate size per Windows Server requirements
Region	Least expensive region (via MS Pricing Calculator)
VM DNS name label	cmaz3o15j4kjmod1vm
Tags	Creator=nurgazy_sydykov@epam.com


Task Details (Step-by-Step)
Activate Subscription

Go to MSDN benefits page.

Activate Azure monthly credits.

Select Visual Studio Professional subscription.

Rename subscription to nurgazy_sydykov@epam.com.

Create Service Principal

bash
az ad sp create-for-rbac \
  --name "new-sp" \
  --role Contributor \
  --scopes /subscriptions/$SUBSCRIPTION_ID

az role assignment create \
  --assignee $SP_APP_ID \
  --role "User Access Administrator" \
  --scope /subscriptions/$SUBSCRIPTION_ID
Set Subscription Context

bash
az account set --subscription "nurgazy_sydykov@epam.com"
Provision VM

bash
RG_NAME="cmaz-3o15j4kj-mod1-rg"
LOCATION="eastasia"   # Example least expensive region
VM_NAME="cmaz-3o15j4kj-mod1-vm"
ADMIN_USER="azureadmin"

az group create \
  --name $RG_NAME \
  --location $LOCATION

az vm create \
  --resource-group $RG_NAME \
  --name $VM_NAME \
  --image Win2022AzureEdition \
  --admin-username $ADMIN_USER \
  --public-ip-sku Standard \
  --tags Creator="nurgazy_sydykov@epam.com"
Open Required Ports

bash
az vm open-port \
  --resource-group $RG_NAME \
  --name $VM_NAME \
  --port 3389 \
  --priority 1000

az vm open-port \
  --resource-group $RG_NAME \
  --name $VM_NAME \
  --port 80 \
  --priority 1001
Configure IIS on VM

Connect via RDP.

Install IIS Web Server role.

Add features:

.NET Extensibility 4.8

ISAPI Extensions

ISAPI Filters

ASP.NET 4.8

Create Custom Page
Save the following file as C:\inetpub\wwwroot\server.aspx:

html
<html> 
  <body>
    <p>
      <b>The current server:</b>
      <%Response.Write(My.Computer.Name.ToString())%>
    </p> 
  </body>
</html>