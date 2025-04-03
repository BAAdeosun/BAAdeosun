variable "adminuser" {
  description = "Administrator login for Virtual Machine"
  type        = string
  default     = "vmadmin"
}

variable "admin_password" {
  description = "The Password which should be used for the local-administrator on this Virtual Machine"
  type        = string
  default     = null
  sensitive   = true
}

variable "random_password_length" {
  description = "The desired length of random password created by this module"
  type        = number
  default     = 8
}

variable "virtual_machine_size" {
  description = "The Virtual Machine SKU for the Virtual Machine. Default is `Standard_B2ms`"
  type        = string
  default     = "Standard_B2ms"
}

variable "zone_id" {
  description = "Index of the Availability Zone which the Virtual Machine should be allocated in."
  type        = number
  default     = null
}

variable "availability_set_id" {
  description = "Id of the availability set in which host the Virtual Machine."
  type        = string
  default     = null
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of Managed Service Identity. Possible values are SystemAssigned or UserAssigned or both SystemAssigned, UserAssigned"
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "Invalid variable: ${var.identity_type}. Identity types supported: `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."
  }
}

variable "identity_ids" {
  description = "List of User Assigned Managed Identity IDs. This is required when identity_type is set to UserAssigned or both SystemAssigned, UserAssigned"
  type        = list(string)
  default     = null
}

variable "os_disk_size_gb" {
  description = "Specifies the size of the OS disk in gigabytes."
  type        = number
  default     = 150 # At least 127 GB
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`."
  type        = string
  default     = "Standard_LRS"
  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"], var.os_disk_storage_account_type)
    error_message = "Invalid variable: ${var.os_disk_storage_account_type}. Supported types: `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`"
  }
}

variable "os_disk_caching" {
  description = "Specifies the caching requirements for the OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`"
  type        = string
  default     = "ReadWrite"
  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.os_disk_caching)
    error_message = "Invalid variable: ${var.os_disk_caching}. Supported types: `None`, `ReadOnly` and `ReadWrite`"
  }
}

variable "os_disk_custom_name" {
  description = "Custom name for OS disk. Generated if not set."
  type        = string
  default     = null
}

variable "custom_data" {
  description = "Base64 encoded file of a bash script that gets run once by cloud-init upon VM creation"
  type        = string
  default     = null
}

variable "user_data" {
  description = "The Base64-Encoded User Data which should be used for this Virtual Machine."
  type        = string
  default     = null
}

variable "source_image_id" {
  description = "The ID of an Image which each Virtual Machine should be based on"
  type        = string
  default     = null
}

variable "custom_image" {
  description = "Provide the custom image"
  type = object({
    publisher = optional(string)
    offer     = optional(string)
    sku       = optional(string)
    version   = optional(string)
  })
  default = null
}

variable "allow_extension_operations" {
  description = "Allow extention operations"
  type        = bool
  default     = true
}

variable "patch_mode" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`."
  type        = string
  default     = "AutomaticByOS"
  validation {
    condition     = contains(["Manual", "AutomaticByOS", "AutomaticByPlatform"], var.patch_mode)
    error_message = "Invalid variable: ${var.patch_mode}. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`."
  }
}

variable "hotpatching_enabled" {
  description = "Should the VM be patched without requiring a reboot?"
  type        = bool
  default     = false
}

variable "enable_os_disk_write_accelerator" {
  description = "Enable OS sidk write accelerator"
  type        = bool
  default     = false
}

variable "maintenance_configuration_ids" {
  description = "List of maintenance configurations to attach to VM."
  type        = list(string)
  default     = []
}

variable "enable_encryption_at_host" {
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  type        = bool
  default     = false
}

variable "proximity_placement_group_id" {
  description = "The ID of the Proximity Placement Group which the Virtual Machine should be assigned to"
  type        = string
  default     = null
}

variable "data_disks" {
  description = "MV Data Disks"
  type = list(object({
    name                 = string
    storage_account_type = string
    disk_size_gb         = number
  }))
  default = []
  validation {
    condition = alltrue([
      for d in var.data_disks : contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"], d.storage_account_type)
    ])
    error_message = "Invalid variable `data_disks.storage_account_type`. Supported types: `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`"
  }
}

variable "disk_encryption_set_id" {
  description = "The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk"
  type        = string
  default     = null
}

variable "backup_policy_id" {
  description = "Backup policy ID from the Recovery Vault to attach the Virtual Machine to (value to `null` to disable backup)."
  type        = string
  default     = null
}

variable "backup_recovery_vault_name" {
  description = "Backup Recovery Vault name"
  type        = string
  default     = null
}

variable "spot_instance" {
  description = "True to deploy VM as a Spot Instance"
  type        = bool
  default     = false
}

variable "spot_instance_max_bid_price" {
  description = "The maximum price you're willing to pay for this VM in US Dollars; must be greater than the current spot price. `-1` If you don't want the VM to be evicted for price reasons."
  type        = number
  default     = -1
}

variable "spot_instance_eviction_policy" {
  description = "Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are `Deallocate` and `Delete`."
  type        = string
  default     = "Deallocate"
  validation {
    condition     = contains(["Deallocate", "Delete"], var.spot_instance_eviction_policy)
    error_message = "Invalid variable: ${var.spot_instance_eviction_policy}. Possible values are `Deallocate` and `Delete`"
  }
}

variable "additional_unattend_content" {
  description = "The XML formatted content that is added to the unattend.xml file for the specified path and component"
  type        = string
  default     = null
}

variable "additional_unattend_content_setting" {
  description = "The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`."
  type        = string
  default     = "FirstLogonCommands"
  validation {
    condition     = contains(["AutoLogon", "FirstLogonCommands"], var.additional_unattend_content_setting)
    error_message = "Invalid variable: ${var.additional_unattend_content_setting}. Possible values are `AutoLogon` and `FirstLogonCommands`."
  }
}

variable "enable_automatic_updates" {
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine"
  type        = bool
  default     = true
}

variable "license_type" {
  description = "Specifies the type of on-premise license which should be used for this Virtual Machine."
  type        = string
  default     = "None"
  validation {
    condition     = contains(["None", "Windows_Client", "Windows_Server"], var.license_type)
    error_message = "Invalid variable: ${var.license_type}. Possible values are `None`, `Windows_Client`, `Windows_Server`."
  }
}

variable "secure_boot_enabled" {
  description = "Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine."
  type        = bool
  default     = false
}

variable "vtpm_enabled" {
  description = "Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine."
  type        = bool
  default     = false
}

variable "timezone" {
  description = "VM timezone."
  type        = string
  default     = "UTC"
}

variable "virtual_machine_scale_set_id" {
  description = "Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within."
  type        = string
  default     = null
}

variable "provision_vm_agent" {
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine?"
  type        = bool
  default     = true
}

variable "vm_extension" {
  description = "VM extension settings"
  type = list(object({
    name                        = string
    publisher                   = string
    type                        = string
    type_handler_version        = string
    auto_upgrade_minor_version  = optional(bool)
    automatic_upgrade_enabled   = optional(bool)
    failure_suppression_enabled = optional(bool)
    settings                    = optional(string)
    protected_settings          = optional(string)
    protected_settings_from_key_vault = optional(object({
      secret_url      = string
      source_vault_id = string
    }))
  }))
  default = null
}
