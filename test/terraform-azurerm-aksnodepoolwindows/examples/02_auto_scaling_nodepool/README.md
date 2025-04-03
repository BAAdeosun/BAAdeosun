# Basic Azure Kubernetes Service (AKS) Windows Node Pool with auto scaling enabled

This is an example for setting-up Windows Node Pool with auto scaling to an existing Azure Kubernetes Cluster
This examples creates

- Sets the different Azure Region representation ( location, location_short, location_cli ...) --> module "regions"
- Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
- Creates node pool with auto scaling enabled to existing Kubernetes Cluster --> module "kubernetes_cluster"
- Creates a Resource Group --> module "resource_group"
- Set the default diagnostics settings (All Logs and metric) whith a Log Analytics workspace as destination --> module "log_analytics"

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Main.tf file content

Please replace the modules source and version with your relevant information

```hcl
# Please specify local values
locals {
  custom_name       = "win01"
  stack             = "aksz"
  landing_zone_slug = "lzs"
  location          = "westeurope"
  location_short    = "euw"
  workload_info     = "ectl"

  # specify kubernetes values
  kubernetes_version              = "1.25.6"
  agents_count                    = 5
  agents_max_count                = 200
  agents_min_count                = 50
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

  # specify kubernetes noodpool values
  node_pools1 = {
    nodepool_name                     = "basic"
    enable_auto_scaling               = true
    nodepool_node_count               = 10
    kubelet_disk_type                 = "OS"
    node_max_count                    = 10
    agent_max_pods                    = 110
    node_min_count                    = 3
    nodepool_mode                     = "User"
    nodepool_os_disk_size_gb          = 200
    nodepool_os_disk_type             = "Managed"
    nodepool_os_sku                   = "Windows2022"
    nodepool_os_type                  = "Windows"
    vmss_proximity_placement_group_id = null
    ultra_ssd_enabled                 = false
    upgrade_settings = {
      max_surge = 1
    }
    nodepool_vm_size   = "Standard_D2s_v3"
    vnet_subnet_id     = null
    workload_runtime   = null
    availability_zones = ["1", "2"]
  }

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

module "aks" {
  source                              = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-aks//module?ref=master"
  landing_zone_slug                   = local.landing_zone_slug
  stack                               = local.stack
  location                            = module.regions.location
  location_short                      = module.regions.location_short
  resource_group_name                 = module.resource_group.resource_group_name
  default_tags                        = module.base_tagging.base_tags
  extra_tags                          = local.extra_tags
  diag_log_analytics_workspace_id     = module.diag_log_analytics_workspace.log_analytics_workspace_id
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

# Please specify source as git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/<<ADD_MODULE_NAME>>//module?ref=master or with specific tag
module "nodepool_windows02" {
  source            = "../../module"
  custom_name       = local.custom_name
  landing_zone_slug = local.landing_zone_slug
  stack             = local.stack
  default_tags      = module.base_tagging.base_tags
  # Extra Tags
  extra_tags = local.extra_tags
  # AKS Nodepool values
  add_node_pools = {
    node_pools1 = local.node_pools1
  }
  kubernetes_cluster                     = module.aks.aks_cluster_name
  kubernetes_cluster_resource_group_name = module.resource_group.resource_group_name

  depends_on = [module.aks]
}
```
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-aks//module | master |
| <a name="module_base_tagging"></a> [base\_tagging](#module\_base\_tagging) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module | master |
| <a name="module_diag_log_analytics_workspace"></a> [diag\_log\_analytics\_workspace](#module\_diag\_log\_analytics\_workspace) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module | master |
| <a name="module_nodepool_windows02"></a> [nodepool\_windows02](#module\_nodepool\_windows02) | ../../module | n/a |
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
| <a name="output_host_group_id"></a> [host\_group\_id](#output\_host\_group\_id) | Node Pool group ID |
| <a name="output_nodepool_name"></a> [nodepool\_name](#output\_nodepool\_name) | Name of the AKS Node Pool created |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | Node Pool OS flavour |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
