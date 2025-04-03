<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
# Azure Container Registry
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/)

This Terraform module creates an Azure Container Registry.

  - It applies a default diagnostics settings
  - It configures a private endpoint if private access is enabled
  - It configures user managed identities scoped at the ACR for AcrPull and AcrPush roles

> Important
> Ensures you have the required permissions to associate a role to a user managed identity
> Set `enable_managed_identity_creation` to true to enable RBAC role assignment.
> Maximum length of resource name is 50 characters.

## Example

[01\_advanced\_acr\_geo\_redundant](./examples/01\_advanced\_acr\_geo\_redundant/README.md)
[02\_basic\_acr](./examples/02\_basic\_acr/README.md)
[03\_basic\_acr\_public\_access](./examples/03\_basic\_acr\_public\_access/README.md)
[04\_basic\_acr\_zone\_redundant](./examples/04\_basic\_acr\_zone\_redundant/README.md)
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
   source  = "<module-path>"

   # Required variables
   diag_log_analytics_workspace_id =
   landing_zone_slug =
   location =
   location_short =
   resource_group_name =
   stack =

   # Optional variables
   admin_enabled = false
   allowed_cidrs = []
   allowed_subnets = []
   anonymous_pull_enabled = false
   azure_services_bypass_allowed = true
   custom_name = ""
   data_endpoint_enabled = false
   default_tags = {}
   diag_default_setting_name = "default"
   diag_log_categories = [
  "ContainerRegistryRepositoryEvents",
  "ContainerRegistryLoginEvents"
]
   diag_metric_categories = [
  "AllMetrics"
]
   diag_storage_account_id = null
   enable_managed_identity_creation = false
   enable_private_endpoint = true
   extra_tags = {}
   georeplication_locations = null
   images_retention_days = 90
   images_retention_enabled = false
   log_analytics_destination_type = "Dedicated"
   private_dns_zone_id = null
   private_endpoint_subnet_id = null
   public_network_access_enabled = false
   quarantine_policy_enabled = false
   sku = "Premium"
   trust_policy_enabled = false
   workload_info = ""
   zone_redundancy_enabled = false
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.52.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.registrypep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.rbac_acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_acr_push](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.acr_push](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym,it will be used to generate the resource name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name. | `string` | n/a | yes |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Boolean value that indicates whether acr has admin user enabled | `bool` | `false` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs to allow on the registry | `list(string)` | `[]` | no |
| <a name="input_allowed_subnets"></a> [allowed\_subnets](#input\_allowed\_subnets) | List of VNet/Subnet IDs to allow on the registry. | `list(string)` | `[]` | no |
| <a name="input_anonymous_pull_enabled"></a> [anonymous\_pull\_enabled](#input\_anonymous\_pull\_enabled) | Boolean value that indicates whether acr has anonymous pull enabled | `bool` | `false` | no |
| <a name="input_azure_services_bypass_allowed"></a> [azure\_services\_bypass\_allowed](#input\_azure\_services\_bypass\_allowed) | Whether to allow trusted Azure services to access a network restricted Container Registry. | `bool` | `true` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generated name if set | `string` | `""` | no |
| <a name="input_data_endpoint_enabled"></a> [data\_endpoint\_enabled](#input\_data\_endpoint\_enabled) | Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU). | `bool` | `false` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_diag_default_setting_name"></a> [diag\_default\_setting\_name](#input\_diag\_default\_setting\_name) | Name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_diag_log_categories"></a> [diag\_log\_categories](#input\_diag\_log\_categories) | List of categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "ContainerRegistryRepositoryEvents",<br>  "ContainerRegistryLoginEvents"<br>]</pre> | no |
| <a name="input_diag_metric_categories"></a> [diag\_metric\_categories](#input\_diag\_metric\_categories) | List of metric categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_diag_storage_account_id"></a> [diag\_storage\_account\_id](#input\_diag\_storage\_account\_id) | Storage Account Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_enable_managed_identity_creation"></a> [enable\_managed\_identity\_creation](#input\_enable\_managed\_identity\_creation) | Feature toggle to disable Managed Identity creation. | `bool` | `false` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Wether the container registry is using a priavte endpoint | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_georeplication_locations"></a> [georeplication\_locations](#input\_georeplication\_locations) | A list of Azure locations where the container Registry should be geo-replicated. Only activated on Premium SKU.<br>  Supported properties are:<br>    location                  = string<br>    zone\_redundancy\_enabled   = bool<br>    regional\_endpoint\_enabled = bool<br>    tags                      = map(string)<br>  or this can be a list of `string` (each element is a location) | <pre>list(object({<br>    location                  = string<br>    zone_redundancy_enabled   = bool<br>    regional_endpoint_enabled = bool<br>    tags                      = map(string)<br>  }))</pre> | `null` | no |
| <a name="input_images_retention_days"></a> [images\_retention\_days](#input\_images\_retention\_days) | Specifies the number of images retention days. | `number` | `90` | no |
| <a name="input_images_retention_enabled"></a> [images\_retention\_enabled](#input\_images\_retention\_enabled) | Specifies whether images retention is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. Recommended value is Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Id of the private DNS Zone  to be used by the container registry private endpoint | `string` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | Id for the subnet used by the container registry private endpoint | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the Container Registry is accessible publicly. | `bool` | `false` | no |
| <a name="input_quarantine_policy_enabled"></a> [quarantine\_policy\_enabled](#input\_quarantine\_policy\_enabled) | Boolean value that indicates whether quarantine policy is enabled. Only available with premium SKU | `bool` | `false` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the the container registry. Possible values are `Basic`, `Standard` and `Premium`. | `string` | `"Premium"` | no |
| <a name="input_trust_policy_enabled"></a> [trust\_policy\_enabled](#input\_trust\_policy\_enabled) | Specifies whether the trust policy is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Boolean value that indicates whether acr zone redundancy is enabled. Only available with premium SKU | `bool` | `false` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_data"></a> [acr\_data](#output\_acr\_data) | Details of the Azure Container Registry (ACR) including the login server URL, admin username, and admin password. |
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | The Container Registry ID. |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | The URL that can be used to log into the container registry |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | The Container Registry name. |
| <a name="output_id_acr_pull"></a> [id\_acr\_pull](#output\_id\_acr\_pull) | Id to the user-managed identity with ACrPull Role |
| <a name="output_id_acr_push"></a> [id\_acr\_push](#output\_id\_acr\_push) | Id to the user-managed identity with ACrPush Role |
## Contact

Atos

to regenerate this `README.md` file run in pwsh, in current directory
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
