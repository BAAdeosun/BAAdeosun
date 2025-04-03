# Keyvault with all features enabled

This is an example for setting-up a Keyvault with Private Endpoints, Azure AD policies, and Network ACLs.
This example

- Sets the different Azure Region representation ( location, location_short, location_cli ...) --> module "regions"
- Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
- A resource-group --> module "resource_group"
- A VNet --> module "virtual_network"
- A subnet --> module "pe_subnet"
- A Private DNS Zone --> module "private_dns_zone"
- A Keyvault with Azure AD policies --> module "keyvault"

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Main.tf file content

Please replace the modules source and version with your relevant information

```hcl
# Please specify local values
locals {
  stack               = "test"
  landing_zone_slug   = "tst"
  location            = "westeurope"
  resource_group_name = "rg-tst-euw-terraform-keyvault-06"

  # specify extra tags value if needed
  extra_tags = {
    tag1 = "",
    a    = ""
  }

  # specify base tagging values
  environment     = "TF Module Testing"
  application     = "Test application"
  cost_center     = "ECTL-EU"
  change          = "SERVICENOW-12513"
  owner           = "cmdb_owner"
  spoc            = "financial@owner.com"
  tlp_colour      = "RED"
  cia_rating      = "1.0"
  technical_owner = "technical@owner.com"

  tenant_id                       = "68292071-2b48-425a-b859-92e55e18dd33"
  sku                             = "standard"
  enable_private_endpoint         = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = false
  enabled_rbac_authorization      = false
  purge_protection_enabled        = false
  public_network_access_enabled   = true
  soft_delete_retention_days      = 14

  use_kv_access_policy = true
  access_policies = [
    # Access policies for users
    {
      azure_ad_user_principal_names = ["denis.balan.external_atos.net#EXT#@tgaaccountecttaz.onmicrosoft.com"]
      key_permissions               = ["Get", "List"]
      secret_permissions            = ["Set", "Get", "List", "Delete", "Purge"]
      certificate_permissions       = ["Get", "List", "Import"]
      storage_permissions           = ["Backup", "Get", "List", "Recover"]
    },

    # Access policies for AD Groups
    {
      azure_ad_group_names    = ["Test-RBAC"]
      key_permissions         = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
      certificate_permissions = ["Get", "Import", "List"]
      storage_permissions     = ["Backup", "Get", "List", "Recover"]
    },

    # Access policies for Azure AD Service Principals
    {
      azure_ad_service_principal_names = ["sp-terraform-test-01"]
      key_permissions                  = ["Get", "List"]
      secret_permissions               = ["Get", "List"]
      certificate_permissions          = ["Get", "Import", "List"]
      storage_permissions              = ["Backup", "Get", "List", "Recover"]
    }
  ]

  # VNet
  virtual_network_address_space           = ["10.0.0.0/28"]
  virtual_network_flow_timeout_in_minutes = 20

  # Subnet
  subnet_address_spaces = ["10.0.0.0/28"]
  enable_delegation     = false

  service_endpoints = [
    "Microsoft.KeyVault"
  ]

  network_acls = {
    bypass         = "AzureServices"
    default_action = "Allow"

    ip_rules = [
      "1.1.1.1",
      "194.0.0.0/31"
    ]

    # One or more Subnet ID's to access this Key Vault.
    virtual_network_subnet_ids = [module.pe_subnet.subnet_id]
  }

  ## NSG
  nsg_security_rules = [
    # Required for CKV_AZURE_9: Ensure RDP Internet access is restricted
    {
      name                       = "CKV_AZURE_9",
      priority                   = "100"
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    # Required for CKV_AZURE_10: Ensure that SSH access is restricted from the internet
    {
      name                       = "CKV_AZURE_10"
      priority                   = "110"
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    # Required for CKV_AZURE_77: Ensure that UDP Services are restricted from the Internet
    {
      name                       = "CKV_AZURE_77"
      priority                   = "120"
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  flow_log_settings = {
    flow_log01 = {
      name                 = "tst01"
      network_watcher_name = "NetworkWatcher_westeurope"
      resource_group_name  = "NetworkWatcherRG"

      storage_account_id = "/subscriptions/65be8cee-9c91-4111-9bf3-e65f96ef73f1/resourceGroups/rg-tf-j2c-devops/providers/Microsoft.Storage/storageAccounts/stj2cdevopslogs001"
      enabled            = true
      version            = 2

      # Required for CKV_AZURE_12: Ensure that Network Security Group Flow Log retention period is 'greater than 90 days'
      retention_policy = {
        enabled = true
        days    = 120
      }

      traffic_analytics = {
        enabled               = true
        workspace_id          = "/subscriptions/65be8cee-9c91-4111-9bf3-e65f96ef73f1/resourceGroups/rg-tf-j2c-devops/providers/Microsoft.OperationalInsights/workspaces/logj2cdevopslaw001"
        workspace_region      = "westeurope"
        workspace_resource_id = "24563cdb-ce82-41bc-bd9b-bc9b91b2e79a"
        interval_in_minutes   = 60
      }
    }
  }


  # Private DNS Zone
  domain_name = "privatelink.vaultcore.azure.net"
}

module "regions" {
  source       = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-regions//module?ref=master"
  azure_region = local.location
}

module "base_tagging" {
  source          = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module?ref=master"
  environment     = local.environment
  application     = local.application
  cost_center     = local.cost_center
  change          = local.change
  owner           = local.owner
  spoc            = local.spoc
  tlp_colour      = local.tlp_colour
  cia_rating      = local.cia_rating
  technical_owner = local.technical_owner
}

module "resource_group" {
  source            = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-resourcegroup//module?ref=master"
  stack             = local.stack
  custom_name       = local.resource_group_name
  landing_zone_slug = local.landing_zone_slug
  default_tags      = module.base_tagging.base_tags
  location          = module.regions.location
  location_short    = module.regions.location_short
}

module "log_analytics" {
  source              = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module?ref=master"
  landing_zone_slug   = local.landing_zone_slug
  stack               = local.stack
  location            = module.regions.location
  location_short      = module.regions.location_short
  resource_group_name = module.resource_group.resource_group_name
  default_tags        = module.base_tagging.base_tags
  extra_tags          = local.extra_tags
  sku                 = local.sku
}

module "virtual_network" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-vnet//module?ref=develop"

  landing_zone_slug = local.landing_zone_slug
  stack             = local.stack
  location          = module.regions.location
  location_short    = module.regions.location_short
  default_tags      = module.base_tagging.base_tags

  resource_group_name                     = module.resource_group.resource_group_name
  virtual_network_address_space           = local.virtual_network_address_space
  virtual_network_flow_timeout_in_minutes = local.virtual_network_flow_timeout_in_minutes

  diag_log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id
}

module "pe_subnet" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-subnet//module?ref=develop"

  landing_zone_slug = local.landing_zone_slug
  stack             = local.stack
  location_short    = module.regions.location_short

  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.virtual_network_name
  address_prefixes     = local.subnet_address_spaces

  enable_delegation = local.enable_delegation
  service_endpoints = local.service_endpoints
}

module "nsg" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-nsg//module?ref=develop"

  landing_zone_slug = local.landing_zone_slug
  stack             = local.stack
  location          = module.regions.location
  location_short    = module.regions.location_short
  default_tags      = module.base_tagging.base_tags

  resource_group_name = module.resource_group.resource_group_name

  security_rules    = local.nsg_security_rules
  flow_log_settings = local.flow_log_settings
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = module.pe_subnet.subnet_id
  network_security_group_id = module.nsg.nsg_id
}


module "private_dns_zone" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-privatednszone//module?ref=master"

  domain_name         = local.domain_name
  resource_group_name = module.resource_group.resource_group_name

  default_tags = module.base_tagging.base_tags
  extra_tags   = local.extra_tags

  virtual_network_link_ids = [
    module.virtual_network.virtual_network_id
  ]
}

# Please specify source as git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-privatednszone//module?ref=master or with specific tag
module "keyvault" {
  source = "../../module"

  stack             = local.stack
  landing_zone_slug = local.landing_zone_slug
  default_tags      = module.base_tagging.base_tags
  extra_tags        = local.extra_tags
  location          = module.regions.location
  location_short    = module.regions.location_short

  resource_group_name = module.resource_group.resource_group_name

  diag_log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  tenant_id = local.tenant_id
  sku       = local.sku

  enabled_for_deployment          = local.enabled_for_deployment
  enabled_for_disk_encryption     = local.enabled_for_disk_encryption
  enabled_for_template_deployment = local.enabled_for_template_deployment
  enabled_rbac_authorization      = local.enabled_rbac_authorization
  purge_protection_enabled        = local.purge_protection_enabled
  public_network_access_enabled   = local.public_network_access_enabled
  soft_delete_retention_days      = local.soft_delete_retention_days

  use_kv_access_policy = local.use_kv_access_policy
  access_policies      = local.access_policies

  network_acls = local.network_acls

  enable_private_endpoint    = local.enable_private_endpoint
  private_endpoint_subnet_id = module.pe_subnet.subnet_id
  private_dns_zone_id        = module.private_dns_zone.id
}
```
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_tagging"></a> [base\_tagging](#module\_base\_tagging) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module | master |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ../../module | n/a |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module | master |
| <a name="module_nsg"></a> [nsg](#module\_nsg) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-nsg//module | develop |
| <a name="module_pe_subnet"></a> [pe\_subnet](#module\_pe\_subnet) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-subnet//module | develop |
| <a name="module_private_dns_zone"></a> [private\_dns\_zone](#module\_private\_dns\_zone) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-privatednszone//module | master |
| <a name="module_regions"></a> [regions](#module\_regions) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-regions//module | master |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-resourcegroup//module | master |
| <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-vnet//module | develop |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.67 |
## Resources

| Name | Type |
|------|------|
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kv_admin"></a> [kv\_admin](#output\_kv\_admin) | Created identity with role `Key Vault Administrator`. |
| <a name="output_kv_crypto_user"></a> [kv\_crypto\_user](#output\_kv\_crypto\_user) | Created identity with role `Key Vault Crypto User`. |
| <a name="output_kv_id"></a> [kv\_id](#output\_kv\_id) | The Key Vault id. |
| <a name="output_kv_name"></a> [kv\_name](#output\_kv\_name) | The Key Vault name. |
| <a name="output_kv_secrets_user"></a> [kv\_secrets\_user](#output\_kv\_secrets\_user) | Created identity with role `Key Vault Secrets User`. |
| <a name="output_kv_vault_uri"></a> [kv\_vault\_uri](#output\_kv\_vault\_uri) | The Key Vault URI. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->