<!-- BEGIN_TF_DOCS -->
# Azure Key Vault
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/storage-account/azurerm/)

Azure terraform module to create a Key Vault instance

## Example

[01_basic.md](./examples/01_basic/README.md)
[02_firewall.md](./examples/02_firewall/README.md)
[03_az_ad.md](./examples/03_az_ad/README.md)
[04_pep.md](./examples/04_pep/README.md)
[05_access_policy.md](./examples/05_access_policy/README.md)
[06_full.md](./examples/06_full/README.md)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.22 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.36.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.50.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.keys](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.keyvault_pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.rbac_kv_uai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_self_sp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.uai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [azuread_group.adgrp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.adspn](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.adusr](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Specifies enabled\_for\_deployment. | `bool` | n/a | yes |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Specifies enabled\_for\_disk\_encryption. | `bool` | n/a | yes |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Specifies enabled\_for\_template\_deployment. | `bool` | n/a | yes |
| <a name="input_enabled_rbac_authorization"></a> [enabled\_rbac\_authorization](#input\_enabled\_rbac\_authorization) | Specifies enabled\_rbac\_authorization. | `bool` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym,it will beused to generate the resource nae | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Specifies purge\_protection\_enabled. | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the the container KeyVault. Possible values are `standard`, `premium` | `string` | n/a | yes |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | Specifies soft\_delete\_retention\_days. | `number` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name. | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Specifies tenant\_id. | `string` | n/a | yes |
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | List of access policies for the Key Vault. | <pre>list(object({<br>    azure_ad_group_names             = optional(list(string), [])<br>    object_ids                       = optional(list(string), [])<br>    azure_ad_user_principal_names    = optional(list(string), [])<br>    certificate_permissions          = optional(list(string), [])<br>    key_permissions                  = optional(list(string), [])<br>    secret_permissions               = optional(list(string), [])<br>    storage_permissions              = optional(list(string), [])<br>    azure_ad_service_principal_names = optional(list(string), [])<br>  }))</pre> | `[]` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generated name if set | `string` | `""` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_diag_default_setting_name"></a> [diag\_default\_setting\_name](#input\_diag\_default\_setting\_name) | Name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_diag_log_categories"></a> [diag\_log\_categories](#input\_diag\_log\_categories) | List of categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AuditEvent",<br>  "AzurePolicyEvaluationDetails"<br>]</pre> | no |
| <a name="input_diag_metric_categories"></a> [diag\_metric\_categories](#input\_diag\_metric\_categories) | List of metric categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_diag_retention_days"></a> [diag\_retention\_days](#input\_diag\_retention\_days) | The number of days for which the Retention Policy should apply | `number` | `30` | no |
| <a name="input_diag_storage_account_id"></a> [diag\_storage\_account\_id](#input\_diag\_storage\_account\_id) | Storage Account Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Wether the key vault is using a private endpoint. | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. Recommended value is Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Network rules to apply to key vault. | <pre>object({<br>    bypass         = string<br>    default_action = string<br>    # IP address or CIDR<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br>  })</pre> | `null` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Id of the private DNS Zone  to be used by the key vault private endpoint. | `string` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | Id for the subnet used by the key vault private endpoint | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the key vault is accessible publicly. | `bool` | `false` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A map of secrets for the Key Vault. | `map(string)` | `{}` | no |
| <a name="input_use_kv_access_policy"></a> [use\_kv\_access\_policy](#input\_use\_kv\_access\_policy) | Specifies use\_kv\_access\_policy. | `bool` | `true` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kv_assigned_identities"></a> [kv\_assigned\_identities](#output\_kv\_assigned\_identities) | n/a |
| <a name="output_kv_name"></a> [kv\_name](#output\_kv\_name) | n/a |
| <a name="output_kv_vault_uri"></a> [kv\_vault\_uri](#output\_kv\_vault\_uri) | n/a |

## Contact

to regenerate this `README.md` file run in pwsh, in current directory

` docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module `

` docker stop pre; docker rm pre; docker run -it --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform:nightly run -a `
<!-- END_TF_DOCS -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
# Azure Key Vault
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/storage-account/azurerm/)

Azure terraform module to create a Key Vault instance

## Example

[01\_basic.md](./examples/01\_basic/README.md)
[02\_firewall.md](./examples/02\_firewall/README.md)
[03\_az\_ad.md](./examples/03\_az\_ad/README.md)
[04\_pep.md](./examples/04\_pep/README.md)
[05\_access\_policy.md](./examples/05\_access\_policy/README.md)
[06\_full.md](./examples/06\_full/README.md)
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
   source  = "<module-path>"

   # Required variables
   landing_zone_slug =
   location =
   location_short =
   resource_group_name =
   stack =

   # Optional variables
   access_policies = []
   custom_name = ""
   default_tags = {}
   default_tags_enabled = true
   diag_default_setting_name = "default"
   diag_log_analytics_workspace_id = null
   diag_log_categories = [
  "AuditEvent",
  "AzurePolicyEvaluationDetails"
]
   diag_metric_categories = [
  "AllMetrics"
]
   diag_retention_days = 30
   diag_storage_account_id = null
   enable_private_endpoint = true
   enabled_for_deployment = false
   enabled_for_disk_encryption = true
   enabled_for_template_deployment = false
   enabled_rbac_authorization = true
   extra_tags = {}
   is_manual_connection = false
   log_analytics_destination_type = "Dedicated"
   network_acls = null
   private_dns_zone_id = null
   private_endpoint_subnet_id = null
   public_network_access_enabled = false
   purge_protection_enabled = true
   sku = "standard"
   soft_delete_retention_days = 7
   tenant_id = null
   use_kv_access_policy = false
   workload_info = ""
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.22 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.keyvault_pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.rbac_kv_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_kv_crypto_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_kv_secrets_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.kv_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.kv_crypto_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.kv_secrets_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azuread_group.adgrp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.adspn](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.adusr](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym, it will beused to generate the resource name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project, Application or Workload identifier | `string` | n/a | yes |
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | List of access policies for the Key Vault. | <pre>list(object({<br>    azure_ad_group_names             = optional(list(string), [])<br>    object_ids                       = optional(list(string), [])<br>    azure_ad_user_principal_names    = optional(list(string), [])<br>    certificate_permissions          = optional(list(string), [])<br>    key_permissions                  = optional(list(string), [])<br>    secret_permissions               = optional(list(string), [])<br>    storage_permissions              = optional(list(string), [])<br>    azure_ad_service_principal_names = optional(list(string), [])<br>  }))</pre> | `[]` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generate name if set | `string` | `""` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_diag_default_setting_name"></a> [diag\_default\_setting\_name](#input\_diag\_default\_setting\_name) | Name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_diag_log_categories"></a> [diag\_log\_categories](#input\_diag\_log\_categories) | List of categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AuditEvent",<br>  "AzurePolicyEvaluationDetails"<br>]</pre> | no |
| <a name="input_diag_metric_categories"></a> [diag\_metric\_categories](#input\_diag\_metric\_categories) | List of metric categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_diag_retention_days"></a> [diag\_retention\_days](#input\_diag\_retention\_days) | The number of days for which the Retention Policy should apply | `number` | `30` | no |
| <a name="input_diag_storage_account_id"></a> [diag\_storage\_account\_id](#input\_diag\_storage\_account\_id) | Storage Account Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Wether the key vault is using a private endpoint. | `bool` | `true` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Specifies enabled\_for\_deployment. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Specifies enabled\_for\_disk\_encryption. Defaults to true, as recommended by Defender for Cloud. | `bool` | `true` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Specifies enabled\_for\_template\_deployment. | `bool` | `false` | no |
| <a name="input_enabled_rbac_authorization"></a> [enabled\_rbac\_authorization](#input\_enabled\_rbac\_authorization) | Specifies enabled\_rbac\_authorization. | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. Recommended value is Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Network rules to apply to key vault. | <pre>object({<br>    bypass         = string<br>    default_action = string<br>    # IP address or CIDR<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br>  })</pre> | `null` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Id of the private DNS Zone  to be used by the key vault private endpoint. | `string` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | Id for the subnet used by the key vault private endpoint | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the key vault is accessible publicly. | `bool` | `false` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Specifies purge\_protection\_enabled. | `bool` | `true` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the the container KeyVault. Possible values are `standard`, `premium` | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | Specifies soft\_delete\_retention\_days. | `number` | `7` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Specifies tenant\_id. | `string` | `null` | no |
| <a name="input_use_kv_access_policy"></a> [use\_kv\_access\_policy](#input\_use\_kv\_access\_policy) | Specifies whether to use KeyVault access policy, `true` if yes, `false` to use Azure AD IAM RBAC. | `bool` | `false` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kv_admin"></a> [kv\_admin](#output\_kv\_admin) | Created identity with role `Key Vault Administrator`. |
| <a name="output_kv_crypto_user"></a> [kv\_crypto\_user](#output\_kv\_crypto\_user) | Created identity with role `Key Vault Crypto User`. |
| <a name="output_kv_id"></a> [kv\_id](#output\_kv\_id) | The Key Vault id. |
| <a name="output_kv_name"></a> [kv\_name](#output\_kv\_name) | The Key Vault name. |
| <a name="output_kv_secrets_user"></a> [kv\_secrets\_user](#output\_kv\_secrets\_user) | Created identity with role `Key Vault Secrets User`. |
| <a name="output_kv_vault_uri"></a> [kv\_vault\_uri](#output\_kv\_vault\_uri) | The Key Vault URI. |
## Contact

Atos

to regenerate this `README.md` file run in pwsh, in current directory:

`docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module`

`docker run --rm --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`

`docker stop pre; docker rm pre; docker run --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->