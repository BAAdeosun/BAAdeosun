# Please specify local values
locals {
  stack                                   = "ectlwin6"
  landing_zone_slug                       = "lzs"
  location                                = "westeurope"
  sku                                     = "PerGB2018"
  workload_info                           = "ectl"
  virtual_network_address_space           = ["10.0.0.0/16"]
  address_prefixes                        = ["10.0.0.0/24"]
  virtual_network_flow_timeout_in_minutes = 4
  enable_delegation                       = false

  license_type = "Windows_Client"
  custom_image = {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-pron"
    version   = "latest"
  }

  # specify extra tags value if needed
  extra_tags = {
    department = "IT",
    production = "yes"
  }

  # specify base tagging values
  environment     = "TF Module Testing"
  application     = "Test application"
  cost_center     = "ECTL-EU"
  change          = "SERVICENOW-12513"
  owner           = "cmdb_owner"
  spoc            = "it@owner.com"
  tlp_colour      = "RED"
  cia_rating      = "1.0"
  technical_owner = "technical@owner.com"
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

module "vnet" {
  source                                  = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-vnet//module?ref=develop"
  landing_zone_slug                       = local.landing_zone_slug
  stack                                   = local.stack
  location                                = module.regions.location
  location_short                          = module.regions.location_short
  resource_group_name                     = module.resource_group.resource_group_name
  virtual_network_address_space           = local.virtual_network_address_space
  default_tags                            = module.base_tagging.base_tags
  extra_tags                              = local.extra_tags
  virtual_network_flow_timeout_in_minutes = local.virtual_network_flow_timeout_in_minutes
  diag_log_analytics_workspace_id         = module.log_analytics.log_analytics_workspace_id
}

module "subnet" {
  source               = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-subnet//module?ref=master"
  landing_zone_slug    = local.landing_zone_slug
  location_short       = module.regions.location_short
  resource_group_name  = module.resource_group.resource_group_name
  stack                = local.stack
  workload_info        = local.workload_info
  virtual_network_name = module.vnet.virtual_network_name
  address_prefixes     = local.address_prefixes
  enable_delegation    = local.enable_delegation
}

# Please specify source as git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-vmwindows//module?ref=master or with specific tag
module "vmwindows" {
  source                          = "../../module"
  stack                           = local.stack
  landing_zone_slug               = local.landing_zone_slug
  location                        = module.regions.location
  location_short                  = module.regions.location_short
  resource_group_name             = module.resource_group.resource_group_name
  default_tags                    = module.base_tagging.base_tags
  extra_tags                      = local.extra_tags
  diag_log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id
  subnet_id                       = module.subnet.subnet_id
  license_type                    = local.license_type
  custom_image                    = local.custom_image
}
