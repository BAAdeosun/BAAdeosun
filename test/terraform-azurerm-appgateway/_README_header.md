# Azure Application Gateway

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/storage-account/azurerm/)

Azure terraform module to create an Azure Application Gateway and manage related parameters.

## Configurations
The following Application Gateway configurations can be configured via variables or dedicated json files:
- backend_http_settings
- backend_address_pool
- http_listener
- request_routing_rule
- probes
- trusted_root_certificates
- authentication_certificates
- ssl_certificate
- url_path_maps

Use the examples provided to configure them via variables. If you preffer to use json files you need to create a json file in the root directory with the name of configuration i.e. url_path_maps.json and populate it with a json variable content. For example:

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

## Examples

[01_example.md](./examples/01_appgateway_publicip/README.md)
[02_example.md](./examples/02_appgateway_both_ips/README.md)
[03_example.md](./examples/03_appgateway_path_routing/README.md)
[04_example.md](./examples/04_appgateway_waf/README.md)
[05_example.md](./examples/05_appgateway_rewrite/README.md)
