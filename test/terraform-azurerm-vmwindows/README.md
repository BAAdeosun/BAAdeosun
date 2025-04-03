<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
# Azure Windows Virtual Machine
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/)

This module creates an Azure Windows Virtual machine.

  - It deploys VM with dedicated admin user and password
  - It applies a default diagnostics settings
  - It assigns VM IP address

## Example
[01\_basic\_vm.md](./examples/01\_basic\_vm/README.md)

[02\_advanced\_vm\_with\_data\_disk.md](./examples/02\_advanced\_vm\_with\_data\_disk/README.md)

[03\_advanced\_vm\_with\_public\_ip.md](./examples/03\_advanced\_vm\_with\_public\_ip/README.md)

[04\_advanced\_vm\_size.md](./examples/04\_advanced\_vm\_size/README.md)

[05\_advanced\_vm\_predefined\_image.md](./examples/05\_advanced\_vm\_predefined\_image/README.md)

[06\_advanced\_vm\_custom\_image.md](./examples/06\_advanced\_vm\_custom\_image/README.md)

[07\_advanced\_vm\_image\_id.md](./examples/07\_advanced\_vm\_image\_id/README.md)
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
   additional_unattend_content = null
   additional_unattend_content_setting = "FirstLogonCommands"
   admin_password = null
   adminuser = "vmadmin"
   allow_extension_operations = true
   availability_set_id = null
   backup_policy_id = null
   backup_recovery_vault_name = null
   certificate_secret_url = null
   custom_data = null
   custom_image = null
   custom_ipconfig_name = null
   custom_name = ""
   data_disks = []
   default_tags = {}
   diag_default_setting_name = "default"
   diag_log_categories = []
   diag_metric_categories = [
  "AllMetrics"
]
   diag_storage_account_id = null
   diagnostics_storage_account_name = null
   disk_encryption_set_id = null
   disk_extra_tags = {}
   dns_servers = []
   enable_accelerated_networking = false
   enable_automatic_updates = true
   enable_encryption_at_host = false
   enable_ip_forwarding = false
   enable_monitor_diagnostic_setting = true
   enable_os_disk_write_accelerator = false
   extra_tags = {}
   hostname = ""
   hotpatching_enabled = false
   identity_ids = null
   identity_type = "SystemAssigned"
   internal_dns_name_label = null
   license_type = "None"
   listener_protocol = "Http"
   log_analytics_destination_type = "Dedicated"
   maintenance_configuration_ids = []
   network_security_group_id = null
   nic_extra_tags = {}
   os_disk_caching = "ReadWrite"
   os_disk_custom_name = null
   os_disk_size_gb = 150
   os_disk_storage_account_type = "Standard_LRS"
   patch_mode = "AutomaticByOS"
   provision_vm_agent = true
   proximity_placement_group_id = null
   public_ip_address_id = null
   random_password_length = 8
   secure_boot_enabled = false
   security_rules = []
   source_image_id = null
   spot_instance = false
   spot_instance_eviction_policy = "Deallocate"
   spot_instance_max_bid_price = -1
   static_private_ip = null
   subnet_id = null
   timezone = "UTC"
   user_data = null
   virtual_machine_scale_set_id = null
   virtual_machine_size = "Standard_B2ms"
   vm_extension = null
   vtpm_enabled = false
   windows_distribution_list = {
  "mssql2017dev": {
    "offer": "SQL2017-WS2019",
    "publisher": "MicrosoftSQLServer",
    "sku": "sqldev",
    "version": "latest"
  },
  "mssql2017ent": {
    "offer": "SQL2017-WS2019",
    "publisher": "MicrosoftSQLServer",
    "sku": "enterprise",
    "version": "latest"
  },
  "mssql2017exp": {
    "offer": "SQL2017-WS2019",
    "publisher": "MicrosoftSQLServer",
    "sku": "express",
    "version": "latest"
  },
  "mssql2017std": {
    "offer": "SQL2017-WS2019",
    "publisher": "MicrosoftSQLServer",
    "sku": "standard",
    "version": "latest"
  },
  "mssql2019dev": {
    "offer": "sql2019-ws2019",
    "publisher": "MicrosoftSQLServer",
    "sku": "sqldev",
    "version": "latest"
  },
  "mssql2019ent": {
    "offer": "sql2019-ws2019",
    "publisher": "MicrosoftSQLServer",
    "sku": "enterprise",
    "version": "latest"
  },
  "mssql2019ent-byol": {
    "offer": "sql2019-ws2019-byol",
    "publisher": "MicrosoftSQLServer",
    "sku": "enterprise",
    "version": "latest"
  },
  "mssql2019std": {
    "offer": "sql2019-ws2019",
    "publisher": "MicrosoftSQLServer",
    "sku": "standard",
    "version": "latest"
  },
  "mssql2019std-byol": {
    "offer": "sql2019-ws2019-byol",
    "publisher": "MicrosoftSQLServer",
    "sku": "standard",
    "version": "latest"
  },
  "windows2012r2dc": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2012-R2-Datacenter",
    "version": "latest"
  },
  "windows2016dc": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2016-Datacenter",
    "version": "latest"
  },
  "windows2016dccore": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2016-Datacenter-Server-Core",
    "version": "latest"
  },
  "windows2019dc": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2019-Datacenter",
    "version": "latest"
  },
  "windows2019dc-containers": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2019-Datacenter-with-Containers",
    "version": "latest"
  },
  "windows2019dc-containers-g2": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2019-datacenter-with-containers-g2",
    "version": "latest"
  },
  "windows2019dc-gensecond": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2019-datacenter-gensecond",
    "version": "latest"
  },
  "windows2019dc-gs": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2019-datacenter-gs",
    "version": "latest"
  },
  "windows2019dccore": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2019-Datacenter-Core",
    "version": "latest"
  },
  "windows2019dccore-g2": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2019-datacenter-core-g2",
    "version": "latest"
  },
  "windows2022dc": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2022-Datacenter",
    "version": "latest"
  },
  "windows2022dc-gensecond": {
    "offer": "WindowsServer",
    "publisher": "MicrosoftWindowsServer",
    "sku": "2022-datacenter-g2",
    "version": "latest"
  }
}
   windows_distribution_name = "windows2019dc"
   workload_info = ""
   zone_id = null
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.62.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
## Resources

| Name | Type |
|------|------|
| [azurerm_backup_protected_vm.backup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_protected_vm) | resource |
| [azurerm_maintenance_assignment_virtual_machine.maintenace_configurations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_virtual_machine) | resource |
| [azurerm_managed_disk.data_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.nsga](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_virtual_machine_data_disk_attachment.data_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_extension.extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.vmwindows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.passwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym, it will beused to generate the resource name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group the resources will belong to | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project, Application or Workload identifier | `string` | n/a | yes |
| <a name="input_additional_unattend_content"></a> [additional\_unattend\_content](#input\_additional\_unattend\_content) | The XML formatted content that is added to the unattend.xml file for the specified path and component | `string` | `null` | no |
| <a name="input_additional_unattend_content_setting"></a> [additional\_unattend\_content\_setting](#input\_additional\_unattend\_content\_setting) | The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`. | `string` | `"FirstLogonCommands"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Password which should be used for the local-administrator on this Virtual Machine | `string` | `null` | no |
| <a name="input_adminuser"></a> [adminuser](#input\_adminuser) | Administrator login for Virtual Machine | `string` | `"vmadmin"` | no |
| <a name="input_allow_extension_operations"></a> [allow\_extension\_operations](#input\_allow\_extension\_operations) | Allow extention operations | `bool` | `true` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | Id of the availability set in which host the Virtual Machine. | `string` | `null` | no |
| <a name="input_backup_policy_id"></a> [backup\_policy\_id](#input\_backup\_policy\_id) | Backup policy ID from the Recovery Vault to attach the Virtual Machine to (value to `null` to disable backup). | `string` | `null` | no |
| <a name="input_backup_recovery_vault_name"></a> [backup\_recovery\_vault\_name](#input\_backup\_recovery\_vault\_name) | Backup Recovery Vault name | `string` | `null` | no |
| <a name="input_certificate_secret_url"></a> [certificate\_secret\_url](#input\_certificate\_secret\_url) | The Secret URL of a Key Vault Certificate, which must be specified when protocol is set to Https. | `string` | `null` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | Base64 encoded file of a bash script that gets run once by cloud-init upon VM creation | `string` | `null` | no |
| <a name="input_custom_image"></a> [custom\_image](#input\_custom\_image) | Provide the custom image | <pre>object({<br>    publisher = optional(string)<br>    offer     = optional(string)<br>    sku       = optional(string)<br>    version   = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_custom_ipconfig_name"></a> [custom\_ipconfig\_name](#input\_custom\_ipconfig\_name) | Custom name for the IP config of the NIC. Generated if not set. | `string` | `null` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generate name if set | `string` | `""` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | MV Data Disks | <pre>list(object({<br>    name                 = string<br>    storage_account_type = string<br>    disk_size_gb         = number<br>  }))</pre> | `[]` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_diag_default_setting_name"></a> [diag\_default\_setting\_name](#input\_diag\_default\_setting\_name) | Name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_diag_log_categories"></a> [diag\_log\_categories](#input\_diag\_log\_categories) | List of categories to enable in the diagnostic settings | `list(string)` | `[]` | no |
| <a name="input_diag_metric_categories"></a> [diag\_metric\_categories](#input\_diag\_metric\_categories) | List of metric categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_diag_storage_account_id"></a> [diag\_storage\_account\_id](#input\_diag\_storage\_account\_id) | Storage Account Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_diagnostics_storage_account_name"></a> [diagnostics\_storage\_account\_name](#input\_diagnostics\_storage\_account\_name) | Name of the Storage Account in which store vm diagnostics | `string` | `null` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk | `string` | `null` | no |
| <a name="input_disk_extra_tags"></a> [disk\_extra\_tags](#input\_disk\_extra\_tags) | Disk tags | `map(string)` | `{}` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of dns servers | `list(string)` | `[]` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | Should Accelerated Networking be enabled? Defaults to `false`. | `bool` | `false` | no |
| <a name="input_enable_automatic_updates"></a> [enable\_automatic\_updates](#input\_enable\_automatic\_updates) | Specifies if Automatic Updates are Enabled for the Windows Virtual Machine | `bool` | `true` | no |
| <a name="input_enable_encryption_at_host"></a> [enable\_encryption\_at\_host](#input\_enable\_encryption\_at\_host) | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host? | `bool` | `false` | no |
| <a name="input_enable_ip_forwarding"></a> [enable\_ip\_forwarding](#input\_enable\_ip\_forwarding) | Should IP Forwarding be enabled? Defaults to false | `bool` | `false` | no |
| <a name="input_enable_monitor_diagnostic_setting"></a> [enable\_monitor\_diagnostic\_setting](#input\_enable\_monitor\_diagnostic\_setting) | Enable monitor diagnostic setting | `bool` | `true` | no |
| <a name="input_enable_os_disk_write_accelerator"></a> [enable\_os\_disk\_write\_accelerator](#input\_enable\_os\_disk\_write\_accelerator) | Enable OS sidk write accelerator | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags | `map(string)` | `{}` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Custom name for the Virtual Machine Hostname | `string` | `""` | no |
| <a name="input_hotpatching_enabled"></a> [hotpatching\_enabled](#input\_hotpatching\_enabled) | Should the VM be patched without requiring a reboot? | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of User Assigned Managed Identity IDs. This is required when identity\_type is set to UserAssigned or both SystemAssigned, UserAssigned | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Specifies the type of Managed Service Identity. Possible values are SystemAssigned or UserAssigned or both SystemAssigned, UserAssigned | `string` | `"SystemAssigned"` | no |
| <a name="input_internal_dns_name_label"></a> [internal\_dns\_name\_label](#input\_internal\_dns\_name\_label) | The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network | `string` | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the type of on-premise license which should be used for this Virtual Machine. | `string` | `"None"` | no |
| <a name="input_listener_protocol"></a> [listener\_protocol](#input\_listener\_protocol) | Specifies the protocol of listener. Possible values are `Http` or `Https`. | `string` | `"Http"` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. Recommended value is Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_maintenance_configuration_ids"></a> [maintenance\_configuration\_ids](#input\_maintenance\_configuration\_ids) | List of maintenance configurations to attach to VM. | `list(string)` | `[]` | no |
| <a name="input_network_security_group_id"></a> [network\_security\_group\_id](#input\_network\_security\_group\_id) | Network security group id associated with network interface | `list(string)` | `null` | no |
| <a name="input_nic_extra_tags"></a> [nic\_extra\_tags](#input\_nic\_extra\_tags) | Extra tags to set on the network interface. | `map(string)` | `{}` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | Specifies the caching requirements for the OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite` | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_custom_name"></a> [os\_disk\_custom\_name](#input\_os\_disk\_custom\_name) | Custom name for OS disk. Generated if not set. | `string` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Specifies the size of the OS disk in gigabytes. | `number` | `150` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`. | `string` | `"Standard_LRS"` | no |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`. | `string` | `"AutomaticByOS"` | no |
| <a name="input_provision_vm_agent"></a> [provision\_vm\_agent](#input\_provision\_vm\_agent) | Should the Azure VM Agent be provisioned on this Virtual Machine? | `bool` | `true` | no |
| <a name="input_proximity_placement_group_id"></a> [proximity\_placement\_group\_id](#input\_proximity\_placement\_group\_id) | The ID of the Proximity Placement Group which the Virtual Machine should be assigned to | `string` | `null` | no |
| <a name="input_public_ip_address_id"></a> [public\_ip\_address\_id](#input\_public\_ip\_address\_id) | VM public IP address id | `list(string)` | `null` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | The desired length of random password created by this module | `number` | `8` | no |
| <a name="input_secure_boot_enabled"></a> [secure\_boot\_enabled](#input\_secure\_boot\_enabled) | Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. | `bool` | `false` | no |
| <a name="input_security_rules"></a> [security\_rules](#input\_security\_rules) | "A list of security rules to add to the security group. Each rule should be a map of values to add. See the Readme.md file for further details."<br>    security\_rules = {<br>      name : "The name of the security rule."<br>      priority : "Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."<br>      direction : "A description for this rule. Restricted to 140 characters."<br>      access : "Specifies whether network traffic is allowed or denied. Possible values are 'Allow' and 'Deny'."<br>      protocol : "Network protocol this rule applies to. Possible values include 'Tcp', 'Udp', 'Icmp', 'Esp', 'Ah' or '*' (which matches all)."<br>      source\_port\_range : "Source Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'source\_port\_ranges' is not specified."<br>      source\_port\_ranges : "List of source ports or port ranges. This is required if 'source\_port\_range' is not specified."<br>      destination\_port\_range : "Destination Port or Range. Integer or range between '0' and '65535' or '*' to match any. This is required if 'destination\_port\_ranges' is not specified."<br>      destination\_port\_ranges : "List of destination ports or port ranges. This is required if 'destination\_port\_range' is not specified."<br>      source\_address\_prefix : "'CIDR 'or 'source IP range' or '*' to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'source\_address\_prefixes' is not specified."<br>      source\_address\_prefixes : "List of source address prefixes. Tags may not be used. This is required if 'source\_address\_prefix' is not specified."<br>      destination\_address\_prefix : "'CIDR' or 'destination IP range' or '*' to match any IP. Tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. This is required if 'destination\_address\_prefixes' is not specified."<br>      destination\_address\_prefixes : "List of destination address prefixes. Tags may not be used. This is required if 'destination\_address\_prefix' is not specified."<br>      source\_application\_security\_group\_ids : "A List of source Application Security Group IDs."<br>      destination\_application\_security\_group\_ids : "A List of destination Application Security Group IDs."<br>    } | `any` | `[]` | no |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | The ID of an Image which each Virtual Machine should be based on | `string` | `null` | no |
| <a name="input_spot_instance"></a> [spot\_instance](#input\_spot\_instance) | True to deploy VM as a Spot Instance | `bool` | `false` | no |
| <a name="input_spot_instance_eviction_policy"></a> [spot\_instance\_eviction\_policy](#input\_spot\_instance\_eviction\_policy) | Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are `Deallocate` and `Delete`. | `string` | `"Deallocate"` | no |
| <a name="input_spot_instance_max_bid_price"></a> [spot\_instance\_max\_bid\_price](#input\_spot\_instance\_max\_bid\_price) | The maximum price you're willing to pay for this VM in US Dollars; must be greater than the current spot price. `-1` If you don't want the VM to be evicted for price reasons. | `number` | `-1` | no |
| <a name="input_static_private_ip"></a> [static\_private\_ip](#input\_static\_private\_ip) | Static private IP. Private IP is dynamic if not set. | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet id VM belongs to | `string` | `null` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | VM timezone. | `string` | `"UTC"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The Base64-Encoded User Data which should be used for this Virtual Machine. | `string` | `null` | no |
| <a name="input_virtual_machine_scale_set_id"></a> [virtual\_machine\_scale\_set\_id](#input\_virtual\_machine\_scale\_set\_id) | Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. | `string` | `null` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The Virtual Machine SKU for the Virtual Machine. Default is `Standard_B2ms` | `string` | `"Standard_B2ms"` | no |
| <a name="input_vm_extension"></a> [vm\_extension](#input\_vm\_extension) | VM extension settings | <pre>list(object({<br>    name                        = string<br>    publisher                   = string<br>    type                        = string<br>    type_handler_version        = string<br>    auto_upgrade_minor_version  = optional(bool)<br>    automatic_upgrade_enabled   = optional(bool)<br>    failure_suppression_enabled = optional(bool)<br>    settings                    = optional(string)<br>    protected_settings          = optional(string)<br>    protected_settings_from_key_vault = optional(object({<br>      secret_url      = string<br>      source_vault_id = string<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_vtpm_enabled"></a> [vtpm\_enabled](#input\_vtpm\_enabled) | Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine. | `bool` | `false` | no |
| <a name="input_windows_distribution_list"></a> [windows\_distribution\_list](#input\_windows\_distribution\_list) | Pre-defined Azure Windows VM images list | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | <pre>{<br>  "mssql2017dev": {<br>    "offer": "SQL2017-WS2019",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "sqldev",<br>    "version": "latest"<br>  },<br>  "mssql2017ent": {<br>    "offer": "SQL2017-WS2019",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "enterprise",<br>    "version": "latest"<br>  },<br>  "mssql2017exp": {<br>    "offer": "SQL2017-WS2019",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "express",<br>    "version": "latest"<br>  },<br>  "mssql2017std": {<br>    "offer": "SQL2017-WS2019",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "standard",<br>    "version": "latest"<br>  },<br>  "mssql2019dev": {<br>    "offer": "sql2019-ws2019",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "sqldev",<br>    "version": "latest"<br>  },<br>  "mssql2019ent": {<br>    "offer": "sql2019-ws2019",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "enterprise",<br>    "version": "latest"<br>  },<br>  "mssql2019ent-byol": {<br>    "offer": "sql2019-ws2019-byol",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "enterprise",<br>    "version": "latest"<br>  },<br>  "mssql2019std": {<br>    "offer": "sql2019-ws2019",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "standard",<br>    "version": "latest"<br>  },<br>  "mssql2019std-byol": {<br>    "offer": "sql2019-ws2019-byol",<br>    "publisher": "MicrosoftSQLServer",<br>    "sku": "standard",<br>    "version": "latest"<br>  },<br>  "windows2012r2dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2012-R2-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2016dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2016-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2016dccore": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2016-Datacenter-Server-Core",<br>    "version": "latest"<br>  },<br>  "windows2019dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2019dc-containers": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-Datacenter-with-Containers",<br>    "version": "latest"<br>  },<br>  "windows2019dc-containers-g2": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-datacenter-with-containers-g2",<br>    "version": "latest"<br>  },<br>  "windows2019dc-gensecond": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-datacenter-gensecond",<br>    "version": "latest"<br>  },<br>  "windows2019dc-gs": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-datacenter-gs",<br>    "version": "latest"<br>  },<br>  "windows2019dccore": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-Datacenter-Core",<br>    "version": "latest"<br>  },<br>  "windows2019dccore-g2": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2019-datacenter-core-g2",<br>    "version": "latest"<br>  },<br>  "windows2022dc": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2022-Datacenter",<br>    "version": "latest"<br>  },<br>  "windows2022dc-gensecond": {<br>    "offer": "WindowsServer",<br>    "publisher": "MicrosoftWindowsServer",<br>    "sku": "2022-datacenter-g2",<br>    "version": "latest"<br>  }<br>}</pre> | no |
| <a name="input_windows_distribution_name"></a> [windows\_distribution\_name](#input\_windows\_distribution\_name) | Variable to pick an OS flavour for Windows based VM. Possible values include: winserver, wincore, winsql | `string` | `"windows2019dc"` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Index of the Availability Zone which the Virtual Machine should be allocated in. | `number` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_maintenance_configurations_assignments"></a> [maintenance\_configurations\_assignments](#output\_maintenance\_configurations\_assignments) | Maintenance configurations assignments configurations. |
| <a name="output_nic_id"></a> [nic\_id](#output\_nic\_id) | NIC id associated with vm. |
| <a name="output_vm_admin_password"></a> [vm\_admin\_password](#output\_vm\_admin\_password) | Virtual Machine admin password |
| <a name="output_vm_admin_username"></a> [vm\_admin\_username](#output\_vm\_admin\_username) | Virtual Machine admin username |
| <a name="output_vm_hostname"></a> [vm\_hostname](#output\_vm\_hostname) | Hostname of the Virtual Machine |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | ID of the Virtual Machine |
| <a name="output_vm_identity"></a> [vm\_identity](#output\_vm\_identity) | Identity block with principal ID |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | Name of the Virtual Machine |
| <a name="output_vm_nic_id"></a> [vm\_nic\_id](#output\_vm\_nic\_id) | ID of the Network Interface Configuration attached to the Virtual Machine |
| <a name="output_vm_nic_ip_configuration_name"></a> [vm\_nic\_ip\_configuration\_name](#output\_vm\_nic\_ip\_configuration\_name) | Name of the IP Configuration for the Network Interface Configuration attached to the Virtual Machine |
| <a name="output_vm_nic_name"></a> [vm\_nic\_name](#output\_vm\_nic\_name) | Name of the Network Interface Configuration attached to the Virtual Machine |
| <a name="output_vm_os_disk"></a> [vm\_os\_disk](#output\_vm\_os\_disk) | Virtual Machine OS disk |
| <a name="output_vm_private_ip_address"></a> [vm\_private\_ip\_address](#output\_vm\_private\_ip\_address) | Private IP address of the Virtual Machine |
| <a name="output_vm_public_ip_id"></a> [vm\_public\_ip\_id](#output\_vm\_public\_ip\_id) | Public IP ID of the Virtual Machine |
## Contact

Atos

to regenerate this `README.md` file run in pwsh, in current directory

` docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module `

` docker run --rm --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a `

` docker stop pre; docker rm pre; docker run --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a `
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
