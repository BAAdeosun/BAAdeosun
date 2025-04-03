variable "key_vault_secrets_provider" {
  description = <<EOT
"Enable AKS built-in Key Vault secrets provider. If enabled, an identity is created by the AKS itself and exported from this module."
secret_rotation_enabled - (Optional) Should the secret store CSI driver on the AKS
secret_rotation_interval - (Optional) The interval to poll for secret rotation. This attribute is only set when secret_rotation is true and defaults to 2m
EOT
  type = object({
    secret_rotation_enabled  = optional(bool)
    secret_rotation_interval = optional(string)
  })
  default = null
}

variable "storage_profile_blob_driver_enabled" {
  type        = bool
  description = "(Optional) Is the Blob CSI driver enabled? Defaults to `false`"
  default     = false
}

variable "storage_profile_disk_driver_enabled" {
  type        = bool
  description = "(Optional) Is the Disk CSI driver enabled? Defaults to `true`"
  default     = true
}

variable "storage_profile_disk_driver_version" {
  type        = string
  description = "(Optional) Disk CSI Driver version to be used. Possible values are `v1` and `v2`. Defaults to `v1`."
  validation {
    condition     = anytrue([var.storage_profile_disk_driver_version == "v1", var.storage_profile_disk_driver_version == "v2"])
    error_message = "Possible values for ${var.storage_profile_disk_driver_version} are `v1` and `v2`"
  }
  default = "v1"
}

variable "storage_profile_enabled" {
  description = "Enable storage profile"
  type        = bool
  default     = false
  nullable    = false
}

variable "storage_profile_file_driver_enabled" {
  type        = bool
  description = "(Optional) Is the File CSI driver enabled? Defaults to `true`"
  default     = true
}

variable "storage_profile_snapshot_controller_enabled" {
  type        = bool
  description = "(Optional) Is the Snapshot Controller enabled? Defaults to `true`"
  default     = true
}
