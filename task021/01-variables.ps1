# Variables for VNet-to-VNet VPN Script

# Subscription
$subId = "8da553a7-8f4c-48a2-8701-dafce0b7b79b"

# Regions
$region1 = "eastus"
$region2 = "eastus2"   # paired region for eastus

# Resource Groups
$rg1 = "cmaz-3o15j4kj-mod2-rg-01"
$rg2 = "cmaz-3o15j4kj-mod2-rg-02"

# VNet names
$vnet1 = "cmaz-3o15j4kj-mod2-vnet-01"
$vnet2 = "cmaz-3o15j4kj-mod2-vnet-02"

# Address spaces (65,536 possible IP addresses)
$addr1 = "10.2.0.0/16"
$addr2 = "10.24.0.0/16"

# Subnet names
$frontendSubnet1 = "frontend-01"
$frontendSubnet2 = "frontend-02"
$gatewaySubnet   = "GatewaySubnet"

# Subnet prefixes (256 possible IP addresses)
$frontendPrefix1 = "10.2.0.0/24"
$frontendPrefix2 = "10.24.0.0/24"

# Gateway subnet prefixes (32 possible IP addresses)
$gwPrefix1 = "10.2.255.0/27"
$gwPrefix2 = "10.24.255.0/27"

# VPN Gateway names
$gw1 = "cmaz-3o15j4kj-mod2-vpng-01"
$gw2 = "cmaz-3o15j4kj-mod2-vpng-02"

# Public IP names
$pip1 = "cmaz-3o15j4kj-mod2-pip-01"
$pip2 = "cmaz-3o15j4kj-mod2-pip-02"

# Connection names
$conn12 = "cmaz-3o15j4kj-mod2-vcn-01"  # vnet1 -> vnet2
$conn21 = "cmaz-3o15j4kj-mod2-vcn-02"  # vnet2 -> vnet1

# Mandatory tag applied to ALL required resources
$tags = @{ Creator = "nurgazy_sydykov@epam.com" }
