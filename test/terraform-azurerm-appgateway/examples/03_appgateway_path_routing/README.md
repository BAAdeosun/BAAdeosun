<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Main.tf file content

Please replace the modules source and version with your relevant information

```hcl
# Please specify local values
locals {
  stack               = "test"
  landing_zone_slug   = "tribe"
  location            = "westeurope"
  resource_group_name = "terraform-module-appgw-rg3"

  # specify extra tags value if needed
  extra_tags = {
    tag1 = "value1",
    tag2 = "value2"
  }

  # specify SKU for the log analytics workspace
  sku = "PerGB2018"

  # specify base tagging values
  environment     = "TF Module Testing"
  application     = "Test application"
  cost_center     = "ECTL-EU"
  change          = "SERVICENOW-12513"
  owner           = "cmdb_owner"
  spoc            = "financial@owner.com"
  tlp_colour      = "RED"
  cia_rating      = "1.0.0"
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
  custom_name       = local.resource_group_name
  stack             = local.stack
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

module "subnet" {
  source               = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-subnet//module?ref=master"
  landing_zone_slug    = local.landing_zone_slug
  location_short       = module.regions.location_short
  resource_group_name  = "karminadel-j2c-ca001-ladr"
  virtual_network_name = "ps-sbx-vnet-001"
  stack                = local.stack
  workload_info        = "ectl"
  address_prefixes     = ["10.0.22.0/24"]
  enable_delegation    = false

  custom_name = "agwbasictest3"
}

module "appgw" {
  source              = "../../module"
  landing_zone_slug   = local.landing_zone_slug
  stack               = local.stack
  default_tags        = module.base_tagging.base_tags
  location            = module.regions.location
  location_short      = module.regions.location_short
  resource_group_name = module.resource_group.resource_group_name

  diag_log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id
  public_ip_allocation            = "Static"
  frontend_subnet_id              = module.subnet.subnet_id
  frontend_ip_configuration = [
    {
      public_ip_address = true
    }
  ]
  probes = [
    {
      name                = "google-probe"
      protocol            = "Http"
      host                = "www.google.com"
      path                = "/"
      interval            = 3
      timeout             = 10
      unhealthy_threshold = 10
      match = {
        status_code = ["200-302"]
      }
    },
    {
      name                = "ms-probe"
      protocol            = "Http"
      host                = "www.microsoft.com"
      path                = "/"
      interval            = 3
      timeout             = 10
      unhealthy_threshold = 10
      match = {
        status_code = ["200-302"]
      }
    }
  ]
  backend_http_settings = [
    {
      name                                = "google-http-settings"
      cookie_based_affinity               = "Disabled"
      port                                = 80
      protocol                            = "Http"
      request_timeout                     = 30
      pick_host_name_from_backend_address = true
      probe_name                          = "google-probe"
    },
    {
      name                                = "ms-http-settings"
      cookie_based_affinity               = "Disabled"
      port                                = 80
      protocol                            = "Http"
      request_timeout                     = 30
      pick_host_name_from_backend_address = true
      probe_name                          = "ms-probe"
    }
  ]
  backend_pools = [
    {
      name         = "GOOGLE"
      fqdns        = ["www.google.com"]
      ip_addresses = []
    },
    {
      name         = "MICROSOFT"
      fqdns        = ["www.microsoft.com"]
      ip_addresses = []
    }
  ]
  http_listeners = [
    {
      name               = "google-http_listener"
      frontend_port_name = "http-port"
      protocol           = "Http"
      host_name          = "www.google.com"
    },
    {
      name               = "ms-http_listener"
      frontend_port_name = "http-port"
      protocol           = "Http"
      host_name          = "www.microsoft.com"
    }
  ]
  routing_rules = [
    {
      name                       = "google-routing-rule"
      rule_type                  = "Basic"
      http_listener_name         = "google-http_listener"
      backend_address_pool_name  = "GOOGLE"
      backend_http_settings_name = "google-http-settings"
      url_path_map_name          = null
    },
    {
      name                       = "ms-routing-rule"
      rule_type                  = "Basic"
      http_listener_name         = "ms-http_listener"
      backend_address_pool_name  = "MICROSOFT"
      backend_http_settings_name = "ms-http-settings"
      url_path_map_name          = null
    }
  ]
  identity_ids = ["/subscriptions/9cd5e069-244a-4cfb-b16b-d80ef255245d/resourceGroups/karminadel-j2c-ca001-ladr/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-ca002-test-01"]
  autoscale_configuration = [
    {
      min_capacity = 1
      max_capacity = 2
    }
  ]
  url_path_maps = [
    {
      name                          = "urlPathMap1"
      default_backend_address_pool  = "GOOGLE"
      default_backend_http_settings = "google-http-settings"
      path_rules = {
        rule1 = {
          name                  = "pathRule1"
          backend_address_pool  = "MICROSOFT"
          backend_http_settings = "ms-http-settings"
          paths                 = ["/path2/*"]
        }
      }
    }
  ]
}
```
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_appgw"></a> [appgw](#module\_appgw) | ../../module | n/a |
| <a name="module_base_tagging"></a> [base\_tagging](#module\_base\_tagging) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module | master |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-loganalyticsworkspace//module | master |
| <a name="module_regions"></a> [regions](#module\_regions) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-regions//module | master |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-resourcegroup//module | master |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-subnet//module | master |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.63.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.4.3 |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Id of the application gateway. |
| <a name="output_name"></a> [name](#output\_name) | Name of the application gateway. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The IP address value that was allocated. |
| <a name="output_public_ip_fqdn"></a> [public\_ip\_fqdn](#output\_public\_ip\_fqdn) | The Public IP FQDN |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of appgw Public IP. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
