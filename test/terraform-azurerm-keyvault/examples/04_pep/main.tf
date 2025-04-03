# Please specify local values
locals {
  stack               = "test"
  landing_zone_slug   = "tst"
  location            = "westeurope"
  resource_group_name = "rg-tst-euw-terraform-keyvault-04"

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
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = false
  enabled_rbac_authorization      = false
  purge_protection_enabled        = false
  public_network_access_enabled   = false
  soft_delete_retention_days      = 14
  use_kv_access_policy            = true

  enable_private_endpoint    = true
  private_endpoint_subnet_id = "/subscriptions/ba294bf5-636c-4774-ad5c-c2a65d54e41a/resourceGroups/karminadel-j2c-ca001-ladr/providers/Microsoft.Network/virtualNetworks/vnet-ca001-ladr-dev/subnets/default"
  private_dns_zone_id        = "/subscriptions/ba294bf5-636c-4774-ad5c-c2a65d54e41a/resourceGroups/karminadel-j2c-ca001-ladr/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"

  # Log Analytics
  log_analytics_sku = "PerGB2018"

  # VNet
  virtual_network_address_space           = ["10.0.0.0/28"]
  virtual_network_flow_timeout_in_minutes = 20

  # Subnet
  enable_delegation = false

  # NSG
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
        workspace_id          = "24563cdb-ce82-41bc-bd9b-bc9b91b2e79a"
        workspace_region      = "westeurope"
        workspace_resource_id = "/subscriptions/65be8cee-9c91-4111-9bf3-e65f96ef73f1/resourceGroups/rg-tf-j2c-devops/providers/Microsoft.OperationalInsights/workspaces/logj2cdevopslaw001"
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
  sku                 = local.log_analytics_sku
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

module "subnet" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-subnet//module?ref=develop"

  landing_zone_slug = local.landing_zone_slug
  stack             = local.stack
  location_short    = module.regions.location_short

  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.virtual_network_name
  address_prefixes     = local.virtual_network_address_space

  enable_delegation = local.enable_delegation
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

  diag_log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = module.subnet.subnet_id
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

  tenant_id                       = local.tenant_id
  sku                             = local.sku
  enable_private_endpoint         = local.enable_private_endpoint
  enabled_for_deployment          = local.enabled_for_deployment
  enabled_for_disk_encryption     = local.enabled_for_disk_encryption
  enabled_for_template_deployment = local.enabled_for_template_deployment
  enabled_rbac_authorization      = local.enabled_rbac_authorization
  purge_protection_enabled        = local.purge_protection_enabled
  public_network_access_enabled   = local.public_network_access_enabled
  soft_delete_retention_days      = local.soft_delete_retention_days
  use_kv_access_policy            = local.use_kv_access_policy

  private_endpoint_subnet_id = module.subnet.subnet_id
  private_dns_zone_id        = module.private_dns_zone.id
}
