# Please specify local values
locals {
  custom_name                   = "acrtesting836d002"
  stack                         = "ectl"
  landing_zone_slug             = "db"
  location                      = "westeurope"
  resource_group_name           = "terraform-module-acr-rg2"
  sku                           = "PerGB2018"
  enable_private_endpoint       = false
  private_endpoint_subnet_id    = null
  private_dns_zone_id           = null
  public_network_access_enabled = false

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

module "storage_account" {
  source = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-blobstorage//module?ref=master"

  stack                           = local.stack
  landing_zone_slug               = local.landing_zone_slug
  location                        = module.regions.location
  location_short                  = module.regions.location_short
  resource_group_name             = module.resource_group.resource_group_name
  default_tags                    = module.base_tagging.base_tags
  extra_tags                      = local.extra_tags
  diag_log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id
  enable_private_endpoint         = local.enable_private_endpoint
}


# Please specify source as git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-webapplinux//module?ref=master or with specific tag
module "acr" {
  source                          = "../../module"
  custom_name                     = local.custom_name
  stack                           = local.stack
  landing_zone_slug               = local.landing_zone_slug
  location                        = module.regions.location
  location_short                  = module.regions.location_short
  resource_group_name             = module.resource_group.resource_group_name
  default_tags                    = module.base_tagging.base_tags
  extra_tags                      = local.extra_tags
  diag_log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id
  diag_storage_account_id         = module.storage_account.storage_account_id
  enable_private_endpoint         = local.enable_private_endpoint
  private_endpoint_subnet_id      = local.private_endpoint_subnet_id
  private_dns_zone_id             = local.private_dns_zone_id
  public_network_access_enabled   = local.public_network_access_enabled

  allowed_cidrs                    = []
  allowed_subnets                  = []
  data_endpoint_enabled            = false
  enable_managed_identity_creation = true
}
