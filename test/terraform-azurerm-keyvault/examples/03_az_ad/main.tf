# Please specify local values
locals {
  stack               = "test"
  landing_zone_slug   = "tst"
  location            = "westeurope"
  resource_group_name = "rg-tst-euw-terraform-keyvault-03"

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
  enable_private_endpoint         = false
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = false
  enabled_rbac_authorization      = false
  purge_protection_enabled        = false
  public_network_access_enabled   = false
  soft_delete_retention_days      = 14

  # when use_kv_access_policy is false, it will create and output
  # managed identities for
  # kv_secrets_user - Key Vault Secrets User
  # kv_crypto_user - Key Vault Crypto User
  # kv_admin - Key Vault Administrator
  use_kv_access_policy = false

  # Log Analytics
  log_analytics_sku = "PerGB2018"
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
}
