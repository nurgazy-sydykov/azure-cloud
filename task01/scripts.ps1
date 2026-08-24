# Step 1: Create Service Principal
az ad sp create-for-rbac \
  --name "new-sp" \
  --role Contributor \
  --scopes /subscriptions/$SUBSCRIPTION_ID

az role assignment create \
  --assignee $SP_APP_ID \
  --role "User Access Administrator" \
  --scope /subscriptions/$SUBSCRIPTION_ID

# Step 2: Set Subscription Context
az account set --subscription "nurgazy_sydykov@epam.com"

# Step 3: Resource Group + VM
RG_NAME="cmaz-3o15j4kj-mod1-rg"
LOCATION="eastasia"
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

# Step 4: Open Ports
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
