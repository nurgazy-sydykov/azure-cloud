# Create VNet-to-VNet Connections

. "$PSScriptRoot/01-variables.ps1"

# Get existing gateway objects
$gwObj1 = Get-AzVirtualNetworkGateway -Name $gw1 -ResourceGroupName $rg1
$gwObj2 = Get-AzVirtualNetworkGateway -Name $gw2 -ResourceGroupName $rg2

# -------- Connection: Gateway 1 → Gateway 2 --------
New-AzVirtualNetworkGatewayConnection `
    -Name $conn12 `
    -ResourceGroupName $rg1 `
    -Location $region1 `
    -VirtualNetworkGateway1 $gwObj1 `
    -VirtualNetworkGateway2 $gwObj2 `
    -ConnectionType Vnet2Vnet `
    -SharedKey "5WLvmUcbJkFrT8Ny" `
    -Tag $tags

# -------- Connection: Gateway 2 → Gateway 1 --------
New-AzVirtualNetworkGatewayConnection `
    -Name $conn21 `
    -ResourceGroupName $rg2 `
    -Location $region2 `
    -VirtualNetworkGateway1 $gwObj2 `
    -VirtualNetworkGateway2 $gwObj1 `
    -ConnectionType Vnet2Vnet `
    -SharedKey "5WLvmUcbJkFrT8Ny" `
    -Tag $tags
