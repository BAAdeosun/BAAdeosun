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

[01_advanced_acr_geo_redundant](./examples/01_advanced_acr_geo_redundant/README.md)
[02_basic_acr](./examples/02_basic_acr/README.md)
[03_basic_acr_public_access](./examples/03_basic_acr_public_access/README.md)
[04_basic_acr_zone_redundant](./examples/04_basic_acr_zone_redundant/README.md)
