# Azure Windows Virtual Machine
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/)

This module creates an Azure Windows Virtual machine.

  - It deploys VM with dedicated admin user and password
  - It applies a default diagnostics settings
  - It assigns VM IP address

## Example
[01_basic_vm.md](./examples/01_basic_vm/README.md)

[02_advanced_vm_with_data_disk.md](./examples/02_advanced_vm_with_data_disk/README.md)

[03_advanced_vm_with_public_ip.md](./examples/03_advanced_vm_with_public_ip/README.md)

[04_advanced_vm_size.md](./examples/04_advanced_vm_size/README.md)

[05_advanced_vm_predefined_image.md](./examples/05_advanced_vm_predefined_image/README.md)

[06_advanced_vm_custom_image.md](./examples/06_advanced_vm_custom_image/README.md)

[07_advanced_vm_image_id.md](./examples/07_advanced_vm_image_id/README.md)
