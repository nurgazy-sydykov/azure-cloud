# Create VNets (frontend + gateway subnets + tags)

. "$PSScriptRoot/01-variables.ps1"

# -------- VNet 1 --------

# Create frontend subnet config
$subnetConfig1_frontend = New-AzVirtualNetworkSubnetConfig `
    -Name $frontendSubnet1 `
    -AddressPrefix $frontendPrefix1

# Create gateway subnet config
$subnetConfig1_gateway = New-AzVirtualNetworkSubnetConfig `
    -Name $gatewaySubnet `
    -AddressPrefix $gwPrefix1

# Create VNet 1
$vnetObj1 = New-AzVirtualNetwork `
    -Name $vnet1 `
    -ResourceGroupName $rg1 `
    -Location $region1 `
    -AddressPrefix $addr1 `
    -Subnet $subnetConfig1_frontend, $subnetConfig1_gateway

# Apply tag to VNet 1
Set-AzResource `
    -ResourceGroupName $rg1 `
    -ResourceType "Microsoft.Network/virtualNetworks" `
    -Name $vnet1 `
    -Tag $tags `
    -Force

# -------- VNet 2 --------

# Create frontend subnet config
$subnetConfig2_frontend = New-AzVirtualNetworkSubnetConfig `
    -Name $frontendSubnet2 `
    -AddressPrefix $frontendPrefix2

# Create gateway subnet config
$subnetConfig2_gateway = New-AzVirtualNetworkSubnetConfig `
    -Name $gatewaySubnet `
    -AddressPrefix $gwPrefix2

# Create VNet 2
$vnetObj2 = New-AzVirtualNetwork `
    -Name $vnet2 `
    -ResourceGroupName $rg2 `
    -Location $region2 `
    -AddressPrefix $addr2 `
    -Subnet $subnetConfig2_frontend, $subnetConfig2_gateway

# Apply tag to VNet 2
Set-AzResource `
    -ResourceGroupName $rg2 `
    -ResourceType "Microsoft.Network/virtualNetworks" `
    -Name $vnet2 `
    -Tag $tags `
    -Force
