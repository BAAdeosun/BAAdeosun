<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
# AKS Windows Node Pool

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE)

## Example

[01\_basic\_nodepool](./examples/01\_basic\_nodepool/README.md)
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
   source  = "<module-path>"

   # Required variables
   kubernetes_cluster =
   kubernetes_cluster_resource_group_name =
   landing_zone_slug =

   # Optional variables
   add_node_pools = {}
   agents_labels = {}
   custom_name = ""
   default_tags = {}
   default_tags_enabled = true
   environment = ""
   extra_tags = {}
   stack = ""
   workload_info = ""
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.69 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_kubernetes_cluster.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | The details of existing Kubernetes Managed Cluster | `string` | n/a | yes |
| <a name="input_kubernetes_cluster_resource_group_name"></a> [kubernetes\_cluster\_resource\_group\_name](#input\_kubernetes\_cluster\_resource\_group\_name) | The Resource Group of the Managed Kubernetes Cluster. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym, it will beused to generate the resource name | `string` | n/a | yes |
| <a name="input_add_node_pools"></a> [add\_node\_pools](#input\_add\_node\_pools) | n/a | <pre>map(object({<br>    nodepool_name                   = string<br>    nodepool_node_count             = number<br>    nodepool_vm_size                = optional(string)<br>    enable_auto_scaling             = optional(bool)<br>    host_group_id                   = optional(string)<br>    capacity_reservation_group_id   = optional(string)<br>    custom_ca_trust_enabled         = optional(bool)<br>    enable_nodepool_host_encryption = optional(bool)<br>    enable_node_public_ip           = optional(bool)<br>    spot_eviction_policy            = optional(string)<br>    kubelet_config = optional(object({<br>      containers_cpu_manager_policy    = optional(string)<br>      containers_cpu_cfs_quota_enabled = optional(bool)<br>      containers_cpu_cfs_quota_period  = optional(string)<br>      image_disk_gc_high_threshold     = optional(number)<br>      image_disk_gc_low_threshold      = optional(number)<br>      topology_manager_policy          = optional(string)<br>      allowed_unsafe_sysctls_command   = optional(set(string))<br>      container_log_max_size_mb        = optional(number)<br>      container_log_max_files          = optional(number)<br>      pod_max_pid                      = optional(number)<br>    }))<br>    fips_enabled      = optional(bool)<br>    kubelet_disk_type = optional(string, "OS")<br>    nodepool_mode     = optional(string, "User")<br>    node_max_count    = optional(number)<br>    node_min_count    = optional(number)<br>    agent_max_pods    = optional(number)<br>    node_network_profile = optional(object({<br>      node_public_ip_tags = optional(map(string))<br>    }))<br>    spot_node_labels                  = optional(map(string))<br>    node_public_ip_prefix_id          = optional(string)<br>    spot_node_taints                  = optional(list(string))<br>    aks_agent_orchestrator_version    = optional(string)<br>    nodepool_os_disk_size_gb          = optional(number)<br>    nodepool_os_disk_type             = optional(string, "Managed")<br>    nodepool_os_sku                   = optional(string)<br>    nodepool_os_type                  = optional(string, "Windows")<br>    pod_subnet_id                     = optional(string)<br>    vmss_priority                     = optional(string, "Regular")<br>    vmss_proximity_placement_group_id = optional(string)<br>    spot_max_price                    = optional(number)<br>    nodepool_scale_down_mode          = optional(string, "Delete")<br>    ultra_ssd_enabled                 = optional(bool)<br>    vnet_subnet_id                    = optional(string)<br>    upgrade_settings = optional(object({<br>      max_surge = number<br>    }))<br>    windows_profile = optional(object({<br>      outbound_nat_enabled = optional(bool, true)<br>    }))<br>    workload_runtime   = optional(string)<br>    availability_zones = optional(set(string))<br>  }))</pre> | `{}` | no |
| <a name="input_agents_labels"></a> [agents\_labels](#input\_agents\_labels) | (Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created. | `map(string)` | `{}` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generate name if set | `string` | `""` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project environment | `string` | `""` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name | `string` | `""` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host_group_id"></a> [host\_group\_id](#output\_host\_group\_id) | Node Pool group ID |
| <a name="output_nodepool_name"></a> [nodepool\_name](#output\_nodepool\_name) | Name of the AKS Node Pool created |
| <a name="output_os_type"></a> [os\_type](#output\_os\_type) | Node Pool OS type |
## Contact

Atos

to regenerate this `README.md` file run in pwsh, in current directory:

`docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module`

`docker run --rm --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`

`docker stop pre; docker rm pre; docker run --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
