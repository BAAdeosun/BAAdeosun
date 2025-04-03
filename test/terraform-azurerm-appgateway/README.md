<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
# Azure Application Gateway

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/storage-account/azurerm/)

Azure terraform module to create an Azure Application Gateway and manage related parameters.

## Configurations
The following Application Gateway configurations can be configured via variables or dedicated json files:
- backend\_http\_settings
- backend\_address\_pool
- http\_listener
- request\_routing\_rule
- probes
- trusted\_root\_certificates
- authentication\_certificates
- ssl\_certificate
- url\_path\_maps

Use the examples provided to configure them via variables. If you preffer to use json files you need to create a json file in the root directory with the name of configuration i.e. url\_path\_maps.json and populate it with a json variable content. For example:

url\_path\_maps = [
  {
    name                          = "urlPathMap1"
    default\_backend\_address\_pool  = "GOOGLE"
    default\_backend\_http\_settings = "google-http-settings"
    path\_rules = {
      rule1 = {
        name                  = "pathRule1"
        backend\_address\_pool  = "MICROSOFT"
        backend\_http\_settings = "ms-http-settings"
        paths                 = ["/path2/*"]
      }
    }
  }
]

## Examples

[01\_example.md](./examples/01\_appgateway\_publicip/README.md)
[02\_example.md](./examples/02\_appgateway\_both\_ips/README.md)
[03\_example.md](./examples/03\_appgateway\_path\_routing/README.md)
[04\_example.md](./examples/04\_appgateway\_waf/README.md)
[05\_example.md](./examples/05\_appgateway\_rewrite/README.md)
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
   source  = "<module-path>"

   # Required variables
   backend_http_settings =
   backend_pools =
   diag_log_analytics_workspace_id =
   frontend_ip_configuration =
   frontend_subnet_id =
   http_listeners =
   identity_ids =
   landing_zone_slug =
   location =
   location_short =
   public_ip_allocation =
   resource_group_name =
   routing_rules =
   stack =

   # Optional variables
   authentication_certificates = []
   autoscale_configuration = [
  {
    "max_capacity": 2,
    "min_capacity": 1
  }
]
   custom_name = ""
   custom_policies = []
   ddos_protection_mode = "VirtualNetworkInherited"
   ddos_protection_plan_id = null
   default_tags = {}
   diag_default_setting_name = "default"
   diag_log_categories = [
  "ApplicationGatewayAccessLog",
  "ApplicationGatewayPerformanceLog"
]
   diag_metric_categories = [
  "AllMetrics"
]
   diag_storage_account_id = null
   enable_http2 = true
   extra_tags = {}
   idle_timeout_in_minutes = null
   log_analytics_destination_type = "Dedicated"
   managed_policies_exclusions = []
   managed_policies_override = []
   probes = []
   rewrite_rule_sets = []
   sku = {
  "name": "WAF_v2",
  "tier": "WAF_v2"
}
   ssl_certificate = []
   trusted_root_certificates = []
   url_path_maps = []
   waf_configuration = null
   waf_enabled = true
   workload_info = ""
   zones = []
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.22 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.4.3 |
## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.app_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_web_application_firewall_policy.waf_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_application_firewall_policy) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | List of backend HTTP settings | <pre>list(object({<br>    name                                = string<br>    cookie_based_affinity               = string<br>    port                                = number<br>    protocol                            = string<br>    request_timeout                     = number<br>    affinity_cookie_name                = optional(string)<br>    path                                = optional(string)<br>    probe_name                          = optional(string)<br>    host_name                           = optional(string)<br>    pick_host_name_from_backend_address = optional(bool)<br>    authentication_certificate = optional(object({<br>      name = string<br>    }))<br>    trusted_root_certificate_names = optional(string)<br>    connection_draining = optional(object({<br>      enabled           = bool<br>      drain_timeout_sec = number<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_backend_pools"></a> [backend\_pools](#input\_backend\_pools) | List of backend pools | <pre>list(object({<br>    name         = string<br>    fqdns        = optional(list(string))<br>    ip_addresses = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | n/a | yes |
| <a name="input_frontend_ip_configuration"></a> [frontend\_ip\_configuration](#input\_frontend\_ip\_configuration) | Frontend IP configuration | <pre>list(object({<br>    public_ip_address               = bool<br>    private_ip_address              = optional(string)<br>    subnet_id                       = optional(string)<br>    private_ip_address_allocation   = optional(string)<br>    private_link_configuration_name = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_frontend_subnet_id"></a> [frontend\_subnet\_id](#input\_frontend\_subnet\_id) | The ID of the existing frontend subnet | `string` | n/a | yes |
| <a name="input_http_listeners"></a> [http\_listeners](#input\_http\_listeners) | List of HTTP listeners | <pre>list(object({<br>    name                 = string<br>    frontend_port_name   = string<br>    protocol             = string<br>    host_name            = optional(string)<br>    host_names           = optional(list(string))<br>    ssl_certificate_name = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | A list of User Assigned Managed Identity IDs to be assigned to this Application Gateway. | `list(string)` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym,it will be used to generate the resource name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_public_ip_allocation"></a> [public\_ip\_allocation](#input\_public\_ip\_allocation) | Type of public IP address allocation. Dynamic or Static | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the resources will be deployed | `string` | n/a | yes |
| <a name="input_routing_rules"></a> [routing\_rules](#input\_routing\_rules) | List of routing rules | <pre>list(object({<br>    name                       = string<br>    rule_type                  = string<br>    http_listener_name         = string<br>    backend_address_pool_name  = string<br>    backend_http_settings_name = string<br>    url_path_map_name          = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name. | `string` | n/a | yes |
| <a name="input_authentication_certificates"></a> [authentication\_certificates](#input\_authentication\_certificates) | List of authentication certificates | <pre>list(object({<br>    name = string<br>    data = string<br>  }))</pre> | `[]` | no |
| <a name="input_autoscale_configuration"></a> [autoscale\_configuration](#input\_autoscale\_configuration) | Minimum/maximum capacity for autoscaling. | <pre>list(object({<br>    min_capacity = number<br>    max_capacity = number<br>  }))</pre> | <pre>[<br>  {<br>    "max_capacity": 2,<br>    "min_capacity": 1<br>  }<br>]</pre> | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generated name if set | `string` | `""` | no |
| <a name="input_custom_policies"></a> [custom\_policies](#input\_custom\_policies) | List of custom firewall policies. See https://docs.microsoft.com/en-us/azure/application-gateway/custom-waf-rules-overview. | <pre>list(object({<br>    name      = string<br>    rule_type = string<br>    action    = string<br>    match_conditions = list(object({<br>      match_variables = list(object({<br>        match_variable = string<br>        selector       = string<br>      })),<br>      operator           = string<br>      negation_condition = bool<br>      match_values       = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_ddos_protection_mode"></a> [ddos\_protection\_mode](#input\_ddos\_protection\_mode) | The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited. | `string` | `"VirtualNetworkInherited"` | no |
| <a name="input_ddos_protection_plan_id"></a> [ddos\_protection\_plan\_id](#input\_ddos\_protection\_plan\_id) | The ID of the DDOS protection plan only rrequired if DDOS protection mode is Enabled | `string` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_diag_default_setting_name"></a> [diag\_default\_setting\_name](#input\_diag\_default\_setting\_name) | Name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_diag_log_categories"></a> [diag\_log\_categories](#input\_diag\_log\_categories) | List of categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "ApplicationGatewayAccessLog",<br>  "ApplicationGatewayPerformanceLog"<br>]</pre> | no |
| <a name="input_diag_metric_categories"></a> [diag\_metric\_categories](#input\_diag\_metric\_categories) | List of metric categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_diag_storage_account_id"></a> [diag\_storage\_account\_id](#input\_diag\_storage\_account\_id) | Storage Account Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | A boolean variable that defines if http2 is enabled. Supported values are true or false | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. | `number` | `null` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. Recommended value is Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_managed_policies_exclusions"></a> [managed\_policies\_exclusions](#input\_managed\_policies\_exclusions) | List of managed firewall policies exclusions | <pre>list(object({<br>    match_variable          = string<br>    selector_match_operator = string<br>    selector                = string<br>  }))</pre> | `[]` | no |
| <a name="input_managed_policies_override"></a> [managed\_policies\_override](#input\_managed\_policies\_override) | List of managed firewall policies overrides. See https://docs.microsoft.com/en-us/azure/web-application-firewall/ag/application-gateway-crs-rulegroups-rules | <pre>list(object({<br>    rule_group_name = string<br>    disabled_rules  = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_probes"></a> [probes](#input\_probes) | List of probes | <pre>list(object({<br>    name                                      = string<br>    protocol                                  = string<br>    host                                      = string<br>    path                                      = string<br>    interval                                  = number<br>    timeout                                   = number<br>    unhealthy_threshold                       = number<br>    pick_host_name_from_backend_http_settings = optional(bool)<br>    minimum_servers                           = optional(number)<br>    match = object({<br>      status_code = list(string)<br>      body        = optional(string)<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_rewrite_rule_sets"></a> [rewrite\_rule\_sets](#input\_rewrite\_rule\_sets) | List of rewrite rules. See https://docs.microsoft.com/en-us/azure/application-gateway/rewrite-http-headers-url | <pre>list(object({<br>    name = string<br>    rewrite_rule = list(object({<br>      rule_name     = string<br>      rule_sequence = number<br>      condition = list(object({<br>        ignore_case = bool<br>        negate      = bool<br>        pattern     = string<br>        variable    = string<br>      }))<br>      request_header_configuration = list(object({<br>        header_name  = string<br>        header_value = string<br>      }))<br>      response_header_configuration = list(object({<br>        header_name  = string<br>        header_value = string<br>      }))<br>      url = list(object({<br>        path         = string<br>        query_string = string<br>        reroute      = bool<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | A list defining the SKU of the Application Gateway being provisioned | <pre>object({<br>    name     = string<br>    tier     = string<br>    capacity = optional(number)<br>  })</pre> | <pre>{<br>  "name": "WAF_v2",<br>  "tier": "WAF_v2"<br>}</pre> | no |
| <a name="input_ssl_certificate"></a> [ssl\_certificate](#input\_ssl\_certificate) | List of SSL Certificates | <pre>list(object({<br>    name                = optional(string)<br>    data                = optional(string)<br>    password            = optional(string)<br>    key_vault_secret_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_trusted_root_certificates"></a> [trusted\_root\_certificates](#input\_trusted\_root\_certificates) | List of trusted root certificates | <pre>list(object({<br>    name = string<br>    data = string<br>  }))</pre> | `[]` | no |
| <a name="input_url_path_maps"></a> [url\_path\_maps](#input\_url\_path\_maps) | Map of URL path maps for application gateway. | <pre>list(object({<br>    name                          = string<br>    default_backend_address_pool  = string<br>    default_backend_http_settings = string<br>    path_rules = map(object({<br>      name                  = string<br>      backend_address_pool  = string<br>      backend_http_settings = string<br>      paths                 = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_waf_configuration"></a> [waf\_configuration](#input\_waf\_configuration) | Configuration block for WAF. | <pre>object({<br>    rule_set_type            = string<br>    rule_set_version         = string<br>    file_upload_limit_mb     = optional(number)<br>    mode                     = optional(string)<br>    max_request_body_size_kb = optional(number)<br>  })</pre> | `null` | no |
| <a name="input_waf_enabled"></a> [waf\_enabled](#input\_waf\_enabled) | Set to true to enable WAF on Application Gateway. | `bool` | `true` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Specifies a list of Availability Zones in which this Application Gateway service should be located. Changing this forces a new Application Gateway service to be created. | `list(string)` | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Id of the application gateway. |
| <a name="output_name"></a> [name](#output\_name) | Name of the application gateway. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The IP address value that was allocated. |
| <a name="output_public_ip_fqdn"></a> [public\_ip\_fqdn](#output\_public\_ip\_fqdn) | The Public IP FQDN |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of appgw Public IP. |
## Contact

ATOS

to regenerate this `README.md` file run in pwsh, in current directory

`docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module`
`docker run --rm --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`

`docker stop pre; docker rm pre; docker run --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
