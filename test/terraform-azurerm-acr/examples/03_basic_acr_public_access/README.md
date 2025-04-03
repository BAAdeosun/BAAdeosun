# Basic Azure Container Registry - Public Access

This is an example for setting-up a an Azure Container Registry

This examples creates
  - Sets the different Azure Region representation ( location, location_short, location_cli ...) --> module "regions_master"
  - Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
  - A resource-group --> module "resource"
  - Creates a Premium Azure Container Registry with a secure configuration baseline
  - Enable Public Access
  - Configure ACR Public access
  - Set the default diagnostics settings (All Logs and metric) whith a Log Analytics workspace as destination
  - Creates two user managed identies, ACRPull and ACRPush, scoped at the ACR
  - Assign built-in ACR Roles: AcrPull AcrPush to the respective Roles

> IMPORTANT
> Ensure your account used for deploying the terraform has sufficient rights to assign roles to identities

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Main.tf file content

Please replace the modules source and version with your relevant information

```hcl
# Please specify local values
locals {
  custom_name                   = "acrtesting836d004"
  stack                         = "ectl"
  landing_zone_slug             = "db"
  location                      = "westeurope"
  resource_group_name           = "terraform-module-acr-rg4"
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

  allowed_cidrs   = []
  allowed_subnets = []
}
```
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | ../../module | n/a |
| <a name="module_base_tagging"></a> [base\_tagging](#module\_base\_tagging) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module | master |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module | master |
| <a name="module_regions"></a> [regions](#module\_regions) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-regions//module | master |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-resourcegroup//module | master |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-blobstorage//module | master |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.62.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_data"></a> [acr\_data](#output\_acr\_data) | n/a |
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | The Container Registry ID. |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | The URL that can be used to log into the container registry |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | The Container Registry name. |
| <a name="output_id_acr_pull"></a> [id\_acr\_pull](#output\_id\_acr\_pull) | Id to the user-managed identity with ACrPull Role |
| <a name="output_id_acr_push"></a> [id\_acr\_push](#output\_id\_acr\_push) | Id to the user-managed identity with ACrPush Role |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
