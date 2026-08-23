# Create Public IPs + VPN Gateways

. "$PSScriptRoot/01-variables.ps1"

# -------- Public IP 1 --------
$pipObj1 = New-AzPublicIpAddress `
    -Name $pip1 `
    -ResourceGroupName $rg1 `
    -Location $region1 `
    -AllocationMethod Static `
    -Sku Standard `
    -Zone 1,2,3 `
    -Tag $tags

# -------- Public IP 2 --------
$pipObj2 = New-AzPublicIpAddress `
    -Name $pip2 `
    -ResourceGroupName $rg2 `
    -Location $region2 `
    -AllocationMethod Static `
    -Sku Standard `
    -Zone 1,2,3 `
    -Tag $tags

# -------- VPN Gateway 1 --------

# Get GatewaySubnet reference
$gwSubnet1Obj = (Get-AzVirtualNetworkSubnetConfig `
    -Name $gatewaySubnet `
    -VirtualNetwork (Get-AzVirtualNetwork -Name $vnet1 -ResourceGroupName $rg1))

# Create IP configuration for Gateway 1
$gwIpConfig1 = New-AzVirtualNetworkGatewayIpConfig `
    -Name "gw-ipconfig-01" `
    -SubnetId $gwSubnet1Obj.Id `
    -PublicIpAddressId $pipObj1.Id

# Create VPN Gateway 1
$gwObj1 = New-AzVirtualNetworkGateway `
    -Name $gw1 `
    -ResourceGroupName $rg1 `
    -Location $region1 `
    -IpConfigurations $gwIpConfig1 `
    -GatewayType Vpn `
    -VpnType RouteBased `
    -GatewaySku VpnGw1AZ `
    -Tag $tags

# -------- VPN Gateway 2 --------

# Get GatewaySubnet reference
$gwSubnet2Obj = (Get-AzVirtualNetworkSubnetConfig `
    -Name $gatewaySubnet `
    -VirtualNetwork (Get-AzVirtualNetwork -Name $vnet2 -ResourceGroupName $rg2))

# Create IP configuration for Gateway 2
$gwIpConfig2 = New-AzVirtualNetworkGatewayIpConfig `
    -Name "gw-ipconfig-02" `
    -SubnetId $gwSubnet2Obj.Id `
    -PublicIpAddressId $pipObj2.Id

# Create VPN Gateway 2
$gwObj2 = New-AzVirtualNetworkGateway `
    -Name $gw2 `
    -ResourceGroupName $rg2 `
    -Location $region2 `
    -IpConfigurations $gwIpConfig2 `
    -GatewayType Vpn `
    -VpnType RouteBased `
    -GatewaySku VpnGw1AZ `
    -Tag $tags
