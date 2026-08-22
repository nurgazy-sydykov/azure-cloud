# Task 021 — Implementing and managing Azure Virtual Network

Short description
---------------
Create two VNets and establish a VNet-to-VNet VPN gateway connection (NOT peering) using Az PowerShell.

Useful links
------------
1. Introducing the Az PowerShell module: https://docs.microsoft.com/en-us/powershell/azure/new-azureps-module-az
2. Configure a VNet-to-VNet VPN gateway connection using PowerShell: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-vnet-vnet-rm-ps
3. Configure a VNet-to-VNet VPN gateway connection using Azure CLI: https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-vnet-vnet-cli
4. Paired region: https://learn.microsoft.com/en-us/azure/reliability/cross-region-replication-azure#azure-paired-regions

Task parameters
---------------
| Parameter | Variable |
| Region 1 | $region1 |
| Resource group 1 name | $rg1 |
| Virtual network 1 name | $vnet1 |
| Virtual network 1 address prefix | $addr1 |
| Subnet 1 name | $frontendSubnet1 |
| Subnet 1 address prefix | $frontendPrefix1 |
| VPN Gateway 1 name | $gw1 |
| VPN Gateway 1 public IP name | $pip1 |
| VPN Gateway 1 subnet address prefix | $gwPrefix1 |
| VPN Gateway 1-2 connection name | $conn12 |
| Region 2 | $region2 |
| Resource group 2 name | $rg2 |
| Virtual network 2 name | $vnet2 |
| Virtual network 2 address prefix | $addr2 |
| Subnet 2 name | $frontendSubnet2 |
| Subnet 2 address prefix | $frontendPrefix2 |
| VPN Gateway 2 name | $gw2 |
| VPN Gateway 2 public IP name | $pip2 |
| VPN Gateway 2 subnet address prefix | $gwPrefix2 |
| VPN Gateway 2-1 connection name | $conn21 |
| Tags | $tags |

Files structure
---------------
- task021/
  - 01-variables.ps1
  - 02-resource-groups.ps1
  - 03-vnets.ps1
  - 04-publicips-gateways.ps1
  - 05-connections.ps1
  - README.md

Execution (compact)
-------------------
1. Authenticate to Azure and select subscription: Connect-AzAccount; Set-AzContext -Subscription $subId
2. From repo root run (in order):
   - pwsh ./task021/02-resource-groups.ps1
   - pwsh ./task021/03-vnets.ps1
   - pwsh ./task021/04-publicips-gateways.ps1
   - pwsh ./task021/05-connections.ps1

Notes
-----
- Do NOT use the Azure Portal; use Az PowerShell or Azure CLI only.
- Scripts dot-source 01-variables.ps1 so they can be run separately.
