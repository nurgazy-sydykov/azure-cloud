# Task 2.1 — Implementing and managing Azure Virtual Network

Short description
---------------
Create two VNets and establish a VNet-to-VNet VPN gateway connection (NOT peering) using Az PowerShell.

Useful links
------------
1. Introducing the Az PowerShell module: https://docs.microsoft.com/en-us/powershell/azure/new-azureps-module-az
2. Configure a VNet-to-VNet VPN gateway connection using PowerShell: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-vnet-vnet-rm-ps
3. Configure a VNet-to-VNet VPN gateway connection using Azure CLI: https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-vnet-vnet-cli
4. Paired region: https://learn.microsoft.com/en-us/azure/reliability/cross-region-replication-azure#azure-paired-regions

Task parameters (grouped)
-------------------------
| Category | Parameter | Variable |
|---|---:|---|
| Regions | Primary region | $region1 |
| Regions | Paired/secondary region | $region2 |
| Resource Groups | Resource group (VNet1) | $rg1 |
| Resource Groups | Resource group (VNet2) | $rg2 |
| Virtual Networks | VNet 1 name | $vnet1 |
| Virtual Networks | VNet 1 address prefix | $addr1 |
| Virtual Networks | VNet 2 name | $vnet2 |
| Virtual Networks | VNet 2 address prefix | $addr2 |
| Subnets | Frontend subnet (VNet1) name | $frontendSubnet1 |
| Subnets | Frontend subnet (VNet1) prefix | $frontendPrefix1 |
| Subnets | Frontend subnet (VNet2) name | $frontendSubnet2 |
| Subnets | Frontend subnet (VNet2) prefix | $frontendPrefix2 |
| Subnets | Gateway subnet name (both VNets) | $gatewaySubnet |
| Subnets | Gateway subnet prefix (VNet1) | $gwPrefix1 |
| Subnets | Gateway subnet prefix (VNet2) | $gwPrefix2 |
| VPN Gateways | VPN Gateway 1 name | $gw1 |
| VPN Gateways | VPN Gateway 2 name | $gw2 |
| Public IPs | VPN Gateway 1 public IP name | $pip1 |
| Public IPs | VPN Gateway 2 public IP name | $pip2 |
| Connections | Connection: Gateway1 → Gateway2 | $conn12 |
| Connections | Connection: Gateway2 → Gateway1 | $conn21 |
| Tags | Mandatory tag object | $tags |

Files structure
---------------

task021/
  ├─ 01-variables.ps1        # all variables
  ├─ 02-resource-groups.ps1  # create resource groups
  ├─ 03-vnets.ps1            # create VNets + subnets and tag VNets
  ├─ 04-publicips-gateways.ps1 # public IPs + create VPN gateways
  ├─ 05-connections.ps1      # create VNet-to-VNet connections
  └─ README.md               # task doc (this file)

Execution (compact)
-------------------
1. Authenticate to Azure and select subscription:
   - Connect-AzAccount
   - Set-AzContext -Subscription $subId
2. Run scripts in order from repo root:
   - pwsh ./task021/02-resource-groups.ps1
   - pwsh ./task021/03-vnets.ps1
   - pwsh ./task021/04-publicips-gateways.ps1
   - pwsh ./task021/05-connections.ps1
