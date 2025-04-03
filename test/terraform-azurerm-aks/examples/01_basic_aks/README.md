# Basic Azure Kubernetes Service (AKS)

This is an example for setting-up Azure Kubernetes Service (AKS)
This examples creates

- An Azure Kubernetes Service (AKS) to different Azure Management Group & Resource Group representation (landing_zone_slug, location...) --> module "variables"; module "locals-naming"
- Instanciates a map object with the common Tags to be applied to all resources --> module "locals-tags"
- Using an existing resource-group --> (location...) --> module "variables"
- Generates SSH key for AKS
- Associate to a Log Analytic Workspace if enabled --> (diag_log_analytics_workspace_id) --> module "variables"
- Set the default diagnostics settings (All Logs and metric) whith a Log Analytics workspace as destination
- Optional: create node pools in a separate resource-group --> (node_resource_group) --> module "variables"

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Main.tf file content

Please replace the modules source and version with your relevant information

```hcl
# Please specify local values
locals {
  custom_name       = "aks-testcase-01"
  stack             = "infra"
  landing_zone_slug = "lzs"
  location          = "westeurope"
  location_short    = "euw"
  workload_info     = "ectl"

  kubernetes_version              = "1.25.6"
  agents_count                    = 1
  rbac_aad_admin_group_object_ids = ["8d5d3baa-1286-4bcd-8c6f-92c8084f56ba"]
  network_policy                  = "azure"
  sku_tier                        = "Standard"
  only_critical_addons_enabled    = true
  azure_policy_enabled            = false
  rbac_aad                        = true
  network_plugin                  = "azure"
  key_vault_secrets_provider = {
    secret_rotation_enabled = true
  }
  private_cluster_enabled             = false
  private_cluster_public_fqdn_enabled = false
  storage_profile_blob_driver_enabled = true
  storage_profile_disk_driver_enabled = true
  storage_profile_enabled             = true

  # specify extra tags value if needed
  extra_tags = {
    service    = "infra",
    production = "no"
  }

  # specify base tagging values
  environment     = "module-testing"
  application     = "networking"
  cost_center     = "ECTL-EU"
  change          = "j2c-12345"
  owner           = "devops"
  spoc            = "joe.blogs@local.com"
  tlp_colour      = "RED"
  cia_rating      = "1.0"
  technical_owner = "john.doe@local.com"

  # specify resource group
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

module "diag_log_analytics_workspace" {
  source              = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module?ref=master"
  landing_zone_slug   = local.landing_zone_slug
  stack               = local.stack
  location            = module.regions.location
  location_short      = module.regions.location_short
  resource_group_name = module.resource_group.resource_group_name
  default_tags        = module.base_tagging.base_tags
  extra_tags          = local.extra_tags
}

# Please specify source as git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/<<ADD_MODULE_NAME>>//module?ref=master or with specific tag
module "aks01" {
  source              = "../../module"
  custom_name         = local.custom_name
  landing_zone_slug   = local.landing_zone_slug
  stack               = local.stack
  location            = module.regions.location
  location_short      = module.regions.location_short
  resource_group_name = module.resource_group.resource_group_name
  # Default Tags
  default_tags = module.base_tagging.base_tags
  # Extra Tags
  extra_tags = local.extra_tags
  # Log Analytics Workspace Resource Id
  diag_log_analytics_workspace_id = module.diag_log_analytics_workspace.log_analytics_workspace_id

  kubernetes_version                  = local.kubernetes_version
  agents_count                        = local.agents_count
  rbac_aad_admin_group_object_ids     = local.rbac_aad_admin_group_object_ids
  network_policy                      = local.network_policy
  sku_tier                            = local.sku_tier
  only_critical_addons_enabled        = local.only_critical_addons_enabled
  azure_policy_enabled                = local.azure_policy_enabled
  rbac_aad                            = local.rbac_aad
  network_plugin                      = local.network_plugin
  key_vault_secrets_provider          = local.key_vault_secrets_provider
  private_cluster_enabled             = local.private_cluster_enabled
  private_cluster_public_fqdn_enabled = local.private_cluster_public_fqdn_enabled
  storage_profile_blob_driver_enabled = local.storage_profile_blob_driver_enabled
  storage_profile_disk_driver_enabled = local.storage_profile_disk_driver_enabled
  storage_profile_enabled             = local.storage_profile_enabled
}
```
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks01"></a> [aks01](#module\_aks01) | ../../module | n/a |
| <a name="module_base_tagging"></a> [base\_tagging](#module\_base\_tagging) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module | master |
| <a name="module_diag_log_analytics_workspace"></a> [diag\_log\_analytics\_workspace](#module\_diag\_log\_analytics\_workspace) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module | master |
| <a name="module_regions"></a> [regions](#module\_regions) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-regions//module | master |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-resourcegroup//module | master |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.68.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_host"></a> [admin\_host](#output\_admin\_host) | The `host` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. The Kubernetes cluster server host. |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | The `password` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A password or token used to authenticate to the Kubernetes cluster. |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | The `username` in the `azurerm_kubernetes_cluster`'s `kube_admin_config` block. A username used to authenticate to the Kubernetes cluster. |
| <a name="output_aks_cluster_id"></a> [aks\_cluster\_id](#output\_aks\_cluster\_id) | The AKS cluster ID created |
| <a name="output_aks_cluster_kubernetes_version"></a> [aks\_cluster\_kubernetes\_version](#output\_aks\_cluster\_kubernetes\_version) | The AKS cluster version |
| <a name="output_aks_cluster_name"></a> [aks\_cluster\_name](#output\_aks\_cluster\_name) | The AKS cluster ID name |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | The OIDC issuer URL that is associated with the cluster. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
