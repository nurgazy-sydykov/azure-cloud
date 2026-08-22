# Create Resource Groups (with required tag)

. "$PSScriptRoot/01-variables.ps1"

# Resource Group 1
New-AzResourceGroup `
    -Name $rg1 `
    -Location $region1 `
    -Tag $tags

# Resource Group 2
New-AzResourceGroup `
    -Name $rg2 `
    -Location $region2 `
    -Tag $tags
