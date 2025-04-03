# Keyvault with Azure AD Policies

This is an example for setting-up a Keyvault with Azure AD  policies set.
This example

- Sets the different Azure Region representation ( location, location_short, location_cli ...) --> module "regions"
- Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
- A resource-group --> module "resource_group"
- A Keyvault with Azure AD Policies --> module "keyvault"

# Requirements
- RBAC permissions to set Azure AD Access Policies.

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Main.tf file content

Please replace the modules source and version with your relevant information

```hcl
# Please specify local values
locals {
  stack               = "test"
  landing_zone_slug   = "tst"
  location            = "westeurope"
  resource_group_name = "rg-tst-euw-terraform-keyvault-05"

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
  use_kv_access_policy            = true

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

  use_kv_access_policy = local.use_kv_access_policy
  access_policies      = local.access_policies
}
```
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_tagging"></a> [base\_tagging](#module\_base\_tagging) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module | master |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ../../module | n/a |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module | master |
| <a name="module_regions"></a> [regions](#module\_regions) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-regions//module | master |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-resourcegroup//module | master |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.67 |
## Resources

No resources.
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